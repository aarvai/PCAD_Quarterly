from matplotlib import pyplot as pp
from os import chdir
import sys

from Chandra import Time

import ltt
import pcad_plots
import prop_plots
from utilities import mkdir_cd 

##-------------------------------------------------------------
# Inputs - Quarter start and stop

start = sys.argv[1]
stop = sys.argv[2]

##-------------------------------------------------------------
# Run Quarterlies

# Define directory names
pcad_dir = 'PCAD_Q_' + start[:4] + start[5:8] + '_' + stop[:4] + stop[5:8]
prop_dir = 'PROP_Q_' + start[:4] + start[5:8] + '_' + stop[:4] + stop[5:8]

# Make directories and create plots
pp.close('all')
mkdir_cd(pcad_dir)
mkdir_cd('pcad_mission')
ltt.pcad_ltts('1999:250', stop)
pcad_plots.fss('1999:250', stop)
#pcad_plots.pointing_stab('pitch', '1999:250:00:00:00', stop)
#pcad_plots.pointing_stab('yaw', '1999:250:00:00:00', stop)
#pcad_plots.cmd_vs_act_torque('1999:250', stop)
pcad_plots.drag_torque('2000:001', stop, plot_months=False)
mkdir_cd('../pcad_quarter')
ltt.pcad_ltts(start, stop)
pcad_plots.fss(start, stop)
#pcad_plots.pointing_stab('pitch', start, stop)
#pcad_plots.pointing_stab('yaw', start, stop)
#pcad_plots.cmd_vs_act_torque(start, stop)
mkdir_cd('../../' + prop_dir)
mkdir_cd('prop_mission')
ltt.prop_ltts('2002:001:00:00:00', stop)
mkdir_cd('zoom')
ltt.prop_zoom_ltts('2002:001:00:00:00', stop)
mkdir_cd('../../prop_other')
prop_plots.mups_tank(stop)
prop_plots.ips_tank(stop)
prop_plots.therm_dropouts(stop)
prop_plots.fdm2(stop)
chdir('..')
pp.close('all')


