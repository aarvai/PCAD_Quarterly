function PROP_Quarterly(sd,ed)

addpath('/home/pcad/PCAD_Quarterly')


tstart=time(sd);
tstop=time(ed);

ltt_root='/home/pcad/AXAFUSER/ltt/';

cd /home/pcad/PCAD_Quarterly;

dn=['PROP_Q_' num2str(sd) '_' num2str(ed)];

mkdir(dn);

cd(dn);


mkdir('Quarter')
cd Quarter

% create quarter plots


temp=LTTquery([ltt_root 'P_LINES.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp

temp=LTTquery([ltt_root 'P_MUPS.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'P_MUPS_VALVES.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp

temp=LTTquery([ltt_root 'P_LAE_VLV.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp

temp=LTTquery([ltt_root 'P_TANKS.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp


cd ..
mkdir('Mission')
cd Mission

% create mission plots


temp=LTTquery([ltt_root 'P_LINES.ltt'],time(1999250),tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp

temp=LTTquery([ltt_root 'P_MUPS.ltt'],time(1999250),tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'P_MUPS_VALVES.ltt'],time(1999250),tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp

temp=LTTquery([ltt_root 'P_LAE_VLV.ltt'],time(1999250),tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp

temp=LTTquery([ltt_root 'P_TANKS.ltt'],time(1999250),tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp
