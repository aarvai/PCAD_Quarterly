function PCAD_Weekly(sd,ed)



addpath('/home/pcad/PCAD_Quarterly')


tstart=time(sd);
tstop=time(ed);

ltt_root='/home/pcad/PCAD_Quarterly/ltt/';


 
cd /home/pcad/PCAD_Quarterly;

dn=['PCAD_Q_' num2str(sd) '_' num2str(ed)];

mkdir(dn);

cd(dn);



if 1 == 1


mkdir('Quarter')
cd Quarter

% create quarter plots

temp=LTTquery([ltt_root 'A_IRU-2.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'A_GYRO_BIAS.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_RW_SPEED.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_RW_CURRENT_TEMP.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_FSS_CSS.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp


temp=LTTquery([ltt_root 'A_FSS_CSS_2.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,1)
close all
clear temp

temp=LTTquery([ltt_root 'A_ATTITUDE.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'A_PNT_CTRL_STAB.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'A_PEA_FLCA.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_WDE_CONV_VOLTAGE.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery('/home/pcad/AXAFUSER/ltt/A_A_CONV_VOLTAGE.ltt',tstart,tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp


temp=LTTquery([ltt_root 'A_HW_ERR.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'A_RW_DRAG_TORQUE.ltt'],tstart,tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp



% now do mission plots
cd ..
mkdir('Mission')


end



cd Mission


temp=LTTquery([ltt_root 'A_IRU-1.ltt'],time(1999250),time(2003200),'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'A_IRU-2.ltt'],time(2003201),tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'A_GYRO_BIAS.ltt'],time(1999275),tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_RW_SPEED.ltt'],time(1999250),tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_RW_CURRENT_TEMP.ltt'],time(1999230),tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_FSS_CSS.ltt'],time(1999275),tstop,'keep dat');
LTTplot(temp,4)
close all
clear temp

temp=LTTquery([ltt_root 'A_FSS_CSS_2.ltt'],time(1999275),tstop,'keep dat');
LTTplot(temp,1)
close all
clear temp

temp=LTTquery([ltt_root 'A_ATTITUDE.ltt'],time(1999230),tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'A_PNT_CTRL_STAB.ltt'],time(1999275),tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'A_PEA_FLCA.ltt'],time(1999230),tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_WDE_CONV_VOLTAGE.ltt'],time(1999230),tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_A_CONV_VOLTAGE.ltt'],time(1999230),tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp

temp=LTTquery([ltt_root 'A_HW_ERR.ltt'],time(1999230),tstop,'keep dat');
LTTplot(temp,2)
close all
clear temp

temp=LTTquery([ltt_root 'A_RW_DRAG_TORQUE.ltt'],time(1999250),tstop,'keep dat');
LTTplot(temp,3)
close all
clear temp





