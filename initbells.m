%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initbells.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is an auxiliary routine used by the talktimer package.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ( (bells=='Y') & ( (platform=='win') | (platform=='mac') ))
  [bell1_data,bell1_fs,bits]=wavread('1bell');
  [bell2_data,bell2_fs,bits]=wavread('2bells');
  [bell3_data,bell3_fs,bits]=wavread('3bells');
end

