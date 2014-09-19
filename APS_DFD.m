%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% APS_DFD.m  version 1.1.2  - modified by Andrew Duggleby 12/08
% Minor modifications/bug fixes by Geoffrey Spedding  10/10
%   lines 51, 58 have sprintf function inserted so \n (or other) control
%       characters are interpreted correctly
%   line 58: sessionData{1}{10}, not {1}{9}
%   Set NLIN in preliminary data for number of lines in APS_DFD_SETUP.dat
% Minor modifications/bug fixes by Michael Emory  9/14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;  format compact;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% On the day of the conference, we have to do the following four things:
%
% Define your preferred font
% Check what is available with 'listfonts'

% Linux
%font='Palatino'
%font='luxiserif';
%font='luximono';
%font='Times';

% Other
%font='Palatino Linotype'
font='Luxi Serif';

%
% Define whether or not you want to play Bells ('Y' or 'N')
bells='N';
%
% Define your platform ('lin', 'win', or 'mac')
% (because the best sound command is different on each platform)
%platform='lin';
%platform='win';
platform='mac';

% Specify input file
% For simplicity, you can edit this using Microsoft Excel
timing_setup='setup/APS_DFD2014_setup.dat';

% This code will read in the schedule.  The last line sets the current day
% (which is 1 right now).  If you have to restart due to a change in
% schedule or otherwise, you need to set this to the appropriate day.
NLIN = 22;

% You should not have to modify anything below this point.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Room = sprintf('Generic');
delay=0;

% Define the window names
window_name='APS/DFD Conference';
initbells;  bell=1;  playbells;
[sessionData,N]=loadTimingData(timing_setup);

currentDay=num2str(sessionData{NLIN}{2});
istart=2;
while currentDay~=sessionData{istart}{1};
    istart=istart+1;
end

%% Loop over all the sessions of the entire conference
for i=istart:N %i=1 is the description of data
    session_text={sprintf(sessionData{i}{9})};
    start_time=[str2num(sessionData{i}{2}) str2num(sessionData{i}{3})];
    number_of_talks=str2num(sessionData{i}{4});
    talk_time=str2num(sessionData{i}{5});
    warning_time=str2num(sessionData{i}{6});
    qa_time=str2num(sessionData{i}{7});
    transition_time=str2num(sessionData{i}{8});
    wait_message=sprintf(sessionData{i}{10});
    test_bells=1;

    % run the schedule for each session
    session

    % At the end of the current day, system will stall till 2 hours prior
    % to the start of the next day's session
    if (str2num(sessionData{i}{1})<3);
        if (sessionData{i+1}{1}~=sessionData{i}{1})
            currentTime=clock;
            wait_time=5+(59-currentTime(6))+(59-currentTime(5))*60+(23-currentTime(4))*60*60;  %timer will start running 2 hours before the start of next day's session
            pause(wait_time)
        end
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
