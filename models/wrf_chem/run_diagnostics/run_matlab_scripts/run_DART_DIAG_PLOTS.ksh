#!/bin/ksh -aux
#
   export ROOT_DIR=/nobackupp28/amizzi
   export CODE_DIR=${ROOT_DIR}/TRUNK/DART_development/models/wrf_chem/run_diagnostics/run_matlab_scripts
   export RUN_DIR=${ROOT_DIR}/OUTPUT_DATA/DART_DIAG_PLOTS
   export FILE=run_plot_rmse_xxx_evolution.m
#   export FILE=run_plot_obs_netcdf.m
#   export FILE=run_plot_profile.m
#
   mkdir ${RUN_DIR}
   cd ${RUN_DIR}
   rm ${RUN_DIR}/include*
   rm ${RUN_DIR}/mcccEx*
   rm ${RUN_DIR}/readme*
   rm ${RUN_DIR}/require*
   rm ${RUN_DIR}/runfile*
   rm ${RUN_DIR}/run_runfile*
   rm ${RUN_DIR}/unresolved*
   export RUN_FILE=runfile.m
   cp ${CODE_DIR}/${FILE} ./${RUN_FILE}
#
   mcc -m ${RUN_FILE} -o runfile_script
   ./run_runfile_script.sh ${MATLAB}
   exit
#
