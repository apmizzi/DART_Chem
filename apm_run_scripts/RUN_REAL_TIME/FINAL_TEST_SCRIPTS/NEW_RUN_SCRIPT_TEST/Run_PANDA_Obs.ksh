#!/bin/ksh -aux
#
#########################################################################
#
# RUN PANDA CO OBSERVATIONS
#
#########################################################################
#
   if ${RUN_PANDA_CO_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/panda_co_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/panda_co_obs
         cd ${RUN_DIR}/${DATE}/panda_co_obs
      else
         cd ${RUN_DIR}/${DATE}/panda_co_obs
      fi
#
# GET PANDA DATA
      if [[ ! -e panda_station_coordinates.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_station_coordinates.csv ./.
      fi
      if [[ ! -e panda_stationData.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_stationData.csv ./.
      fi
#
      export ASIM_MIN_MN=0
      export ASIM_MIN_SS=0
      export ASIM_MAX_MN=0
      export ASIM_MAX_SS=0
#
# RUN_PANDA_CO_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${ASIM_MIN_YYYY}
         export L_MM=${ASIM_MIN_MM}
         export L_DD=${ASIM_MIN_DD}
         export L_HH=24
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      else
         export L_YYYY=${YYYY}
         export L_MM=${MM}
         export L_DD=${DD}
         export L_HH=${HH}
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      fi
      export NL_YEAR=${L_YYYY}
      export NL_MONTH=${L_MM}
      export NL_DAY=${L_DD}
      export NL_HOUR=${L_HH}
#
      export NL_FILENAME_COORD=\'panda_station_coordinates.csv\'
      export NL_FILENAME_DATA=\'panda_stationData.csv\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/PANDA/work/panda_co_ascii_to_obs ./.
      rm -rf create_panda_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_panda_input_nml.ksh
      ./panda_co_ascii_to_obs
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export PANDA_OUT_FILE=panda_obs_seq
      export PANDA_ARCH_FILE=obs_seq_panda_co_${DATE}.out
      if [[ -s ${PANDA_OUT_FILE} ]]; then
         cp ${PANDA_OUT_FILE} ${PANDA_ARCH_FILE}
         rm ${PANDA_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN PANDA O3 OBSERVATIONS
#
#########################################################################
#
   if ${RUN_PANDA_O3_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/panda_o3_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/panda_o3_obs
         cd ${RUN_DIR}/${DATE}/panda_o3_obs
      else
         cd ${RUN_DIR}/${DATE}/panda_o3_obs
      fi
#
# GET PANDA DATA
      if [[ ! -e panda_station_coordinates.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_station_coordinates.csv ./.
      fi
      if [[ ! -e panda_stationData.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_stationData.csv ./.
      fi
#
      export ASIM_MIN_MN=0
      export ASIM_MIN_SS=0
      export ASIM_MAX_MN=0
      export ASIM_MAX_SS=0
#
# RUN_PANDA_O3_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${ASIM_MIN_YYYY}
         export L_MM=${ASIM_MIN_MM}
         export L_DD=${ASIM_MIN_DD}
         export L_HH=24
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      else
         export L_YYYY=${YYYY}
         export L_MM=${MM}
         export L_DD=${DD}
         export L_HH=${HH}
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      fi
      export NL_YEAR=${L_YYYY}
      export NL_MONTH=${L_MM}
      export NL_DAY=${L_DD}
      export NL_HOUR=${L_HH}
#
      export NL_FILENAME_COORD=\'panda_station_coordinates.csv\'
      export NL_FILENAME_DATA=\'panda_stationData.csv\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/PANDA/work/panda_o3_ascii_to_obs ./.
      rm -rf create_panda_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_panda_input_nml.ksh
      ./panda_o3_ascii_to_obs
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export PANDA_OUT_FILE=panda_obs_seq
      export PANDA_ARCH_FILE=obs_seq_panda_o3_${DATE}.out
      if [[ -s ${PANDA_OUT_FILE} ]]; then
         cp ${PANDA_OUT_FILE} ${PANDA_ARCH_FILE}
         rm ${PANDA_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN PANDA PM25 OBSERVATIONS
#
#########################################################################
#
   if ${RUN_PANDA_PM25_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/panda_pm25_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/panda_pm25_obs
         cd ${RUN_DIR}/${DATE}/panda_pm25_obs
      else
         cd ${RUN_DIR}/${DATE}/panda_pm25_obs
      fi
#
# GET PANDA DATA
      if [[ ! -e panda_station_coordinates.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_station_coordinates.csv ./.
      fi
      if [[ ! -e panda_stationData.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_stationData.csv ./.
      fi
#
      export ASIM_MIN_MN=0
      export ASIM_MIN_SS=0
      export ASIM_MAX_MN=0
      export ASIM_MAX_SS=0
#
# RUN_PANDA_PM25_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${ASIM_MIN_YYYY}
         export L_MM=${ASIM_MIN_MM}
         export L_DD=${ASIM_MIN_DD}
         export L_HH=24
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      else
         export L_YYYY=${YYYY}
         export L_MM=${MM}
         export L_DD=${DD}
         export L_HH=${HH}
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      fi
      export NL_YEAR=${L_YYYY}
      export NL_MONTH=${L_MM}
      export NL_DAY=${L_DD}
      export NL_HOUR=${L_HH}
#
      export NL_FILENAME_COORD=\'panda_station_coordinates.csv\'
      export NL_FILENAME_DATA=\'panda_stationData.csv\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/PANDA/work/panda_pm25_ascii_to_obs ./.
      rm -rf create_panda_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_panda_input_nml.ksh
      ./panda_pm25_ascii_to_obs
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export PANDA_OUT_FILE=panda_obs_seq
      export PANDA_ARCH_FILE=obs_seq_panda_pm25_${DATE}.out
      if [[ -s ${PANDA_OUT_FILE} ]]; then
         cp ${PANDA_OUT_FILE} ${PANDA_ARCH_FILE}
         rm ${PANDA_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
   
