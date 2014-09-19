function [sessionData, N]=loadTimingData( fname )

%data_file=fopen('APS_DFD2011_setup.dat');
data_file=fopen(fname);
i=0;
while (i==0)||(isempty(sessionData{i})==false);
    i=i+1;
    sessionData(i)=textscan(data_file, '%s', 10, 'Delimiter', '\t');
end
fclose(data_file);
N=i-2;
