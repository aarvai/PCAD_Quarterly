function out = LimitViolations(sd, ed)

%This script will output all of the limit violations (as shown at the top
%of the daily plots) for a given time period

%Outputs are dependent upon the G_LIMMON file current at the time of the
%production run, not the current G_LIMMON file

%The output file, QuarterlyLimitViolations.txt is most easily sorted by
%importing it into Excel, auto-filtering, and then sorting/filtering by mnemonic


%UPDATE TIMEFRAME
t1=time(sd); % update to beginning of new quarter
t2=time(ed); % update to end of new quarter
%-----------------------------------------------
%Clear existing QuarterlyLimitViolations.txt file
dlmwrite('QuarterlyLimitViolations.txt','')

%Append each day's worth of limit violations to the master file
t=t1;
while t<=t2
    %disp(datestr(MatlabTime(t)))
    [yr,mo,day,hr,min,sec]=datevec(MatlabTime(t));
    violation_file=strcat(['/share/FOT/engineering/reports/dailies/',num2str(yr),'/',upper(datestr(MatlabTime(t),3)),'/',lower(datestr(MatlabTime(t),3)),sprintf('%02.0f',day),'_',sprintf('%03.0f',mattodoy(MatlabTime(t))),'/limits.txt']);
    days_violation=textread(violation_file,'%s', 'whitespace', '','bufsize',80000);
    dlmwrite('QuarterlyLimitViolations.txt',days_violation,'-append','delimiter','')
    t=t+86400;
end