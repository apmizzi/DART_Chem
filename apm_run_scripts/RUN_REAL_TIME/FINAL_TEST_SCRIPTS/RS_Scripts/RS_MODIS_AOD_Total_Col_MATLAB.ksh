#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/modis_aod_total_col_obs
#
# SET MODIS PARAMETERS
      export NL_PATH_MODEL=${WRFCHEM_TEMPLATE_DIR}
      export NL_FILE_MODEL=${WRFCHEM_TEMPLATE_FILE}
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export MODIS_FILE_PRE=MYD04_L2.A
      export MODIS_FILE_EXT=.hdf
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOD_OUTFILE=\'MODIS_AOD_${D_DATE}.dat\'
      export MOD_OUTFILE_NQ=MODIS_AOD_${D_DATE}.dat
#
#  SET OBS WINDOW
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
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
         export BIN_BEG_YY=${ASIM_MX_YYY}
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
# SET MODIS INPUT DATA FILE
      export INFILE=${EXPERIMENT_MODIS_AOD_DIR}/${YYYY}${MM}${DD}00/${MODIS_FILE_PRE}${YYYY}
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=MODIS_AOD_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=modis_aod_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MODIS_AOD/native_to_ascii/${FILE} ./.
      mcc -m modis_aod_total_col_extract.m -o modis_aod_total_col_extract
      ./run_modis_aod_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${MODIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
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
      if [[ ${FLG} -eq 1 ]];  then
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
         export INFILE=${EXPERIMENT_MODIS_AOD_DIR}/${PAST_YYYY}${PAST_MM}${PAST_DD}00/${MODIS_FILE_PRE}${PAST_YYYY}
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=modis_aod_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MODIS_AOD/native_to_ascii/${FILE} ./.
         mcc -m modis_aod_total_col_extract.m -o modis_aod_total_col_extract
         ./run_modis_aod_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${MODIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
      fi   
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${MOD_OUTFILE_NQ}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_MODIS_AOD_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MODIS ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_modis_aod_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MODIS_AOD}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}      
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
# USE MODIS DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_modis_input_MATLAB_nml.ksh
#
# DO THINNING
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MODIS_AOD/work/modis_aod_total_col_thinner_MATLAB ./.
      ./modis_aod_total_col_thinner_MATLAB > index_thinner.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MODIS_AOD/work/modis_aod_total_col_ascii_to_obs_MATLAB ./.
      ./modis_aod_total_col_ascii_to_obs_MATLAB > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s modis_aod_total_col_obs_seq.out ]]; then
         mv modis_aod_total_col_obs_seq.out ${NL_MOD_OUTFILE}
      else
         touch NO_MODIS_AOD_${DATE}
      fi
#
# Clean directory
#      rm create_modis* dart_log* input.nml job.ksh *.dat modis_aod_total*
#      rm modis_asciidata*
