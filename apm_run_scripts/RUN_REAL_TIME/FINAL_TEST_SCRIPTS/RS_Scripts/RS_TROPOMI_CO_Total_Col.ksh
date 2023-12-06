#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/tropomi_co_total_col_obs
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${WRFCHEM_TEMPLATE_DIR}
      export NL_FILE_MODEL=${WRFCHEM_TEMPLATE_FILE}
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__CO_____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_CO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
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
# SET TROPOMI INPUT DATA DIR
      export INFILE=${EXPERIMENT_TROPOMI_CO_DIR}/${YYYY}${MM}${DD}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T
#
# COPY EXECUTABLE
      export FILE=tropomi_co_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CO/native_to_ascii/${FILE} ./.
      mcc -m tropomi_co_total_col_extract.m -o tropomi_co_total_col_extract
      ./run_tropomi_co_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
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
         export INFILE=${EXPERIMENT_TROPOMI_CO_DIR}/${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T
#
# COPY EXECUTABLE
         export FILE=tropomi_co_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CO/native_to_ascii/${FILE} ./.
         mcc -m tropomi_co_total_col_extract.m -o tropomi_co_total_col_extract
         ./run_tropomi_co_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_co_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${WRFCHEM_TEMPLATE_DIR}\'
      export NL_FILE_MODEL=\'${WRFCHEM_TEMPLATE_FILE}\'
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
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
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
obs_list='TROPOMI_CO_TOTAL_COL'
/
EOF
# DO THINNING
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CO/work/tropomi_co_total_col_thinner ./.
      ./tropomi_co_total_col_thinner > index_thinner.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CO/work/tropomi_co_total_col_ascii_to_obs ./.
      ./tropomi_co_total_col_ascii_to_obs > index_ascii.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_CO_${DATE}
      fi
#
# Clean directory
      rm bias_correct*      
      rm dart_log* includedSupport* input.nml mccExcluded* *.dat
      rm readme.* requiredMCRP* run_tropomi_co_* unresolved* tropomi_co_*
