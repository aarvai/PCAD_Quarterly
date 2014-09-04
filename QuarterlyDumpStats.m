function out = QuarterlyDumpStats(sd, ed)

addpath '/home/pcad/matlab/Dump_Process'
load dump_stats
t1=time(sd); % update to beginning of new quarter
t2=time(ed); % update to end of new quarter
t2=t2+86400;

i=find(d.s.time>t1 & d.s.time<t2);  % find index to this Q's dumps

st=d.s.time(i) ;  %start time
s_str=char(st); %convert to character array

dur=d.e.time(i)-d.s.time(i);  % duration
dH=d.e.mom(i,:)-d.s.mom(i,:);  %delta momentum (index,all)

disp('Dumps this quarter:')
for n=1:length(dur)
display([s_str(n,1:end-4) ',' num2str(dur(n),5) ',' num2str(dH(n,:),'%2.2f,') ])
end

% take command line output and paste into word then convert text to table
% comma delimited

cts=d.e.counts(i,:)-d.s.counts(i,:);  % get counts
on_time=sum(cts./100);

disp(' ')
disp('Thruster On-Time this Quarter:')
disp('        A1        A2        A3        A4        B1        B2        B3        B4')
disp(on_time)  % convert to seconds


% flow rate is lbs per second, repmat to make array sizes work (4xn) vs (1xn)
fuel_flow=sum(cts./100.*repmat(d.flow_rate(i),1,8));