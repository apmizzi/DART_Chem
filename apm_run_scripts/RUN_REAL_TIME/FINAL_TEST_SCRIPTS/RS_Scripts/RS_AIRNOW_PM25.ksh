#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/airnow_pm25_obs
#
# GET AIRNOW DATA
      if [[ ! -e airnow_pm2.5_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_pm2.5_hourly_csv_data ./.
      fi
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=${ASIM_MN_MN}
      export BIN_BEG_SS=${ASIM_MN_SS}
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${ASIM_MX_HH}
      export BIN_END_MN=${ASIM_MX_MN}
      export BIN_END_SS=${ASIM_MX_SS}
#
# RUN_AIRNOW_PM25_ASCII_TO_DART
      export NL_FILENAME=\'airnow_pm2.5_hourly_csv_data\'
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
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_PM25}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_pm25_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_pm25_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_pm25_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
#
# Clean directory
      rm -rf airnow_pm2.5_* bias_correct* create_airnow* dart_log* input.nml
