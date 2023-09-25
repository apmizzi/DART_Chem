#!/bin/ksh -aux
#
#########################################################################
#
# RUN AIRNOW O3 OBSERVATIONS
#
#########################################################################
#
   if ${RUN_AIRNOW_O3_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_o3_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_o3_obs
         cd ${RUN_DIR}/${DATE}/airnow_o3_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_o3_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_o3_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_o3_hourly_csv_data ./.
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
# RUN_AIRNOW_O3_ASCII_TO_DART
      export NL_FILENAME=\'airnow_o3_hourly_csv_data\'
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
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_O3}
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
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
path_filein='${RUN_DIR}/${DATE}/bias_corr'
does_file_exist=${NL_DOES_FILE_EXIST}
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_o3_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_o3_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_o3_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN AIRNOW CO OBSERVATIONS
#
#########################################################################
#
   if ${RUN_AIRNOW_CO_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_co_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_co_obs
         cd ${RUN_DIR}/${DATE}/airnow_co_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_co_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_co_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_co_hourly_csv_data ./.
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
# RUN_AIRNOW_CO_ASCII_TO_DART
      export NL_FILENAME=\'airnow_co_hourly_csv_data\'
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
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_CO}
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
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
path_filein='${RUN_DIR}/${DATE}/bias_corr'
does_file_exist=${NL_DOES_FILE_EXIST}
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_co_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_co_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_co_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN AIRNOW NO2 OBSERVATIONS
#
#########################################################################
#
if ${RUN_AIRNOW_NO2_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_no2_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_no2_obs
         cd ${RUN_DIR}/${DATE}/airnow_no2_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_no2_obs
      fi
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
   fi
#
#########################################################################
#
# RUN AIRNOW SO2 OBSERVATIONS
#
#########################################################################
#
if ${RUN_AIRNOW_SO2_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_so2_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_so2_obs
         cd ${RUN_DIR}/${DATE}/airnow_so2_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_so2_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_so2_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_so2_hourly_csv_data ./.
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
# RUN_AIRNOW_SO2_ASCII_TO_DART
      export NL_FILENAME=\'airnow_so2_hourly_csv_data\'
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
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_SO2}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_so2_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_so2_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_so2_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN AIRNOW PM10 OBSERVATIONS
#
#########################################################################
#
if ${RUN_AIRNOW_PM10_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_pm10_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_pm10_obs
         cd ${RUN_DIR}/${DATE}/airnow_pm10_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_pm10_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_pm10_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_pm10_hourly_csv_data ./.
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
# RUN_AIRNOW_PM10_ASCII_TO_DART
      export NL_FILENAME=\'airnow_pm10_hourly_csv_data\'
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
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_PM10}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_pm10_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_pm10_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_pm10_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN AIRNOW PM25 OBSERVATIONS
#
#########################################################################
#
if ${RUN_AIRNOW_PM25_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_pm25_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_pm25_obs
         cd ${RUN_DIR}/${DATE}/airnow_pm25_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_pm25_obs
      fi
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
   fi
#
