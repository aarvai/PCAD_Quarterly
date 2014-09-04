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

dn_python = ['Q_' num2str(sd) '_' num2str(ed)];

%---------------------------------------------------------------------
% Run Python plots
disp('Running Python Plots...')
disp(' ')
cd /home/pcad/python/quarterlies;
system('rm *.pyc');
system(strcat(['/proj/sot/ska/bin/python run_quarterlies.py "', sd_str(1:4), ':', sd_str(5:7), '" "', ed_str(1:4), ':', ed_str(5:7), '"']));
cd(dn_python)
system(strcat(['cp -r pcad_mission/ /home/pcad/PCAD_Quarterly/', dn_pcad, '/']));
system(strcat(['cp -r pcad_quarter/ /home/pcad/PCAD_Quarterly/', dn_pcad, '/']));
system(strcat(['cp -r prop_mission/ /home/pcad/PCAD_Quarterly/', dn_prop, '/']));
system(strcat(['cp -r prop_other/ /home/pcad/PCAD_Quarterly/', dn_prop, '/']));

%---------------------------------------------------------------------
% Matlab LTT plots that haven't been converted to Python yet
disp('Running Matlab LTT Plots...')
disp(' ')
ltt_root='/home/pcad/PCAD_Quarterly/ltt/';

cd(strcat(['/home/pcad/PCAD_Quarterly/', dn_pcad, '/pcad_quarter']))
temp=LTTquery([ltt_root 'A_PNT_CTRL_STAB.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

cd('../pcad_mission')
temp=LTTquery([ltt_root 'A_PNT_CTRL_STAB.ltt'],time(1999275),tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

%---------------------------------------------------------------------
% Other Matlab plots

cd('..')
mkdir('Ref')

% Thermistor dropout plots
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
