%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawtime.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is an auxiliary routine used by the talktimer package.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [h1,h2] = drawtime(min,sec)

h1=text(0.55,0.04,min);
set(h1,'HorizontalAlignment','right','VerticalAlignment','bottom','FontSize',0.48)
h2=text(0.55,0.10,sec);
set(h2,'HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',0.3)

return
