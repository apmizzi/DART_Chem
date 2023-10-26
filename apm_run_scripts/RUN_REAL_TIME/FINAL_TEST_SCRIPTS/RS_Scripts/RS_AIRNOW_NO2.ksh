#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/airnow_no2_obs
#
# GET AIRNOW DATA
      if [[ ! -e airnow_no2_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_no2_hourly_csv_data ./.
      fi
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
# RUN_AIRNOW_NO2_ASCII_TO_DART
      export NL_FILENAME=\'airnow_no2_hourly_csv_data\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_NO2}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_no2_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_no2_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_no2_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
#
# Clean directory
      airnow_no2_* bias_correct* create_airnow* dart_log* input.nml      
