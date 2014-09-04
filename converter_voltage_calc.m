function [out]=converter_voltage_calc(v,sd,ed)

% compute converter voltage stats from LTT data structure (LTTquery output)
%
% SYNTAX:  converter_voltage_calc(data,start day,end day) - input times in greta format
%
% RETURNS: structure with fields msid, mean and RSSStd for use in PCAD quarterly

sd=time(sd);
ed=time(ed);

for i=1:length(v)
    
    t=find(v(i).data.day>sd & v(i).data.day<ed);
    % weigthed mean
    
    m=sum(v(i).data.mean(t).*v(i).data.samples(t))./(sum(v(i).data.samples(t)));
    
    % find weighted RSS standard deviation
    
    % std dev squared times number of samples -1
    a=(v(i).data.samples(t)-1).*(v(i).data.stdev(t)).*(v(i).data.stdev(t));
    
    % total number of samples used above
    
    s=sum(v(i).data.samples(t))-length(t);
    
    d=sum(a)./s;
    
    out(i).msid=v(i).msid;
    out(i).mean=m;
    out(i).RSSstd=d;
    out(i).ptitle = v(i).ptitle;
    
end