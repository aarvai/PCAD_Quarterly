function out = Check_For_Dropouts()

%This script will parse and plot the propulsion thermistor dropouts summary
%dropouts.mat, which is updated weekly through PROP_Weekly.m.  It will also
%save .PNGs to the current directory for use in the quarterly report.


close all


load /home/pcad/Investigations/MUPS_2_Temp_Sensor/dropouts.mat

%Re-parse the structure
dropouts_msid={};
for i=1:length(dropouts)-1 %the last value is always a dummy
    dropouts_msid(i,1)={dropouts(i).msid};
    dropouts_StartTime(i,1)=MatlabTime(dropouts(i).StartTime);
    dropouts_EndTime(i,1)=MatlabTime(dropouts(i).EndTime);
    dropouts_duration(i,1)=dropouts(i).EndTime-dropouts(i).StartTime;
end

%display which thermistors have experienced dropouts to date
msids_with_dropouts=unique(dropouts_msid);
disp('The following MSIDs have experienced dropout(s) since 2004:223')
disp('    ''MSID_PLAEV4AT'' ')
disp(msids_with_dropouts)

%calculate how many dropouts have occurred on each thermistor each quarter
for j=1:length(msids_with_dropouts)
    msid=msids_with_dropouts(j);
    droppedout(:,j)=strcmp(msid,dropouts_msid);
end
time_hacks=[datenum([2004,1,1,0,0,0]):91.3125:datenum(clock)+91.3125]; %quarterly basis
short=(dropouts_duration<3600);
long=(dropouts_duration>=3600);
for i=1:length(time_hacks)-1
    dropouts_timeframe=(dropouts_StartTime>time_hacks(i) & dropouts_StartTime<time_hacks(i+1));
    for j=1:length(msids_with_dropouts)
        msid=msids_with_dropouts(j);
        droppedout_thistimeframe=(droppedout(:,j) & dropouts_timeframe);
        summary_all_dropouts(j,i)=sum(droppedout_thistimeframe);
        droppedout_thistimeframe_short=(droppedout_thistimeframe & short);
        summary_short(j,i)=sum(droppedout_thistimeframe_short);
        droppedout_thistimeframe_long=(droppedout_thistimeframe & long);
        summary_long(j,i)=sum(droppedout_thistimeframe_long);
    end
end

%plot results
figure(1)
plot(time_hacks(1:end-1),summary_all_dropouts,'*-')
datetick('x',17)
h=legend(msids_with_dropouts,'Location','NorthWest');
set(h,'Interpreter','none')
title('Frequency of Propulsion Thermistor Dropouts','FontWeight','Bold')
ylabel('Dropouts per Quarter','FontWeight','Bold')
y=ylim;
grid on
PNGprint('Prop_All_Thermistor_Dropouts')

figure(2)
plot(time_hacks(1:end-1),summary_short,'*-')
datetick('x',17)
h=legend(msids_with_dropouts,'Location','NorthWest');
set(h,'Interpreter','none')
title('Frequency of Propulsion Thermistor Dropouts < 1 Hour','FontWeight','Bold')
ylabel('Dropouts per Quarter','FontWeight','Bold')
grid on
ylim(y)
PNGprint('Prop_Short_Thermistor_Dropouts')

figure(3)
plot(time_hacks(1:end-1),summary_long,'*-')
datetick('x',17)
h=legend(msids_with_dropouts,'Location','NorthWest');
set(h,'Interpreter','none')
title('Frequency of Propulsion Thermistor Dropouts >= 1 Hour','FontWeight','Bold')
ylabel('Dropouts per Quarter','FontWeight','Bold')
grid on
ylim(y)
PNGprint('Prop_Long_Thermistor_Dropouts')

colors=get(gca,'ColorOrder');

figure(4)
hold on
for j=1:length(msids_with_dropouts)
    plot(dropouts_StartTime(droppedout(:,j)),dropouts_duration(droppedout(:,j))/60,'.','Color',colors(j,:))
end
datetick('x',17)
h=legend(msids_with_dropouts,'Location','NorthWest');
set(h,'Interpreter','none')
title('Duration of Propulsion Thermistor Dropouts','FontWeight','Bold')
ylabel('Duration [min]','FontWeight','Bold')
grid on
PNGprint('Prop_All_Thermistor_Dropout_Durations')
