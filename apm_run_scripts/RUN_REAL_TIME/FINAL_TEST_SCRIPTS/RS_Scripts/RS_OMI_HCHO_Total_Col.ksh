#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/omi_hcho_total_col_obs
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${WRFCHEM_TEMPLATE_DIR}
      export NL_FILE_MODEL=${WRFCHEM_TEMPLATE_FILE}
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
      export NL_PATH_MODEL=\'${WRFCHEM_TEMPLATE_DIR}\'
      export NL_FILE_MODEL=\'${WRFCHEM_TEMPLATE_FILE}\'
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
#
# Clean directory
      rm dart_log* input.nml mccExcluded* *.dat omi_hcho_total* 
      rm readme.* requiredMCRP* run_omi_hcho_* includedSupport* unresolved*
