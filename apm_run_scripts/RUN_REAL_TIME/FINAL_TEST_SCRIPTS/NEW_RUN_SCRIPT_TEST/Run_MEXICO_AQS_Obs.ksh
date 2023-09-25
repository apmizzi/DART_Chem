#!/bin/ksh -aux
#
#########################################################################
#
# RUN MEXICO AQS CO OBSERVATIONS
#
#########################################################################
#
   if ${RUN_MEXICO_AQS_CO_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mexico_aqs_co_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mexico_aqs_co_obs
         cd ${RUN_DIR}/${DATE}/mexico_aqs_co_obs
      else
         cd ${RUN_DIR}/${DATE}/mexico_aqs_co_obs
      fi
#
# GET MEXICO AQS DATA
      if [[ ! -e mexico_aqs_co_hourly_csv_data ]]; then
         cp ${EXPERIMENT_MEXICO_AQS_DIR}/MCMA-monitoring-stations-just-CO.csv ./.
         cp ${EXPERIMENT_MEXICO_AQS_DIR}/Mexico-in-situ-CO-2022.csv ./.
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
# RUN_MEXICO_AQS_CO_ASCII_TO_DART
      export NL_FILENAME_STATIONS=\'MCMA-monitoring-stations-just-CO.csv\'
      export NL_FILENAME_DATA=\'Mexico-in-situ-CO-2022.csv\'
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
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MEXICO_AQS_CO}
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
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MEXICO_AQS/work/mexico_aqs_co_ascii_to_obs ./.
      rm -rf create_mexico_aqs_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mexico_aqs_input_nml.ksh
      ./mexico_aqs_co_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export MEXICO_AQS_OUT_FILE=mexico_aqs_obs_seq
      export MEXICO_AQS_ARCH_FILE=obs_seq_mexico_aqs_co_${DATE}.out
      if [[ -s ${MEXICO_AQS_OUT_FILE} ]]; then
         cp ${MEXICO_AQS_OUT_FILE} ${MEXICO_AQS_ARCH_FILE}
         rm ${MEXICO_AQS_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
