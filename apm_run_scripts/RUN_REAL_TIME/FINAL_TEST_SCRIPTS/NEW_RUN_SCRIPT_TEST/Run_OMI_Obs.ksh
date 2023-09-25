#!/bin/ksh -aux
#
#########################################################################
#
# RUN OMI O3 TOTAL COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_OMI_O3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_o3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_o3_total_col_obs
         cd ${RUN_DIR}/${DATE}/omi_o3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_o3_total_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMTO3_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMTO3_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_O3_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_o3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
      mcc -m omi_o3_total_col_extract.m -o omi_o3_extract_total_col
      ./run_omi_o3_extract_total_col.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
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
         export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_o3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
         mcc -m omi_o3_total_col_extract.m -o omi_o3_total_col_extract
         ./run_omi_o3_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_o3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_total_col_ascii_to_obs ./.
      ./omi_o3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_O3_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN OMI O3 TROP COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_OMI_O3_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_o3_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_o3_trop_col_obs
         cd ${RUN_DIR}/${DATE}/omi_o3_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_o3_trop_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMTO3_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMTO3_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_O3_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_o3_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
      mcc -m omi_o3_trop_col_extract.m -o omi_o3_trop_col_extract
      ./run_omi_o3_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
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
         export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_o3_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
         mcc -m omi_o3_trop_col_extract.m -o omi_o3_trop_col_extract
         ./run_omi_o3_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_o3_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOB_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_trop_col_ascii_to_obs ./.
      ./omi_o3_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_O3_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN OMI O3 PROFILE COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_OMI_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/omi_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_o3_profile_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMO3PR_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMO3PR_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_O3_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
      mcc -m omi_o3_profile_extract.m -o omi_o3_profile_extract
      ./run_omi_o3_profile_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
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
         export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
         mcc -m omi_o3_profile_extract.m -o omi_o3_profile_extract
         ./run_omi_o3_profile_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_profile_ascii_to_obs ./.
      ./omi_o3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_O3_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN OMI O3 CPSR COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_OMI_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/omi_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_o3_cpsr_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMO3PR_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMO3PR_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_O3_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_o3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
      mcc -m omi_o3_cpsr_extract.m -o omi_o3_cpsr_extract
      ./run_omi_o3_cpsr_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
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
         export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_o3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
         mcc -m omi_o3_cpsr_extract.m -o omi_o3_cpsr_extract
         ./run_omi_o3_cpsr_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_o3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      rm -rf omi_o3_cpsr_ascii_to_obs
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_cpsr_ascii_to_obs ./.
      ./omi_o3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_O3_${DATE}
      fi
   fi
#
########################################################################
#   
# RUN OMI NO2 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_NO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_no2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_no2_total_col_obs
         cd ${RUN_DIR}/${DATE}/omi_no2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_no2_total_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMNO2_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMNO2_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_NO2_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_NO2_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_no2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
      mcc -m omi_no2_total_col_extract.m -o omi_no2_total_col_extract
      ./run_omi_no2_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
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
         export INFILE=${EXPERIMENT_OMI_NO2_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_no2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
         mcc -m omi_no2_total_col_extract.m -o omi_no2_total_col_extract
         ./run_omi_no2_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_NO2 ASCII TO OBS_SEQ
      export NL_FILEDIR=\'./\'
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_no2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_NO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_total_col_ascii_to_obs ./.
      ./omi_no2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_NO2_${DATE}
      fi
   fi
#
########################################################################
#   
# RUN OMI NO2 TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_NO2_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_no2_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_no2_trop_col_obs
         cd ${RUN_DIR}/${DATE}/omi_no2_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_no2_trop_col_obs
      fi
v#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMNO2_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMNO2_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_NO2_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_NO2_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_no2_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
      mcc -m omi_no2_trop_col_extract.m -o omi_no2_trop_col_extract
      ./run_omi_no2_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
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
         export INFILE=${EXPERIMENT_OMI_NO2_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_no2_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
         mcc -m omi_no2_trop_col_extract.m -o omi_no2_trop_col_extract
         ./run_omi_no2_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_NO2 ASCII TO OBS_SEQ
      export NL_FILEDIR=\'./\'
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_no2_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_NO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_trop_col_ascii_to_obs ./.
      ./omi_no2_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN OMI SO2 TOTAL COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_SO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_so2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_so2_total_col_obs
         cd ${RUN_DIR}/${DATE}/omi_so2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_so2_total_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMSO2_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMSO2_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_SO2_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_SO2_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_so2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/native_to_ascii/${FILE} ./.
      mcc -m omi_so2_total_col_extract.m -o omi_so2_total_col_extract
      ./run_omi_so2_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
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
         export INFILE=${EXPERIMENT_OMI_SO2_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_so2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/native_to_ascii/${FILE} ./.
         mcc -m omi_so2_total_col_extract.m -o omi_so2_total_col_extract
         ./run_omi_so2_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_SO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_SO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_so2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_SO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/work/omi_so2_total_col_ascii_to_obs ./.
      ./omi_so2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_SO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN OMI SO2 PBL COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_SO2_PBL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_so2_pbl_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_so2_pbl_col_obs
         cd ${RUN_DIR}/${DATE}/omi_so2_pbl_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_so2_pbl_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMSO2_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMSO2_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_SO2_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_SO2_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_so2_pbl_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/native_to_ascii/${FILE} ./.
      mcc -m omi_so2_pbl_col_extract.m -o omi_so2_pbl_col_extract
      ./run_omi_so2_pbl_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
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
         export INFILE=${EXPERIMENT_OMI_SO2_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_so2_pbl_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/native_to_ascii/${FILE} ./.
         mcc -m omi_so2_pbl_col_extract.m -o omi_so2_pbl_col_extract
         ./run_omi_so2_pbl_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_SO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_SO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_so2_pbl_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_SO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/work/omi_so2_pbl_col_ascii_to_obs ./.
      ./omi_so2_pbl_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_SO2_${DATE}
      fi
   fi
#
########################################################################
#   
# RUN OMI HCHO TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_HCHO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_hcho_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_hcho_total_col_obs
         cd ${RUN_DIR}/${DATE}/omi_hcho_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_hcho_total_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMHCHO_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_HCHO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${OMI_FILE_PRE}
      export OUTFILE=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_HCHO_${DATE}.dat
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_hcho_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/native_to_ascii/${FILE} ./.
      mcc -m omi_hcho_total_col_extract.m -o omi_hcho_total_col_extract
      ./run_omi_hcho_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
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
         export INFILE=${EXPERIMENT_OMI_HCHO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${OMI_FILE_PRE}\'
         export OUTFILE=TEMP_FILE.dat
#
# COPY EXECUTABLE
         export FILE=omi_hcho_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/native_to_ascii/${FILE} ./.
         mcc -m omi_hcho_total_col_extract.m -o omi_hcho_total_col_extract
         ./run_omi_hcho_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_HCHO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_HCHO ASCII TO OBS_SEQ
      export NL_FILEDIR=\'./\'
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_hcho_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_HCHO}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_PATH_MODEL=\'${RUN_DIR}/2014${PAST_MM}${PAST_DD}${PAST_HH}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_2014${MM}${DD}${HH}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/work/omi_hcho_total_col_ascii_to_obs ./.
      ./omi_hcho_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_HCHO_${DATE}
      fi
   fi
#
########################################################################
#   
# RUN OMI HCHO TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_HCHO_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_hcho_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_hcho_trop_col_obs
         cd ${RUN_DIR}/${DATE}/omi_hcho_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_hcho_trop_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMHCHO_
      export OMI_FILE_EXT=.he5
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
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_HCHO_DIR}/${OMI_FILE_PRE}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_HCHO_${DATE}.dat
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_hcho_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/native_to_ascii/${FILE} ./.
      mcc -m omi_hcho_trop_col_extract.m -o omi_hcho_trop_col_extract
      ./run_omi_hcho_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
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
         export INFILE=${EXPERIMENT_OMI_HCHO_DIR}/${OMI_FILE_PRE}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE=TEMP_FILE.dat
         rm -rf ${OUTFILE}
#
# COPY EXECUTABLE
         export FILE=omi_hcho_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/native_to_ascii/${FILE} ./.
         mcc -m omi_hcho_trop_col_extract.m -o omi_hcho_trop_col_extract
         ./run_omi_hcho_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_HCHO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_HCHO ASCII TO OBS_SEQ
      export NL_FILEDIR=\'./\'
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_hcho_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_HCHO}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/work/omi_hcho_trop_col_ascii_to_obs ./.
      ./omi_hcho_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_HCHO_${DATE}
      fi
   fi
#
   
