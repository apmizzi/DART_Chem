#!/bin/ksh -aux
#PBS -W group_list=s2933
#PBS -N ics_mat
#PBS -l walltime=00:30:00
#PBS -q normal
#PBS -j oe
#PBS -l select=1:ncpus=1:mpiprocs=1:model=mil_ait
#PBS -l site=needed=/home1+/nobackupp28+/nobackup27
#
# COPY EXECUTABLE
   export SCRIPT_PATH=/nobackupp28/amizzi/APM_FILES_GLADE/MATLAB_PLOTTING_SCRIPTS/TRACER-I
   export RUN_DIR=/nobackupp28/amizzi/OUTPUT_DATA/NOAA_PLOTS
   cd ${RUN_DIR}
   rm *.m *.mat
   cp ${SCRIPT_PATH}/usahi.m ./.
   cp ${SCRIPT_PATH}/usahi.mat ./.
   cp ${SCRIPT_PATH}/redblue.m ./.
   cp ${SCRIPT_PATH}/cbrewer.m ./.
   cp ${SCRIPT_PATH}/c_line.m ./.
   cp ${SCRIPT_PATH}/c_line_no_edge.m ./.
   cp ${SCRIPT_PATH}/coastlines.m ./.
   cp ${SCRIPT_PATH}/interpolate_cbrewer.m ./.
   cp ${SCRIPT_PATH}/linspecer.m ./.
   export FILE=plot_timeseries_TRACER_I_mean_ics_DART.m
   rm -rf ${FILE}
   rm includedSupport* matlab_code mccExcluded* readme.txt requiredMCR* run_* unresolved*
   cp ${SCRIPT_PATH}/${FILE} ./${FILE}
   mcc -m ${FILE} -o matlab_code
   ./run_matlab_code.sh ${MATLAB} > index_matlab_code.html 2>&1
#
