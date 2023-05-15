#!/bin/ksh -aeux
#########################################################################
#
# Purpose: BIAS CORRECTION TEST
#
#########################################################################
#
# Code versions
   export WRFDA_VER=WRFDAv4.3.2_dmpar
   export WRF_VER=WRFv4.3.2_dmpar
   export WRFCHEM_VER=WRFCHEMv4.3.2_dmpar
   export DART_VER=DART_chem_upgrade
#
# Time data:
   export CYCLE_FREQ=6
   export FIRST_FILTER_DATE=2020071006
   export START_DATE=2020071006
   export END_DATE=2020071100
   export DATE=${START_DATE} 
   export YYYY=$(echo $DATE | cut -c1-4)
   export MM=$(echo $DATE | cut -c5-6)
   export DD=$(echo $DATE | cut -c7-8)
   export HH=$(echo $DATE | cut -c9-10)
#
# Directories:
   export SCRATCH_DIR=/nobackupp11/amizzi/OUTPUT_DATA
   export HOME_DIR=/nobackupp11/amizzi
#
   export TRUNK_DIR=${HOME_DIR}/TRUNK
   export DART_DIR=${TRUNK_DIR}/${DART_VER}
   export WRFDA_DIR=${TRUNK_DIR}/${WRFDA_VER}
   export EXPERIMENT_DIR=${SCRATCH_DIR}/real_FIREX_MOPITT_CO_v4
   export RUN_DIR=${SCRATCH_DIR}/BIAS_CORR_TEST
   export BUILD_DIR=${WRFDA_DIR}/var/da
#
# Create ${RUN_DIR}
   if [[ ! -e ${RUN_DIR} ]]; then
      mkdir -p ${RUN_DIR}
   fi
   cd ${RUN_DIR}
   export NL_CORRECTION_FILENAME='Historical_Bias_Corrections'
   rm -rf ${NL_CORRECTION_FILENAME}
   rm -rf index_*
#
# Loop through dates
   while [[ ${DATE} -le ${END_DATE} ]] ; do
#
# Copy files 
      rm -rf bias_corr.exe
      rm -rf bias_correct_nml
      rm -rf obs_seq.final 
      cp ${DART_DIR}/models/wrf_chem/run_scripts/RUN_BIAS_CORR/work/bias_corr.exe ./.
      cp ${EXPERIMENT_DIR}/${DATE}/dart_filter/obs_seq.final ./.
# Create namelist
      export NL_DOES_FILE_EXIST=.true.      
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} ]]; then
         export NL_DOES_FILE_EXIST=.false.
      fi 
      cat << EOF > bias_correct_nml
&bias_correct_nml
path_filein='${RUN_DIR}'
does_file_exist=${NL_DOES_FILE_EXIST}
correction_filename='${NL_CORRECTION_FILENAME}'
nobs=12
obs_list='AIRNOW_CO','MOPITT_CO_1','MOPITT_CO_2','MOPITT_CO_3','MOPITT_CO_4','MOPITT_CO_5','MOPITT_CO_6','MOPITT_CO_7','MOPITT_CO_8','MOPITT_CO_9','MOPITT_CO_10','TROPOMI_CO_COL'
/
EOF
#
# Run bias_corr
      ./bias_corr.exe > index_${DATE} 2>&1
#
# Advance time     
      export DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} ${CYCLE_FREQ} 2>/dev/null)
      export YYYY=$(echo $DATE | cut -c1-4)
      export MM=$(echo $DATE | cut -c5-6)
      export DD=$(echo $DATE | cut -c7-8)
      export HH=$(echo $DATE | cut -c9-10)
   done
exit
