#!/bin/ksh -aux
#
   cd ${RUN_DIR}/${DATE}/mls_o3_profile_obs
#
# SET MLS PARAMETERS
      export NL_PATH_MODEL=${WRFCHEM_TEMPLATE_DIR}
      export NL_FILE_MODEL=${WRFCHEM_TEMPLATE_FILE}
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export MLS_FILE_PRE=MLS-Aura_L2GP-O3_v04-
      export MLS_FILE_EXT=.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=MLS_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=${ASIM_MN_MN}
      export BIN_BEG_SS=${ASIM_MN_SS}
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${ASIM_MX_HH}
      export BIN_END_MN=${ASIM_MX_MN}
      export BIN_END_SS=${ASIM_MX_SS}
      if [[ ${HH} -eq 0 ]]; then
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=00
         export BIN_BEG_MN=00
         export BIN_BEG_SS=01
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
# SET MLS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_MLS_O3_DIR}/${BIN_BEG_YY}/${BIN_BEG_MM}/${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=mls_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/native_to_ascii/${FILE} ./.
      mcc -m mls_o3_profile_extract.m -o mls_o3_profile_extract
      ./run_mls_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
# END OF PREVIOUS DAY
      if [[ ${HH} -eq 0 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=${ASIM_MIN_MN}
         export BIN_BEG_SS=${ASIM_MIN_SS}
         export BIN_END_YY=${ASIM_MAX_YYYY}
         export BIN_END_MM=${ASIM_MAX_MM}
         export BIN_END_DD=${ASIM_MAX_DD}
         export BIN_END_HH=00
         export BIN_END_MN=00
         export BIN_END_SS=00
         export TMP_INFILE=\'${EXPERIMENT_MLS_O3_DIR}/${BIN_BEG_YY}/${BIN_BEG_MM}/${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=mls_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/native_to_ascii/${FILE} ./.
         mcc -m mls_o3_profile_extract.m -o mls_o3_profile_extract
         ./run_mls_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
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
         touch NO_MLS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MLS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_mls_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MLS_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${WRFCHEM_TEMPLATE_DIR}\'
      export NL_FILE_MODEL=\'${WRFCHEM_TEMPLATE_FILE}\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=${ASIM_MN_MN}
      export BIN_BEG_SS=${ASIM_MN_SS}
      export BIN_END_HH=${ASIM_MX_HH}
      export BIN_END_MN=${ASIM_MX_MN}
      export BIN_END_SS=${ASIM_MX_SS}
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
# USE MLS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mls_input_nml.ksh
#
# DO THINNING
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/work/mls_o3_profile_thinner ./.
      ./mls_o3_profile_thinner > index_thinner.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/work/mls_o3_profile_ascii_to_obs ./.
      ./mls_o3_profile_ascii_to_obs > index_ascii.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_MLS_O3_${DATE}
      fi
#
# Clean directory
#      rm dart_log* includedSupport* input.nml mccExcluded* readme.txt
#      rm requiredMCRP* run_mls_o3* mls_o3_total* unresolved* *.dat
