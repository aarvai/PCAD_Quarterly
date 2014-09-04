function converter_table = run_converter_voltage_calc(sd, ed)

close all

%------------------------------

load ACPA5CV.mat
x_out = out;
x=converter_voltage_calc(x_out,sd,ed);
load AWD1CV5V.mat
y_out = out;
y=converter_voltage_calc(y_out,sd,ed);

z=[x(4),x(1:3),x(5:7),y];

for i=1:length(z)
    converter_table(i,1)={z(i).ptitle};
    converter_table(i,2)={sprintf('%.2f',z(i).mean)};
    if z(i).RSSstd==0
        converter_table(i,3)={'0'};
    else
        converter_table(i,3)={sprintf('%.2e',z(i).RSSstd)};
    end
end

disp(' ')
disp('     UNIT                                        MEAN      STDEV')
disp(converter_table)







