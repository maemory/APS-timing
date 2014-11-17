%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% session.m   version 1.1.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The following Matlab script times a given number of talks of
% specified length and with a specified time interval between each talk.  
%
% This program was originally written by Thomas Bewley on 13 Nov 2001.
%
% For the latest version of this code, please visit:
%
%              http://turbulence.ucsd.edu/talktimer
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setting up screen display
screen=0;  previous_screen=-1;  cf=1;  figure(cf);
set(cf,'MenuBar','none'); set(cf,'Name',window_name); set(cf,'NumberTitle','off')

% Allow user to add delay to the schedule by hitting the following key(s)
% on the screen:
% '>' or '.' means add a minute to delay (behind schedule)
% '<' or ',' means subtract a minute to delay (ahead of schedule)
set(cf,'KeyPressFcn','update_delay')

%% Setting up start and current time
start=start_time(1)*60+start_time(2)+delay; %% starting time
interval=talk_time+qa_time+transition_time; %% number of minutes for each talk

current_time=fix(clock);
time=current_time(4)*60+current_time(5)-start;

%% Bell test
min1=-time-1;
test5=0;  test1=0;
if (bells=='Y' & test_bells)
    if min1>=5; test5=1; end
    if min1>=1; test1=1; end
end

%% Main program ==========================================================
%   There are total of six screens for each sessions:
%   Screen 0    -->     Waiting screen 
%                       (Show time left before the start of the session)
%   Screen 1    -->     Green talk screen 
%                       (Show time left till end of the current talk)
%   Screen 2    -->     Yellow talk screen 
%                       (Screen turns yellow when the talk has less than 1 minute left)
%   Screen 3    -->     Red Questions/Answer screen
%                       (Screen turns red for questions/answers)
%   Screen 4    -->     Transitions screen
%                       (Show time left till next talk)
%   Screen 5    -->     End of Sessions screen

if (time<number_of_talks*interval)
    while (screen<5)
        current_time=fix(clock);
        time=current_time(4)*60+current_time(5)-start;
        talk=1+floor(time/interval);

        if time<0
            screen=0;
            min1=-time-1;
        elseif time>number_of_talks*interval-transition_time-1
            screen=5;
            min1=0;
        elseif mod(time,interval)<talk_time-warning_time
            screen=1;
            min1=talk_time-mod(time,interval)-1;
        elseif mod(time,interval)<talk_time
            screen=2;
            min1=talk_time-mod(time,interval)-1;
        elseif mod(time,interval)<talk_time+qa_time
            screen=3;
            min1=talk_time+qa_time-mod(time,interval)-1;
        else
            screen=4;
            min1=interval-mod(time,interval)-1;
        end
        s=60-current_time(6);
        if s==60
            s=0;  min1=min1+1;
        end;
        sec1=mod(s,10);
        sec10=floor(s/10);
        min=sprintf('%d',min1);
        sec=sprintf(':%d%d',sec10,sec1);

        if previous_screen ~= screen
            clf;  axis off; set(cf,'DefaultTextFontName',font);
            set(cf,'DefaultTextFontUnits','normalized');
            h4=text(-0.05,0.02,''); set(h4,'HorizontalAlignment','left','FontSize',0.06)

            switch screen
                case 0
                    set(cf,'DefaultTextColor','white')
                    set(cf,'Color','black')
                    h0=text(0.48,1.05,session_text);
                    set(h0,'HorizontalAlignment','center','VerticalAlignment','top','FontSize',0.08)
                    h=text(-0.05,0.62,wait_message);
                    set(h,'HorizontalAlignment','left','FontSize',0.07)
                    [h1,h2]=drawtime(min,sec);
                    if test1
                        h3=text(-0.05,-0.05,'Test bells will sound 1 min prior to session.');
                        set(h3,'HorizontalAlignment','left','FontSize',0.06)
                    end
                    if test5
                        set(h3,'String','Test bells will sound 5 min prior to session.')
                    end
                case 1
                    set(cf,'DefaultTextColor','white')
                    set(cf,'Color',[0 0.75 0])
                    h0=text(0.48,1.05,session_text);
                    set(h0,'HorizontalAlignment','center','VerticalAlignment','top','FontSize',0.08)
                    if number_of_talks>1
                        h=text(-0.05,0.62,sprintf('Time left in talk #%d:',talk));
                    else
                        if qa_time>0
                            h=text(-0.05,0.62,sprintf('Time left in talk:'));
                        else
                            h=text(-0.05,0.62,sprintf('Time left:'));
                        end
                    end
                    set(h,'HorizontalAlignment','left','FontSize',0.07)
                    [h1,h2]=drawtime(min,sec);
                    bell=1;  playbells;
                case 2
                    set(cf,'DefaultTextColor','black')
                    set(cf,'Color','yellow')
                    h0=text(0.48,1.05,session_text);
                    set(h0,'HorizontalAlignment','center','VerticalAlignment','top','FontSize',0.08)
                    if number_of_talks>1
                        h=text(-0.05,0.62,sprintf('Time left in talk #%d:',talk));
                    else
                        h=text(-0.05,0.62,sprintf('Time left in talk:'));
                    end
                    set(h,'HorizontalAlignment','left','FontSize',0.07)
                    [h1,h2]=drawtime(min,sec);
                    bell=1;  playbells;
                case 3
                    set(cf,'DefaultTextColor','white')
                    set(cf,'Color','red')
                    h=text(0.48,0.9,'QUESTION/ANSWER PERIOD');
                    set(h,'HorizontalAlignment','center','FontSize',0.08)
                    h3=text(-0.05,0.62,'Time left:');
                    set(h3,'HorizontalAlignment','left','FontSize',0.07)
                    [h1,h2]=drawtime(min,sec);
                    bell=2;  playbells;
                case 4
                    set(cf,'DefaultTextColor','white')
                    set(cf,'Color','black')
                    h0=text(0.48,1.05,session_text);
                    set(h0,'HorizontalAlignment','center','VerticalAlignment','top','FontSize',0.08)
                    h3=text(-0.05,0.62,sprintf('Time until beginning of talk #%d:',talk+1));
                    set(h3,'HorizontalAlignment','left','FontSize',0.07)
                    [h1,h2]=drawtime(min,sec);
                    bell=3;  playbells;
                case 5
                    set(cf,'DefaultTextColor','white')
                    set(cf,'Color','black')
                    h=text(0.45,0.5,'SESSION COMPLETED.');
                    set(h,'HorizontalAlignment','center','FontSize',0.08)
                    bell=3;  playbells;
                    pause(5);
            end
            if delay ~= 0
                h4=text(-0.05,0.02,sprintf('Current schedule delay: %d min',delay));
            else
                h4=text(-0.05,0.02,'');
            end
            set(h4,'HorizontalAlignment','left','FontSize',0.06)

        else
            if screen==0
                if min1<5 & test5
                    min=sprintf('%d',min1+1);
                    sec=sprintf(':%d%d',sec10,0);
                    bell=1;  playbells;
                    test5=0;
                    set(h3,'String','Test bells will sound 1 min prior to session.')
                elseif min1<1 & test1
                    min=sprintf('%d',min1+1);
                    sec=sprintf(':%d%d',sec10,0);
                    bell=1;  playbells;
                    set(h3,'String','')
                    test1=0;
                end
            end
            set(h1,'String',min)
            set(h2,'String',sec)
        end

        previous_screen=screen;
        pause(0.1);
    end
end

set(cf,'KeyPressFcn','')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
