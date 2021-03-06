%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% update_delay.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is an auxiliary routine used by the talktimer package.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This program ask for the user to enter either a '<' or '>' key to signal
% for a delay in the program.
% Key:
%   '>' or '.'  -->     add 1 minute delay to the clock
%   '<' or ','  -->     subtract 1 minute delay to the clock

f=get(cf,'CurrentCharacter');
if f=='>' | f=='.'
  delay=delay+1;
elseif f=='<' | f==','
  delay=delay-1;
end
start=start_time(1)*60+start_time(2)+delay;

% Display the current schedule delay on the screen
if delay==0
  set(h4,'String','') 
else
  set(h4,'String',sprintf('Current schedule delay: %d min',delay))
end

