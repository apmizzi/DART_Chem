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
   export RUN_FILE=$1
   export SCRIPT_PATH=/nobackupp28/amizzi/TRUNK/DART_development/TRACER_I_POSTPROCESS/PLOT_TRACER_I_DATA
   export UTILITIES_PATH=/nobackupp28/amizzi/TRUNK/DART_development/TRACER_I_POSTPROCESS/PLOT_TRACER_I_DATA/MATLAB_UTILITIES
   export RUN_DIR=/nobackupp28/amizzi/OUTPUT_DATA/NOAA_PLOTS
   cd ${RUN_DIR}
   rm *.m *.mat
   cp ${UTILITIES_PATH}/usahi.m ./.
   cp ${UTILITIES_PATH}/usahi.mat ./.
   cp ${UTILITIES_PATH}/redblue.m ./.
   cp ${UTILITIES_PATH}/cbrewer.m ./.
   cp ${UTILITIES_PATH}/c_line.m ./.
   cp ${UTILITIES_PATH}/c_line_no_edge.m ./.
   cp ${UTILITIES_PATH}/coastlines.m ./.
   cp ${UTILITIES_PATH}/interpolate_cbrewer.m ./.
   cp ${UTILITIES_PATH}/linspecer.m ./.
   rm -rf ${RUN_FILE}.m
   rm -rf index_matlab_code.html
   rm includedSupport* matlab_code mccExcluded* readme.txt requiredMCR* run_* unresolved*
   cp ${SCRIPT_PATH}/${RUN_FILE}.m ./${RUN_FILE}.m
   mcc -m ${RUN_FILE}.m -o matlab_code
   ./run_matlab_code.sh ${MATLAB} > index_matlab_code.html 2>&1
#
