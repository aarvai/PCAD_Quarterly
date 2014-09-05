function out=PointingStab(pthresh, ythresh)
% to produce pointing stability plots
% from the directory with the quarterly outputs from the matlab
% PCAD_Quarterly.m function:
%     1.  Go to "Quarter" LTT output directory for this quarterly report
%     2.  Run this script
%     3.  Script will identify obvious outliers
%     4.  Check that all correspond to 107 runs, other SIM moves in NPM,
%         Momentum Dumps (unlikely) or HRC door moves (if any outliers are
%         NOT to be excluded, raise threshold and rerun.
%     5.  allow script to remove outliers (Even if none identified.  If not, will not plot)
%     6.  script will re-run plots
%     7.  If outliers remain lower thresh variable in m-file and re-run

close('all')

load PITCH_CTRL
pstab=out(3).data.mean + 1.65*out(3).data.stdev;
ystab=out(4).data.mean + 1.65*out(4).data.stdev;

disp('This script will remove outliers above user-defined thresholds.')
disp('Ideally, the only outliers that should be removed should correspond to 107 runs or other big events.')
disp(' ')

% Pitch--------------------------------------------------------------------
figure(1)
plot(out(3).data.day,pstab)
title('Pitch Pointing Control 95% Threshold')
ylabel('arcsec')
change = 'y';
while lower(change) ~= 'n'
    high = pstab > pthresh;
    days = out(3).data.day(high);
    disp(strcat(['Pitch Stability:  With the current threshold of ', num2str(pthresh), ' arcsec, the following days will be removed:']))
    if ~isempty(days)
        hold on
        plot(out(3).data.day(high),pstab(high), 'r*')
        hold off
        disp(char(days))
    else
        disp('< None >')
    end
    change=input('Would you like to change the threshold?  (y/n)  ', 's');
    if lower(change) == 'y'
        pthresh = input('New pitch threshold?  ');
        plot(out(3).data.day,pstab)
    else
        ok = pstab < pthresh;
        plot(out(3).data.day(ok),pstab(ok))
    end
end
title('Pitch Pointing Control 95% Threshold')
ylabel('arcsec')
PNGprint('PitchPointingStability95.png')
disp(' ')

% Yaw----------------------------------------------------------------------
figure(2)
plot(out(4).data.day,ystab)
title('Yaw Pointing Control 95% Threshold')
ylabel('arcsec')
change = 'y';
while lower(change) ~= 'n'
    high = ystab > ythresh;
    days = out(4).data.day(high);
    disp(strcat(['Yaw Stability:  With the current threshold of ', num2str(ythresh), ' arcsec, the following days will be removed:']))
    if ~isempty(days)
        hold on
        plot(out(4).data.day(high),ystab(high), 'r*')
        hold off
        disp(char(days))
    else
        disp('< None >')
    end
    change=input('Would you like to change the threshold?  (y/n)  ', 's');
    if lower(change) == 'y'
        ythresh = input('New yaw threshold?  ');
        plot(out(4).data.day,ystab)
    else
        ok = ystab < ythresh;
        plot(out(4).data.day(ok),ystab(ok))
    end
end
title('Yaw Pointing Control 95% Threshold')
ylabel('arcsec')
PNGprint('YawPointingStability95.png')



