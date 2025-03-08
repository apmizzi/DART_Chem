#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/airnow_co_obs
#
# GET AIRNOW DATA
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
      export INFILE=airnow_co_hourly_csv_data
      rm -rf ${INFILE}	  
      cp ${EXPERIMENT_AIRNOW_DIR}/airnow_co_hourly_csv_data/${BIN_BEG_YR}/${INFILE} ./.
#
# RUN_AIRNOW_CO_ASCII_TO_DARTOB
      export NL_FILENAME=\'${INFILE}\'
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
#
# Clean directory
      rm -rf airnow_co_* bias_correct* create_airnow* dart_log* input.nml      
