function PCAD_Quarterly(sd,ed)

%---------------------------------------------------------------------
%Directory bookkeeping
addpath('/home/pcad/PCAD_Quarterly')

tstart=time(sd);
tstop=time(ed);

dn_pcad=['PCAD_Q_' num2str(sd) '_' num2str(ed)];
mkdir(dn_pcad);
dn_prop=['PCAD_Q_' num2str(sd) '_' num2str(ed)];
mkdir(dn_prop);

%---------------------------------------------------------------------
% Run Python plots
cd /home/pcad/python/quarterlies;
system('rm *.pyc');
system('/proj/sot/ska/bin/python run_quarterlies.py');
system(strcat(['cp pcad_mission ', dn_pcad]))
system(strcat(['cp pcad_quarterly ', dn_pcad]))
system(strcat(['cp prop_mission ', dn_prop]))
system(strcat(['cp prop_other ', dn_prop]))

%---------------------------------------------------------------------
% Matlab plots that haven't been converted to Python yet
ltt_root='/home/pcad/PCAD_Quarterly/ltt/';
cd('../pcad_mission')
temp=LTTquery([ltt_root 'A_PNT_CTRL_STAB.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

cd('../pcad_quarterly')
temp=LTTquery([ltt_root 'A_PNT_CTRL_STAB.ltt'],time(1999275),tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp




PROP_Quarterly(sd,ed)



%---------------------------------------------------------------------
% Copy files to Noodle
