function PCAD_Quarterly(sd,ed)

%---------------------------------------------------------------------
%Directory bookkeeping
addpath('/home/pcad/PCAD_Quarterly')

tstart=time(sd);
tstop=time(ed);

sd_str = num2str(sd);
ed_str = num2str(ed);

dn_pcad=['PCAD_Q_' num2str(sd) '_' num2str(ed)];
mkdir(dn_pcad);
dn_prop=['PROP_Q_' num2str(sd) '_' num2str(ed)];
mkdir(dn_prop);

%---------------------------------------------------------------------
% Run Python plots
disp(' ')
disp('Running Python Trending Plots...')
disp(' ')
system('rm *.pyc');
system(strcat(['/proj/sot/ska/bin/python run_quarterlies.py "', sd_str(1:4), ':', sd_str(5:7), '" "', ed_str(1:4), ':', ed_str(5:7), '"']));

%---------------------------------------------------------------------
% Matlab LTT plots that haven't been converted to Python yet
disp('Running Matlab LTT Plots...')
disp(' ')
ltt_root='/home/pcad/PCAD_Quarterly/ltt/';

% Pointing control plots
cd(strcat(['/home/pcad/PCAD_Quarterly/', dn_pcad, '/pcad_mission']))
temp=LTTquery([ltt_root 'A_PNT_CTRL_STAB.ltt'],time(1999275),tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

cd('../pcad_quarter')
temp=LTTquery([ltt_root 'A_PNT_CTRL_STAB.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

% Converter voltages table
temp=LTTquery([ltt_root 'A_A_CONV_VOLTAGE.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

cd('../pcad_quarter')
temp=LTTquery([ltt_root 'A_WDE_CONV_VOLTAGE.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

run_converter_voltage_calc(sd, ed);

%---------------------------------------------------------------------
% Other Matlab plots

% Quarterly Dump Stats
disp(' ')
disp('Collecting Quarterly Dump Stats...')
disp(' ')
QuarterlyDumpStats(sd, ed);

mkdir('Ref')
cd('Ref')

% Thermistor dropout plots
disp(' ')
disp('Running Thermistor Dropout Plots...')
disp(' ')
Check_For_Dropouts

% 1Shot plots
disp('Running 1 Shot Plots...')
disp(' ')
addpath('/home/pcad/matlab/1_SHOT/code')
m = BuildManStruc('/home/pcad/matlab/1_SHOT/ManeuverData');
plotOneShots(m)

% Text file of all G_LIMMON violations for the quarter
disp('Compiling limit violations...')
disp(' ')
LimitViolations(sd, ed)

%---------------------------------------------------------------------
% Copy files to Noodle

disp('Done!')
