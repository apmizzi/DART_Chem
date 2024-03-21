#!/bin/ksh -aux
   cd ${RUN_DIR}/${DATE}/consolidate_cmaq_input
#
   export CMAQ_COPY_DIR=${DART_DIR}/apm_run_scripts/RUN_CMAQ_COPY
   cp ${CMAQ_COPY_DIR}/work/consolidate_cmaq_files.exe ./.
#
   export NL_NUM_2D_VARS=5
   export NL_LIST_2D_VARS=\'LAT\',\'LON\',\'HT\',\'LWMASK\',\'PRSFC\'
   export NL_NUM_3D_VARS=6
   export NL_LIST_3D_VARS=\'TA\',\'QV\',\'PRES\',\'DENS\',\'ZF\',\'ZH\'
#
   export BACKGROUND_DIR=${RUN_DIR}/${PAST_DATE}/wrfchem_cycle_cr
   if [[ ${DATE} -eq ${FIRST_FILTER_DATE} ]]; then
       export BACKGROUND_DIR=${RUN_DIR}/${PAST_DATE}/wrfchem_initial
   fi
#
# COPY BACKGROUND FORECASTS
   export L_DART_FILTER_DIR=${RUN_DIR}/${DATE}/dart_filter
   mkdir -p ${L_DART_FILTER_DIR}
#   let MEM=1
#   while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
#      export CMEM=e${MEM}
#      if [[ ${MEM} -lt 100 ]]; then; export export CMEM=e0${MEM}; fi
#      if [[ ${MEM} -lt 10 ]]; then; export CMEM=e00${MEM}; fi
#      cp ${BACKGROUND_DIR}/run_${CMEM}/cmaq_output_d${CR_DOMAIN} ${L_DART_FILTER_DIR}/cmaq_output_d${CR_DOMAIN}.${CMEM}
#      let MEM=${MEM}+1
#   done
#
# CREATE NAMELIST FILE
   rm -rf cmaq_dimensions_nml
   cat << EOF > cmaq_dimensions_nml
&cmaq_dimensions_nml
num_mems        = ${NUM_MEMBERS}
num_2d_vars     = ${NL_NUM_2D_VARS}
num_3d_vars     = ${NL_NUM_3D_VARS}
/
EOF
#
# CREATE NAMELIST FILE
   rm -rf consolidate_cmaq_files_nml
   cat << EOF > consolidate_cmaq_files_nml
&consolidate_cmaq_files_nml
cmaq_old_path   = '${BACKGROUND_DIR}'
cmaq_new_path   = '${L_DART_FILTER_DIR}'
cmaq_input_file = 'cmaq_output_d01'
grid2d_file     = 'gridcro2d_d01'
met2d_file      = 'metcro2d_d01'
met3d_file      = 'metcro3d_d01'
list_2d_vars    = ${NL_LIST_2D_VARS}
list_3d_vars    = ${NL_LIST_3D_VARS}
/
EOF
!
   ./consolidate_cmaq_files.exe > index.consolidate 2>&1
