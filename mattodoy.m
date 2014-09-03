function doy=mattodoy(mdate)

[year,month,day,hour,min,sec]=datevec(mdate);
doy=0;

for i=1:month-1
    doy=doy+eomday(year,i);
end
doy=doy+day;