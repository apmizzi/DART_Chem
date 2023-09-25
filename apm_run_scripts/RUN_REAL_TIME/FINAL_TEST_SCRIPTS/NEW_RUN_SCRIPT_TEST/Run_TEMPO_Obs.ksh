#!/bin/ksh -aux
#
########################################################################
#
# RUN TEMPO O3 TOTAL COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_O3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_o3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_o3_total_col_obs
         cd ${RUN_DIR}/${DATE}/tempo_o3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_o3_total_col_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_O3PROF-PROXY_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_o3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
      mcc -m tempo_o3_total_col_extract.m -o tempo_o3_total_col_extract
      ./run_tempo_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_o3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
         mcc -m tempo_o3_total_col_extract.m -o tempo_o3_total_col_extract
         ./run_tempo_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_o3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/work/tempo_o3_total_col_ascii_to_obs ./.
      ./tempo_o3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO O3 TROP COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_O3_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_o3_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_o3_trop_col_obs
         cd ${RUN_DIR}/${DATE}/tempo_o3_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_o3_trop_col_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_O3PROF-PROXY_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_o3_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
      mcc -m tempo_o3_trop_col_extract.m -o tempo_o3_trop_col_extract
      ./run_tempo_o3_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_o3_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
         mcc -m tempo_o3_trop_col_extract.m -o tempo_o3_trop_col_extract
         ./run_tempo_o3_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_o3_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/work/tempo_o3_trop_col_ascii_to_obs ./.
      ./tempo_o3_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO O3 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/tempo_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_o3_profile_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_O3PROF-PROXY_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
      mcc -m tempo_o3_profile_extract.m -o tempo_o3_profile_extract
      ./run_tempo_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
         mcc -m tempo_o3_profile_extract.m -o tempo_o3_profile_extract
         ./run_tempo_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/work/tempo_o3_profile_ascii_to_obs ./.
      ./tempo_o3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO O3 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/tempo_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_o3_cpsr_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_O3PROF-PROXY_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_o3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
      mcc -m tempo_o3_cpsr_extract.m -o tempo_o3_cpsr_extract
      ./run_tempo_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_o3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
         mcc -m tempo_o3_cpsr_extract.m -o tempo_o3_cpsr_extract
         ./run_tempo_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_o3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/work/tempo_o3_cpsr_ascii_to_obs ./.
      ./tempo_o3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO NO2 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_NO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_no2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_no2_total_col_obs
         cd ${RUN_DIR}/${DATE}/tempo_no2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_no2_total_col_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_NO2_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_NO2_DIR}/${YYYY}${MM}/${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_no2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/native_to_ascii/${FILE} ./.
      mcc -m tempo_no2_total_col_extract.m -o tempo_no2_total_col_extract
      ./run_tempo_no2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_NO2_DIR}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_no2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/native_to_ascii/${FILE} ./.
         mcc -m tempo_no2_total_col_extract.m -o tempo_no2_total_col_extract
         ./run_tempo_no2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_no2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_NO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/work/tempo_no2_total_col_ascii_to_obs ./.
      ./tempo_no2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO NO2 TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_NO2_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_no2_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_no2_trop_col_obs
         cd ${RUN_DIR}/${DATE}/tempo_no2_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_no2_trop_col_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_NO2_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_NO2_DIR}/${YYYY}${MM}/${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_no2_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/native_to_ascii/${FILE} ./.
      mcc -m tempo_no2_trop_col_extract.m -o tempo_no2_trop_col_extract
      ./run_tempo_no2_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_NO2_DIR}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_no2_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/native_to_ascii/${FILE} ./.
         mcc -m tempo_no2_trop_col_extract.m -o tempo_no2_trop_col_extract
         ./run_tempo_no2_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_no2_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_NO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/work/tempo_no2_trop_col_ascii_to_obs ./.
      ./tempo_no2_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_NO2_${DATE}
      fi
   fi
#
   
