#!/bin/ksh -aux
#
########################################################################
#
# RUN MOPITT CO TOTAL_COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_MOPITT_CO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mopitt_co_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mopitt_co_total_col_obs
         cd ${RUN_DIR}/${DATE}/mopitt_co_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/mopitt_co_total_col_obs
      fi
#
# SET MOPITT PARAMETERS
      export MOPITT_FILE_PRE=MOP02J-
      export MOPITT_FILE_EXT=-L2V10.1.3.beta.hdf   
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOP_OUTFILE=\'MOPITT_CO_${D_DATE}.dat\'
      export MOP_OUTFILE_NQ=MOPITT_CO_${D_DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${MOP_OUTFILE}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
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
# SET MOPITT INPUT DATA FILE
      export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_total_col_extract.m
      export FILE=mopitt_co_total_col_extract.pro
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
      rm -rf job.ksh
      touch job.ksh
      RANDOM=$$
      export JOBRND=${RANDOM}_idl_mopitt
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_total_col_extract.pro
mopitt_co_total_col_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOFF
#      qsub -Wblock=true job.ksh
      chmod +x job.ksh
      ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]];  then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
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
#
# SET MOPITT INPUT DATA FILE
#         export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}${MOPITT_FILE_EXT}\'
	 export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_total_col_extract.m
         export FILE=mopitt_co_total_col_extract.pro
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
         rm -rf job.ksh
         touch job.ksh
         RANDOM=$$
         export JOBRND=${RANDOM}_idl_mopitt
         cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_total_col_extract.pro
mopitt_co_total_col_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOFF
#         qsub -Wblock=true job.ksh 
         chmod +x job.ksh
         ./job.ksh > index_mat.html 2>&1
      fi   
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${MOP_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MOPITT ASCII TO OBS_SEQ 
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      cp MOPITT_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_MOP_OUTFILE=obs_seq_mopitt_co_total_col_${DATE}.out
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MOPITT_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
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
# USE MOPITT DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mopitt_input_nml.ksh
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
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/work/mopitt_co_total_col_ascii_to_obs ./.
      ./mopitt_co_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_MOP_OUTFILE} ]]; then
         touch NO_MOPITT_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MOPITT CO PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_MOPITT_CO_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mopitt_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
         cd ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
      fi
#
# SET MOPITT PARAMETERS
      export MOPITT_FILE_PRE=MOP02J-
      export MOPITT_FILE_EXT=-L2V10.1.3.beta.hdf   
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOP_OUTFILE=\'MOPITT_CO_${D_DATE}.dat\'
      export MOP_OUTFILE_NQ=MOPITT_CO_${D_DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${MOP_OUTFILE}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
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
# SET MOPITT INPUT DATA FILE
      export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${YYYY}${MM}${DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_profile_extract.m
      export FILE=mopitt_co_profile_extract.pro
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
      rm -rf job.ksh
      touch job.ksh
      RANDOM=$$
      export JOBRND=${RANDOM}_idl_mopitt
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_profile_extract.pro
mopitt_co_profile_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOFF
#      qsub -Wblock=true job.ksh
      chmod +x job.ksh
      ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]];  then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
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
#
# SET MOPITT INPUT DATA FILE
	 export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_profile_extract.m
         export FILE=mopitt_co_profile_extract.pro
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
         rm -rf job.ksh
         touch job.ksh
         RANDOM=$$
         export JOBRND=${RANDOM}_idl_mopitt
         cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_profile_extract.pro
mopitt_co_profile_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOFF
#         qsub -Wblock=true job.ksh 
         chmod +x job.ksh
         ./job.ksh > index_mat.html 2>&1
      fi   
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${MOP_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MOPITT ASCII TO OBS_SEQ 
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      cp MOPITT_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_MOP_OUTFILE=obs_seq_mopitt_co_profile_${DATE}.out
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MOPITT_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
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
# USE MOPITT DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mopitt_input_nml.ksh
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
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/work/mopitt_co_profile_ascii_to_obs ./.
      ./mopitt_co_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_MOP_OUTFILE} ]]; then
         touch NO_MOPITT_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MOPITT CO CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_MOPITT_CO_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mopitt_co_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mopitt_co_cpsr_obs
         cd ${RUN_DIR}/${DATE}/mopitt_co_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/mopitt_co_cpsr_obs
      fi
#
# SET MOPITT PARAMETERS
      export MOPITT_FILE_PRE=MOP02J-
      export MOPITT_FILE_EXT=-L2V10.1.3.beta.hdf   
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOP_OUTFILE=\'MOPITT_CO_${D_DATE}.dat\'
      export MOP_OUTFILE_NQ=MOPITT_CO_${D_DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${MOP_OUTFILE}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
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
# SET MOPITT INPUT DATA FILE
      export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${YYYY}${MM}${DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_cpsr_extract.m
      export FILE=mopitt_co_cpsr_extract.pro
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
      rm -rf job.ksh
      touch job.ksh
      RANDOM=$$
      export JOBRND=${RANDOM}_idl_mopitt
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_cpsr_extract.pro
mopitt_co_cpsr_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOFF
#      qsub -Wblock=true job.ksh
      chmod +x job.ksh
      ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]];  then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
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
#
# SET MOPITT INPUT DATA FILE
	 export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_cpsr_extract.m
         export FILE=mopitt_co_cpsr_extract.pro
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
         rm -rf job.ksh
         touch job.ksh
         RANDOM=$$
         export JOBRND=${RANDOM}_idl_mopitt
         cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_cpsr_extract.pro
mopitt_co_cpsr_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOFF
#         qsub -Wblock=true job.ksh 
         chmod +x job.ksh
         ./job.ksh > index_mat.html 2>&1
      fi   
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${MOP_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MOPITT ASCII TO OBS_SEQ 
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      cp MOPITT_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_MOP_OUTFILE=obs_seq_mopitt_co_cpsr_${DATE}.out
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MOPITT_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
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
# USE MOPITT DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mopitt_input_nml.ksh
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
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/work/mopitt_co_cpsr_ascii_to_obs ./.
      ./mopitt_co_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_MOP_OUTFILE} ]]; then
         touch NO_MOPITT_CO_${DATE}
      fi
   fi
#
   
