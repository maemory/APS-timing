%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% playbells.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is an auxiliary routine used by the talktimer package.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if bells=='Y'
  switch platform
  case 'win'
    switch bell 
    case 1, wavplay(bell1_data,bell1_fs,'async')
    case 2, wavplay(bell2_data,bell2_fs,'async')
    case 3, wavplay(bell3_data,bell3_fs,'async')
    end 
  case 'lin'
    switch bell    
    case 1, !play 1bell.wav 
    case 2, !play 2bells.wav 
    case 3, !play 3bells.wav 
    end
  case 'mac'
    switch bell    
    case 1, soundsc(bell1_data,bell1_fs)
    case 2, soundsc(bell2_data,bell2_fs)
    case 3, soundsc(bell3_data,bell3_fs)
    end
  end
end

