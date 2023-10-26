#!/bin/ksh -aeux 
#
# TO SETUP AN ENVIRONMENT TO CONVERT OBSERVATIONS TO obs_seq.
#
# SET TIME INFORMATION
  export START_DATE=2022010100
  export END_DATE=2020010100
  export FIRST_FILTER_DATE=2022010100
  export CYCLE_PERIOD=6
  export ASIM_WINDOW=3
  export RUN_BIAS_CORRECTION=false
  export NL_CORRECTION_FILENAME='Historical_Bias_Correction'
#
# VERSIONS
  export WRFDA_VER=WRFDAv4.3.2_dmpar
  export WRF_VER=WRFv4.3.2_dmpar
  export DART_VER=DART_CHEM_MY_BRANCH
#
# INDEPENDENT DIRECTORIES
  export INPUT_DATA_DIR=/nobackupp11/amizzi/INPUT_DATA/MEXICO_REAL_TIME_DATA
  export SCRATCH_DIR=/nobackupp11/amizzi/OUTPUT_DATA
  export TRUNK_DIR=/nobackupp11/amizzi/TRUNK
#
# DEPENDENT DIRECTORIES
  export WRF_DIR=${TRUNK_DIR}/${WRF_VER}
  export VAR_DIR=${TRUNK_DIR}/${WRFDA_VER}
  export BUILD_DIR=${VAR_DIR}/var/build
  export DART_DIR=${TRUNK_DIR}/${DART_VER}
#
# OUTPUT DIR
  export OBS_AQSMEX_OUT_DIR=${SCRATCH_DIR}/AQS_MEX_CO
  if [[ ! -d ${OBS_AQSMEX_OUT_DIR} ]]; then 
     mkdir -p ${OBS_AQSMEX_OUT_DIR}; 
  fi
  cd ${OBS_AQSMEX_OUT_DIR}
#
# GET AQSMEX CO DATA
  if [[ !  Mexico-in-situ-CO-2022.csv ]]; then
      cp ${INPUT_DATA_DIR}/aqsmex_cvs_data/Mexico-in-situ-CO-2022.csv ./.
  fi
  if [[ !  MCMA-monitoring-stations-just-CO.csv ]]; then
     cp ${INPUT_DATA_DIR}/aqsmex_cvs_data/MCMA-monitoring-stations-just-CO.csv ./.
  fi
#
# BEGIN DAY AND TIME LOOP
  export L_DATE=${START_DATE}
  while [[ ${L_DATE} -le ${END_DATE} ]]; do
     export YYYY=$(echo $L_DATE | cut -c1-4)
     export YY=$(echo $L_DATE | cut -c3-4)
     export MM=$(echo $L_DATE | cut -c5-6)
     export DD=$(echo $L_DATE | cut -c7-8)
     export HH=$(echo $L_DATE | cut -c9-10)
     export ASIM_MN_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} -${ASIM_WINDOW} 2>/dev/null)  
     export ASIM_MX_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} +${ASIM_WINDOW} 2>/dev/null)  
     export ASIM_MN_YYYY=$(echo $ASIM_MIN_DATE | cut -c1-4)
     export ASIM_MN_YY=$(echo $ASIM_MN_DATE | cut -c3-4)
     export ASIM_MN_MM=$(echo $ASIM_MN_DATE | cut -c5-6)
     export ASIM_MN_DD=$(echo $ASIM_MN_DATE | cut -c7-8)
     export ASIM_MN_HH=$(echo $ASIM_MN_DATE | cut -c9-10)
     export ASIM_MN_MN=0
     export ASIM_MN_SS=1
     export ASIM_MX_YYYY=$(echo $ASIM_MAX_DATE | cut -c1-4)
     export ASIM_MX_YY=$(echo $ASIM_MX_DATE | cut -c3-4)
     export ASIM_MX_MM=$(echo $ASIM_MX_DATE | cut -c5-6)
     export ASIM_MX_DD=$(echo $ASIM_MX_DATE | cut -c7-8)
     export ASIM_MX_HH=$(echo $ASIM_MX_DATE | cut -c9-10)
     export ASIM_MX_MN=0
     export ASIM_MX_SS=0
#    
# RUN_AQSMEX_ASCII_TO_DART
      export NL_FILENAME_DATA=\'Mexico-in-situ-CO-2022.csv\'
      export NL_FILENAME_STATIONS=\'MCMA-monitoring-stations-just-CO.csv\'
      export NL_LAT_MN=10
      export NL_LAT_MX=25
      export NL_LON_MN=-100
      export NL_LON_MX=-90
      export NL_USE_LOG_CO=.false.
      export NL_USE_LOG_O3=.false
      export NL_USE_LOG_NOX=.false.
      export NL_USE_LOG_NO2=.false.
      export NL_USE_LOG_SO2=.false.
      export NL_USE_LOG_PM10=.false.
      export NL_USE_LOG_PM25=.false.
      export NL_USE_LOG_AOD=.false.
      export NL_FAC_OBS_ERROR=1.0
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${L_DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
         rm -rf ${NL_CORRECTION_FILENAME}
         export NL_DOES_FILE_EXIST=.false.
      else
         rm -rf ${NL_CORRECTION_FILENAME}
         cp ${RUN_DIR}/${PAST_DATE}/bias_corr/${NL_CORRECTION_FILENAME} ./.
      fi
#
      rm -rf bias_correct_nml
      cat << EOF > bias_correct_nml
&bias_correct_nml
path_filein='${RUN_DIR}/${L_DATE}/bias_corr'
does_file_exist=${NL_DOES_FILE_EXIST}
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/observations/obs_converters/AQSMEX/work/aqsmex_co_ascii_to_obs ./.
      rm -rf create_aqsmex_obs_nml,nl
      rm -rf input.nml
      ${HYBRID_SCRIPTS_DIR}/da_create_dart_aqsmex_inputr_nml.ksh
      ./aqsmex_co_ascii_to_obs > index 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AQSMEX_OUT_FILE=aqsmex_obs_seq
      export AQSMEX_ARCH_FILE=obs_seq_aqsmex_co_${DATE}.out
      if [[ -s ${AQSMEX_OUT_FILE} ]]; then
         cp ${AQSMEX_OUT_FILE} ${OBS_AQSMEX_OUT_DIR}/${AQSMEX_ARCH_FILE}
         rm ${AQSMEX_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi
#
# LOOP TO NEXT DAY AND TIME 
      export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${CYCLE_PERIOD} 2>/dev/null)  
  done
