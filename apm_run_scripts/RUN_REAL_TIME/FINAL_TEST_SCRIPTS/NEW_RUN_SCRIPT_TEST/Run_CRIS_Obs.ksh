#!/bin/ksh -aux
#
########################################################################
#
# RUN CRIS CO TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_co_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_co_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_co_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_co_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS_CO_L2_V01_
      export CRIS_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CO_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_co_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
      mcc -m cris_co_total_col_extract.m -o cris_co_total_col_extract
      ./run_cris_co_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_co_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
         mcc -m cris_co_total_col_extract.m -o cris_co_total_col_extract
         ./run_cris_co_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_CRIS_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_co_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CO}
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/work/cris_co_total_col_ascii_to_obs ./.
      ./cris_co_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CO PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CO_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_co_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_co_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${YYYY}${MM}${DD}${HH}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_CO_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CO_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_co_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
      mcc -m cris_co_profile_extract.m -o cris_co_profile_extract
      ./run_cris_co_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_co_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
         mcc -m cris_co_profile_extract.m -o cris_co_profile_extract
         ./run_cris_co_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_CRIS_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_co_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/work/cris_co_profile_ascii_to_obs ./.
      ./cris_co_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CO CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CO_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_co_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_co_cpsr_obs
         cd ${RUN_DIR}/${DATE}/cris_co_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_co_cpsr_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS_CO_L2_V01_
      export CRIS_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CO_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_co_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
      mcc -m cris_co_cpsr_extract.m -o cris_co_cpsr_extract
      ./run_cris_co_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_co_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
         mcc -m cris_co_cpsr_extract.m -o cris_co_cpsr_extract
         ./run_cris_co_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_CRIS_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_co_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/work/cris_co_cpsr_ascii_to_obs ./.
      ./cris_co_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS O3 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_O3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_o3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_o3_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_o3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_o3_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${YYYY}${MM}${DD}${HH}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS_O3_L2_V01_
      export CRIS_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_O3_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_o3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
      mcc -m cris_o3_total_col_extract.m -o cris_o3_total_col_extract
      ./run_cris_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_o3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
         mcc -m cris_o3_total_col_extract.m -o cris_o3_total_col_extract
         ./run_cris_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_CRIS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_o3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/work/cris_o3_total_col_ascii_to_obs ./.
      ./cris_o3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS O3 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_o3_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${YYYY}${MM}${DD}${HH}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_O3_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_O3_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
      mcc -m cris_o3_profile_extract.m -o cris_o3_profile_extract
      ./run_cris_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
         mcc -m cris_o3_profile_extract.m -o cris_o3_profile_extract
         ./run_cris_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_CRIS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/work/cris_o3_profile_ascii_to_obs ./.
      ./cris_o3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS O3 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/cris_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_o3_cpsr_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS_O3_L2_V01_
      export CRIS_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_O3_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_o3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
      mcc -m cris_o3_cpsr_extract.m -o cris_o3_cpsr_extract
      ./run_cris_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_o3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
         mcc -m cris_o3_cpsr_extract.m -o cris_o3_cpsr_extract
         ./run_cris_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
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
         touch NO_CRIS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_o3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/work/cris_o3_cpsr_ascii_to_obs ./.
      ./cris_o3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS NH3 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_NH3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_nh3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_nh3_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_nh3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_nh3_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS-Aura_L2-CO-SO-Nadir_r00000
      export CRIS_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_NH3_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_nh3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/native_to_ascii/${FILE} ./.
      mcc -m cris_nh3_total_col_extract.m -o cris_nh3_total_col_extract
      ./run_cris_nh3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'

#
# COPY EXECUTABLE
         export FILE=cris_nh3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/native_to_ascii/${FILE} ./.
         mcc -m cris_nh3_total_col_extract.m -o cris_nh3_total_col_extract
         ./run_cris_nh3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
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
         touch NO_CRIS_NH3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS NH3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_nh3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_NH3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/work/cris_nh3_total_col_ascii_to_obs ./.
      ./cris_nh3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_NH3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS NH3 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_NH3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_nh3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_nh3_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_nh3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_nh3_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_NH3_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_NH3_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_nh3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/native_to_ascii/${FILE} ./.
      mcc -m cris_nh3_profile_extract.m -o cris_nh3_profile_extract
      ./run_cris_nh3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_nh3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/native_to_ascii/${FILE} ./.
         mcc -m cris_nh3_profile_extract.m -o cris_nh3_profile_extract
         ./run_cris_nh3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_CRIS_NH3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS NH3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_nh3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_NH3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/work/cris_nh3_profile_ascii_to_obs ./.
      ./cris_nh3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_NH3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CH4 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CH4_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_ch4_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_ch4_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_ch4_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_ch4_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS-Aura_L2-CH4-SO-Nadir_r00000
      export CRIS_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CH4_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_ch4_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
      mcc -m cris_ch4_total_col_extract.m -o cris_ch4_total_col_extract
      ./run_cris_ch4_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_ch4_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
         mcc -m cris_ch4_total_col_extract.m -o cris_ch4_total_col_extract
         ./run_cris_ch4_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
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
         touch NO_CRIS_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_ch4_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/work/cris_ch4_total_col_ascii_to_obs ./.
      ./cris_ch4_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CH4 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CH4_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_ch4_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_ch4_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_ch4_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_ch4_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_CH4_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CH4_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_ch4_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
      mcc -m cris_ch4_profile_extract.m -o cris_ch4_profile_extract
      ./run_cris_ch4_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_ch4_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
         mcc -m cris_ch4_profile_extract.m -o cris_ch4_profile_extract
         ./run_cris_ch4_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_CRIS_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_ch4_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/work/cris_ch4_profile_ascii_to_obs ./.
      ./cris_ch4_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CH4 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CH4_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_ch4_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_ch4_cpsr_obs
         cd ${RUN_DIR}/${DATE}/cris_ch4_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_ch4_cpsr_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS-Aura_L2-CH4-SO-Nadir_r00000
      export CRIS_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CH4_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_ch4_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
      mcc -m cris_ch4_cpsr_extract.m -o cris_ch4_cpsr_extract
      ./run_cris_ch4_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_ch4_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
         mcc -m cris_ch4_cpsr_extract.m -o cris_ch4_cpsr_extract
         ./run_cris_ch4_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
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
         touch NO_CRIS_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_ch4_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/work/cris_ch4_cpsr_ascii_to_obs ./.
      ./cris_ch4_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS PAN TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_PAN_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_pan_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_pan_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_pan_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_pan_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
   
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Summary_PAN_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_PAN_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_pan_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
      mcc -m cris_pan_total_col_extract.m -o cris_pan_total_col_extract
      ./run_cris_pan_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_pan_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
         mcc -m cris_pan_total_col_extract.m -o cris_pan_total_col_extract
         ./run_cris_pan_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_CRIS_PAN_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_pan_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_PAN}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/work/cris_pan_total_col_ascii_to_obs ./.
      ./cris_pan_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_PAN_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS PAN PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_PAN_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_pan_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_pan_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_pan_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_pan_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_PAN_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_PAN_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_pan_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
      mcc -m cris_pan_profile_extract.m -o cris_pan_profile_extract
      ./run_cris_pan_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_pan_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
         mcc -m cris_pan_profile_extract.m -o cris_pan_profile_extract
         ./run_cris_pan_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_CRIS_PAN_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS PAN ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_pan_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_PAN}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/work/cris_pan_profile_ascii_to_obs ./.
      ./cris_pan_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_PAN_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS PAN CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_PAN_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_pan_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_pan_cpsr_obs
         cd ${RUN_DIR}/${DATE}/cris_pan_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_pan_cpsr_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS-Aura_L2-PAN-SO-Nadir_r00000
      export CRIS_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_PAN_${DATE}.dat
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
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_pan_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
      mcc -m cris_pan_cpsr_extract.m -o cris_pan_cpsr_extract
      ./run_cris_pan_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
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
         export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_pan_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
         mcc -m cris_pan_cpsr_extract.m -o cris_pan_cpsr_extract
         ./run_cris_pan_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
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
         touch NO_CRIS_PAN_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS PAN ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_pan_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_PAN}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
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
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/work/cris_pan_cpsr_ascii_to_obs ./.
      ./cris_pan_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_PAN_${DATE}
      fi
   fi
#
   
