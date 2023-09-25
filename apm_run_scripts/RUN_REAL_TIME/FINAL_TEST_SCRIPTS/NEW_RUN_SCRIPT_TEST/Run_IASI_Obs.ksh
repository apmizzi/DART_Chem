#!/bin/ksh -aux
#
#########################################################################
#
# RUN IASI CO PROFILE OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_CO_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_co_profile_obs
         cd ${RUN_DIR}/${DATE}/iasi_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_co_profile_obs
      fi
#
# SET IASI PARAMETERS
      export IASI_FILE_PRE='VERSION2_NCAR_IASI_xxx_1C_M02'
      export IASI_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export IAS_OUTFILE=\'IASI_CO_${D_DATE}.dat\'
      export IAS_OUTFILE_NQ=IASI_CO_${D_DATE}.dat
      let NCNT=4
      rm -rf ${OUTFILE_NQ}
      rm -rf ${IAS_OUTFILE_NQ}
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
# SET IASI INPUT DATA FILE
      export A_DATE=${DATE}
      while [[ ${A_DATE} -le ${ASIM_MAX_DATE} ]]; do 
         export A_YY=$(echo $A_DATE | cut -c1-4)
         export A_MM=$(echo $A_DATE | cut -c5-6)
         export A_DD=$(echo $A_DATE | cut -c7-8)
         export A_HH=$(echo $A_DATE | cut -c9-10)
	 export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
	 export A_DIR=${A_YY}/${A_MM}/${A_DD}
         export ICNT=0
         while [[ ${ICNT} -le ${NCNT} ]]; do
            export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
            export ND_YY=$(echo $TEST | cut -c1-4)
            export ND_MM=$(echo $TEST | cut -c5-6)
            export ND_DD=$(echo $TEST | cut -c7-8)
            export ND_HH=$(echo $TEST | cut -c9-10)
	    export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
            export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${A_DATE}*Z_${ND_DATE}*Z_*`
            if [[ -e ${FILEIN} ]]; then 
               export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
               export FILE=iasi_co_profile_extract.pro
               rm -rf ${FILE}
               cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
               rm -rf job.ksh
               touch job.ksh
               RANDOM=$$
               export JOBRND=${RANDOM}_idl_iasi
               cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_profile_extract.pro
iasi_co_profile_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
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
#               qsub -Wblock=true job.ksh 
               chmod +x job.ksh
               ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
               if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  touch ${IAS_OUTFILE_NQ}
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               fi
            fi
            (( ICNT=${ICNT}+1 ))
         done
         export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
      done
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
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
# SET IASI INPUT DATA FILE
	 export A_DATE=${ASIM_MIN_DATE}
         while [[ ${A_DATE} -le ${DATE} ]]; do 
            export A_YY=$(echo $A_DATE | cut -c1-4)
            export A_MM=$(echo $A_DATE | cut -c5-6)
            export A_DD=$(echo $A_DATE | cut -c7-8)
            export A_HH=$(echo $A_DATE | cut -c9-10)
   	    export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
            export A_DIR=${A_YY}/${A_MM}/${A_DD}
            export ICNT=0
            while [[ ${ICNT} -le ${NCNT} ]]; do
               export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
               export ND_YY=$(echo $TEST | cut -c1-4)
               export ND_MM=$(echo $TEST | cut -c5-6)
               export ND_DD=$(echo $TEST | cut -c7-8)
               export ND_HH=$(echo $TEST | cut -c9-10)
   	       export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
               export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${ND_DATE}*Z_${ND_DATE=}*Z_*`
               if [[ -e ${FILEIN} ]]; then 
                  export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
                  export FILE=iasi_co_profile_extract.pro
                  rm -rf ${FILE}
                  cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
                  rm -rf job.ksh
                  touch job.ksh
                  RANDOM=$$
                  export JOBRND=${RANDOM}_idl_iasi
                  cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_profile_extract.pro
iasi_co_profile_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
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
#                  qsub -Wblock=true job.ksh 
                  chmod +x job.ksh
                  ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
                  if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     touch ${IAS_OUTFILE_NQ}
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  fi
	       fi
               (( ICNT=${ICNT}+1 ))
            done
            export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
         done
      fi
      if [[ ! -e ${IAS_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT IASI_CO ASCII TO OBS_SEQ 
      cp IASI_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IAS_OUTFILE=obs_seq_iasi_co_profile_${DATE}.out
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
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
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/work/iasi_co_profile_ascii_to_obs ./.
      ./iasi_co_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_IAS_OUTFILE} ]]; then
         touch NO_IASI_CO_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI CO TOTAL_COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_CO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_co_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_co_total_col_obs
         cd ${RUN_DIR}/${DATE}/iasi_co_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_co_total_col_obs
      fi
#
# SET IASI PARAMETERS
      export IASI_FILE_PRE='VERSION2_NCAR_IASI_xxx_1C_M02'
      export IASI_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export IAS_OUTFILE=\'IASI_CO_${D_DATE}.dat\'
      export IAS_OUTFILE_NQ=IASI_CO_${D_DATE}.dat
      let NCNT=4
      rm -rf ${OUTFILE_NQ}
      rm -rf ${IAS_OUTFILE_NQ}
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
# SET IASI INPUT DATA FILE
      export A_DATE=${DATE}
      while [[ ${A_DATE} -le ${ASIM_MAX_DATE} ]]; do 
         export A_YY=$(echo $A_DATE | cut -c1-4)
         export A_MM=$(echo $A_DATE | cut -c5-6)
         export A_DD=$(echo $A_DATE | cut -c7-8)
         export A_HH=$(echo $A_DATE | cut -c9-10)
	 export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
	 export A_DIR=${A_YY}/${A_MM}/${A_DD}
         export ICNT=0
         while [[ ${ICNT} -le ${NCNT} ]]; do
            export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
            export ND_YY=$(echo $TEST | cut -c1-4)
            export ND_MM=$(echo $TEST | cut -c5-6)
            export ND_DD=$(echo $TEST | cut -c7-8)
            export ND_HH=$(echo $TEST | cut -c9-10)
	    export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
            export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${A_DATE}*Z_${ND_DATE}*Z_*`
            if [[ -e ${FILEIN} ]]; then 
               export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
               export FILE=iasi_co_total_col_extract.pro
               rm -rf ${FILE}
               cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
               rm -rf job.ksh
               touch job.ksh
               RANDOM=$$
               export JOBRND=${RANDOM}_idl_iasi
               cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_total_col_extract.pro
iasi_co_total_col_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
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
#               qsub -Wblock=true job.ksh 
               chmod +x job.ksh
               ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
               if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  touch ${IAS_OUTFILE_NQ}
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               fi
            fi
            (( ICNT=${ICNT}+1 ))
         done
         export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
      done
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
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
# SET IASI INPUT DATA FILE
	 export A_DATE=${ASIM_MIN_DATE}
         while [[ ${A_DATE} -le ${DATE} ]]; do 
            export A_YY=$(echo $A_DATE | cut -c1-4)
            export A_MM=$(echo $A_DATE | cut -c5-6)
            export A_DD=$(echo $A_DATE | cut -c7-8)
            export A_HH=$(echo $A_DATE | cut -c9-10)
   	    export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
            export A_DIR=${A_YY}/${A_MM}/${A_DD}
            export ICNT=0
            while [[ ${ICNT} -le ${NCNT} ]]; do
               export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
               export ND_YY=$(echo $TEST | cut -c1-4)
               export ND_MM=$(echo $TEST | cut -c5-6)
               export ND_DD=$(echo $TEST | cut -c7-8)
               export ND_HH=$(echo $TEST | cut -c9-10)
   	       export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
               export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${ND_DATE}*Z_${ND_DATE=}*Z_*`
               if [[ -e ${FILEIN} ]]; then 
                  export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
                  export FILE=iasi_co_total_col_extract.pro
                  rm -rf ${FILE}
                  cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
                  rm -rf job.ksh
                  touch job.ksh
                  RANDOM=$$
                  export JOBRND=${RANDOM}_idl_iasi
                  cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_total_col_extract.pro
iasi_co_total_col_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
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
#                  qsub -Wblock=true job.ksh 
                  chmod +x job.ksh
                  ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
                  if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     touch ${IAS_OUTFILE_NQ}
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  fi
	       fi
               (( ICNT=${ICNT}+1 ))
            done
            export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
         done
      fi
      if [[ ! -e ${IAS_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT IASI_CO ASCII TO OBS_SEQ 
      cp IASI_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IAS_OUTFILE=obs_seq_iasi_co_total_col_${DATE}.out
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
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
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/work/iasi_co_total_col_ascii_to_obs ./.
      ./iasi_co_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_IAS_OUTFILE} ]]; then
         touch NO_IASI_CO_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI CO PROFILE OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_CO_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_co_profile_obs
         cd ${RUN_DIR}/${DATE}/iasi_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_co_profile_obs
      fi
#
# SET IASI PARAMETERS
      export IASI_FILE_PRE='VERSION2_NCAR_IASI_xxx_1C_M02'
      export IASI_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export IAS_OUTFILE=\'IASI_CO_${D_DATE}.dat\'
      export IAS_OUTFILE_NQ=IASI_CO_${D_DATE}.dat
      let NCNT=4
      rm -rf ${OUTFILE_NQ}
      rm -rf ${IAS_OUTFILE_NQ}
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
# SET IASI INPUT DATA FILE
      export A_DATE=${DATE}
      while [[ ${A_DATE} -le ${ASIM_MAX_DATE} ]]; do 
         export A_YY=$(echo $A_DATE | cut -c1-4)
         export A_MM=$(echo $A_DATE | cut -c5-6)
         export A_DD=$(echo $A_DATE | cut -c7-8)
         export A_HH=$(echo $A_DATE | cut -c9-10)
	 export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
	 export A_DIR=${A_YY}/${A_MM}/${A_DD}
         export ICNT=0
         while [[ ${ICNT} -le ${NCNT} ]]; do
            export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
            export ND_YY=$(echo $TEST | cut -c1-4)
            export ND_MM=$(echo $TEST | cut -c5-6)
            export ND_DD=$(echo $TEST | cut -c7-8)
            export ND_HH=$(echo $TEST | cut -c9-10)
	    export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
            export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${A_DATE}*Z_${ND_DATE}*Z_*`
            if [[ -e ${FILEIN} ]]; then 
               export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
               export FILE=iasi_co_profile_extract.pro
               rm -rf ${FILE}
               cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
               rm -rf job.ksh
               touch job.ksh
               RANDOM=$$
               export JOBRND=${RANDOM}_idl_iasi
               cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_profile_extract.pro
iasi_co_profile_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
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
#               qsub -Wblock=true job.ksh 
               chmod +x job.ksh
               ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
               if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  touch ${IAS_OUTFILE_NQ}
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               fi
            fi
            (( ICNT=${ICNT}+1 ))
         done
         export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
      done
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
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
# SET IASI INPUT DATA FILE
	 export A_DATE=${ASIM_MIN_DATE}
         while [[ ${A_DATE} -le ${DATE} ]]; do 
            export A_YY=$(echo $A_DATE | cut -c1-4)
            export A_MM=$(echo $A_DATE | cut -c5-6)
            export A_DD=$(echo $A_DATE | cut -c7-8)
            export A_HH=$(echo $A_DATE | cut -c9-10)
   	    export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
            export A_DIR=${A_YY}/${A_MM}/${A_DD}
            export ICNT=0
            while [[ ${ICNT} -le ${NCNT} ]]; do
               export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
               export ND_YY=$(echo $TEST | cut -c1-4)
               export ND_MM=$(echo $TEST | cut -c5-6)
               export ND_DD=$(echo $TEST | cut -c7-8)
               export ND_HH=$(echo $TEST | cut -c9-10)
   	       export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
               export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${ND_DATE}*Z_${ND_DATE=}*Z_*`
               if [[ -e ${FILEIN} ]]; then 
                  export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
                  export FILE=iasi_co_profile_extract.pro
                  rm -rf ${FILE}
                  cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
                  rm -rf job.ksh
                  touch job.ksh
                  RANDOM=$$
                  export JOBRND=${RANDOM}_idl_iasi
                  cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_profile_extract.pro
iasi_co_profile_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
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
#                  qsub -Wblock=true job.ksh 
                  chmod +x job.ksh
                  ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
                  if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     touch ${IAS_OUTFILE_NQ}
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  fi
	       fi
               (( ICNT=${ICNT}+1 ))
            done
            export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
         done
      fi
      if [[ ! -e ${IAS_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT IASI_CO ASCII TO OBS_SEQ 
      cp IASI_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IAS_OUTFILE=obs_seq_iasi_co_profile_${DATE}.out
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
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
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/work/iasi_co_profile_ascii_to_obs ./.
      ./iasi_co_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_IAS_OUTFILE} ]]; then
         touch NO_IASI_CO_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI CO CPSR OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_CO_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_co_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_co_cpsr_obs
         cd ${RUN_DIR}/${DATE}/iasi_co_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_co_cpsr_obs
      fi
#
# SET IASI PARAMETERS
      export IASI_FILE_PRE='VERSION2_NCAR_IASI_xxx_1C_M02'
      export IASI_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export IAS_OUTFILE=\'IASI_CO_${D_DATE}.dat\'
      export IAS_OUTFILE_NQ=IASI_CO_${D_DATE}.dat
      let NCNT=4
      rm -rf ${OUTFILE_NQ}
      rm -rf ${IAS_OUTFILE_NQ}
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
# SET IASI INPUT DATA FILE
      export A_DATE=${DATE}
      while [[ ${A_DATE} -le ${ASIM_MAX_DATE} ]]; do 
         export A_YY=$(echo $A_DATE | cut -c1-4)
         export A_MM=$(echo $A_DATE | cut -c5-6)
         export A_DD=$(echo $A_DATE | cut -c7-8)
         export A_HH=$(echo $A_DATE | cut -c9-10)
	 export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
	 export A_DIR=${A_YY}/${A_MM}/${A_DD}
         export ICNT=0
         while [[ ${ICNT} -le ${NCNT} ]]; do
            export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
            export ND_YY=$(echo $TEST | cut -c1-4)
            export ND_MM=$(echo $TEST | cut -c5-6)
            export ND_DD=$(echo $TEST | cut -c7-8)
            export ND_HH=$(echo $TEST | cut -c9-10)
	    export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
            export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${A_DATE}*Z_${ND_DATE}*Z_*`
            if [[ -e ${FILEIN} ]]; then 
               export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
               export FILE=iasi_co_cpsr_extract.pro
               rm -rf ${FILE}
               cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
               rm -rf job.ksh
               touch job.ksh
               RANDOM=$$
               export JOBRND=${RANDOM}_idl_iasi
               cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_cpsr_extract.pro
iasi_co_cpsr_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
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
#               qsub -Wblock=true job.ksh 
               chmod +x job.ksh
               ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
               if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  touch ${IAS_OUTFILE_NQ}
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               fi
            fi
            (( ICNT=${ICNT}+1 ))
         done
         export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
      done
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
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
# SET IASI INPUT DATA FILE
	 export A_DATE=${ASIM_MIN_DATE}
         while [[ ${A_DATE} -le ${DATE} ]]; do 
            export A_YY=$(echo $A_DATE | cut -c1-4)
            export A_MM=$(echo $A_DATE | cut -c5-6)
            export A_DD=$(echo $A_DATE | cut -c7-8)
            export A_HH=$(echo $A_DATE | cut -c9-10)
   	    export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
            export A_DIR=${A_YY}/${A_MM}/${A_DD}
            export ICNT=0
            while [[ ${ICNT} -le ${NCNT} ]]; do
               export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
               export ND_YY=$(echo $TEST | cut -c1-4)
               export ND_MM=$(echo $TEST | cut -c5-6)
               export ND_DD=$(echo $TEST | cut -c7-8)
               export ND_HH=$(echo $TEST | cut -c9-10)
   	       export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
               export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${ND_DATE}*Z_${ND_DATE=}*Z_*`
               if [[ -e ${FILEIN} ]]; then 
                  export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
                  export FILE=iasi_co_cpsr_extract.pro
                  rm -rf ${FILE}
                  cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
                  rm -rf job.ksh
                  touch job.ksh
                  RANDOM=$$
                  export JOBRND=${RANDOM}_idl_iasi
                  cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_cpsr_extract.pro
iasi_co_cpsr_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
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
#                  qsub -Wblock=true job.ksh 
                  chmod +x job.ksh
                  ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
                  if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     touch ${IAS_OUTFILE_NQ}
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  fi
	       fi
               (( ICNT=${ICNT}+1 ))
            done
            export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
         done
      fi
      if [[ ! -e ${IAS_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT IASI_CO ASCII TO OBS_SEQ 
      cp IASI_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IAS_OUTFILE=obs_seq_iasi_co_cpsr_${DATE}.out
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
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
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/work/iasi_co_cpsr_ascii_to_obs ./.
      ./iasi_co_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_IAS_OUTFILE} ]]; then
         touch NO_IASI_CO_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI O3 PROFILE OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/iasi_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_o3_profile_obs
      fi
#
# copy the IASI O3 error covariance file
      cp ${EXPERIMENT_IASI_O3_DIR}/IASI_apcov.dat ./
#
# set file prefix for IASI
# this depends on versions and file times (edit if necessary)
      export FILE_PRE='METOPA_IASI_EUMC_'
#
# set file suffix for IASI
# this depends on versions and file times (edit if necessary)
      export FILE_EXT='.dat'
#
      if [[ ${HH} == 00 ]]; then
#
# 00Z special case
         let TEMP_MIN_HH=${ASIM_MIN_HH}
         let TEMP_MAX_HH=${ASIM_MAX_HH}
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
         rm -rf ${ASIM_OUTFILE}
         touch ${ASIM_OUTFILE}
#
# Past date
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=24*60*60 ))
         export FILE_COL=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_Columns${FILE_EXT}
         export FILE_ERR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_ERROR${FILE_EXT}
         export FILE_VMR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_VMR${FILE_EXT}
         if [[ -e ${FILE_COL} && -e ${FILE_ERR} && -e ${FILE_VMR} ]]; then 
            export OUTFILE_NM=TEMP_FILE.dat
            export INFILE_COL=\'${FILE_COL}\'
            export INFILE_ERR=\'${FILE_ERR}\'
            export INFILE_VMR=\'${FILE_VMR}\'
            export OUTFILE=\'${OUTFILE_NM}\'
#
# this is the call to an IDL routine to read and write variables
# if already processed (with output), then this can be skipped (do_iasi=0)
# else this needs to be called
            export FILE=iasi_o3_profile_extract.pro
            rm -rf ${FILE}
            cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/native_to_ascii/${FILE} ./.
#
            rm -rf job.ksh
            touch job.ksh
            RANDOM=$$
            export JOBRND=${RANDOM}_idl_iasi
            cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_o3_profile_extract.pro
iasi_o3_profile_extract,${INFILE_COL},${INFILE_ERR},${INFILE_VMR},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}, ${DATE}
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
#            qsub -Wblock=true job.ksh 
            chmod +x job.ksh
            ./job.ksh > index_m.html 2>&1
#
# cat the output file to the assimlation window file
            export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
            if [[ -e ${OUTFILE_NM} ]]; then
               cat ${OUTFILE_NM} >> ${ASIM_OUTFILE}
#               rm -rf ${OUTFILE_NM}
            fi
         else
            echo APM IASI O3 INPUT FILES DO NOT EXIST
         fi
      else
#
# OOZ, 06Z, 12Z, 18Z normal cases
         let TEMP_MIN_HH=${ASIM_MIN_HH}
         let TEMP_MAX_HH=${ASIM_MAX_HH}
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         if [[ ${HH} == 00 ]]; then
            (( BIN_BEG_SEC=1 ))
            (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         fi
         export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
         rm -rf ${ASIM_OUTFILE}
         touch ${ASIM_OUTFILE}
         export FILE_COL=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_Columns${FILE_EXT}
         export FILE_ERR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_ERROR${FILE_EXT}
         export FILE_VMR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_VMR${FILE_EXT}
         if [[ -e ${FILE_COL} && -e ${FILE_ERR} && -e ${FILE_VMR} ]]; then 
            export OUTFILE_NM=TEMP_FILE.dat
            export INFILE_COL=\'${FILE_COL}\'
            export INFILE_ERR=\'${FILE_ERR}\'
            export INFILE_VMR=\'${FILE_VMR}\'
            export OUTFILE=\'${OUTFILE_NM}\'
#
# this is the call to an IDL routine to read and write variables
# if already processed (with output), then this can be skipped (do_iasi=0)
# else this needs to be called
            export FILE=iasi_o3_profile_extract.pro
            rm -rf ${FILE}
            cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/native_to_ascii/${FILE} ./.
#
            rm -rf job.ksh
            touch job.ksh
            RANDOM=$$
            export JOBRND=${RANDOM}_idl_iasi
            cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_o3_profile_extract.pro
iasi_o3_profile_extract,${INFILE_COL},${INFILE_ERR},${INFILE_VMR},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}, ${DATE}
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
#            qsub -Wblock=true job.ksh 
            chmod +x job.ksh
            ./job.ksh > index_mat.html 2>&1
#
# cat the output file to the assimlation window file
            export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
            if [[ -e ${OUTFILE_NM} ]]; then
               cat ${OUTFILE_NM} >> ${ASIM_OUTFILE}
#               rm -rf ${OUTFILE_NM}
            fi
         else
            echo APM IASI O3 INPUT FILES DO NOT EXIST
         fi
      fi   
#
# RUN_IASI_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${PAST_YYYY}
         export L_MM=${PAST_MM}
         export L_DD=${PAST_DD}
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
      if [[ ${L_HH} -eq 24 ]]; then
         NL_BIN_BEG=21.01
         NL_BIN_END=3.00
      elif [[ ${L_HH} -eq 6 ]]; then
         NL_BIN_BEG=3.01
         NL_BIN_END=9.00
      elif [[ ${L_HH} -eq 12 ]]; then
         NL_BIN_BEG=9.01
         NL_BIN_END=15.00
      elif [[ ${L_HH} -eq 18 ]]; then
         NL_BIN_BEG=15.01
         NL_BIN_END=21.00
      fi
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET ASCII DATA
      if [[ ! -e ${D_DATE}.dat ]]; then 
         echo APM IASI O3 ASCII FILE DOES NOTE EXIST
         exit
      fi
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/work/iasi_o3_profile_ascii_to_obs ./.
      ./iasi_o3_profile_ascii_to_obs > index.html 2>&1  
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export IASI_FILE=iasi_obs_seq${D_DATE}
      if [[ -s ${IASI_FILE} ]]; then
         cp ${IASI_FILE} obs_seq_iasi_o3_profile_${DATE}.out
      else
         touch NO_DATA_${D_DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI O3 CPSR OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs
      fi
#
# copy the IASI O3 error covariance file
      cp ${EXPERIMENT_IASI_O3_DIR}/IASI_apcov.dat ./
#
# set file prefix for IASI
# this depends on versions and file times (edit if necessary)
      export FILE_PRE='METOPA_IASI_EUMC_'
#
# set file suffix for IASI
# this depends on versions and file times (edit if necessary)
      export FILE_EXT='.dat'
#
      if [[ ${HH} == 00 ]]; then
#
# 00Z special case
         let TEMP_MIN_HH=${ASIM_MIN_HH}
         let TEMP_MAX_HH=${ASIM_MAX_HH}
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
         rm -rf ${ASIM_OUTFILE}
         touch ${ASIM_OUTFILE}
#
# Past date
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=24*60*60 ))
         export FILE_COL=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_Columns${FILE_EXT}
         export FILE_ERR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_ERROR${FILE_EXT}
         export FILE_VMR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_VMR${FILE_EXT}
         if [[ -e ${FILE_COL} && -e ${FILE_ERR} && -e ${FILE_VMR} ]]; then 
            export OUTFILE_NM=TEMP_FILE.dat
            export INFILE_COL=\'${FILE_COL}\'
            export INFILE_ERR=\'${FILE_ERR}\'
            export INFILE_VMR=\'${FILE_VMR}\'
            export OUTFILE=\'${OUTFILE_NM}\'
#
# this is the call to an IDL routine to read and write variables
# if already processed (with output), then this can be skipped (do_iasi=0)
# else this needs to be called
            export FILE=iasi_o3_cpsr_extract.pro
            rm -rf ${FILE}
            cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/native_to_ascii/${FILE} ./.
#
            rm -rf job.ksh
            touch job.ksh
            RANDOM=$$
            export JOBRND=${RANDOM}_idl_iasi
            cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_o3_cpsr_extract.pro
iasi_o3_cpsr_extract,${INFILE_COL},${INFILE_ERR},${INFILE_VMR},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}, ${DATE}
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
#            qsub -Wblock=true job.ksh 
            chmod +x job.ksh
            ./job.ksh > index_m.html 2>&1
#
# cat the output file to the assimlation window file
            export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
            if [[ -e ${OUTFILE_NM} ]]; then
               cat ${OUTFILE_NM} >> ${ASIM_OUTFILE}
#               rm -rf ${OUTFILE_NM}
            fi
         else
            echo APM IASI O3 INPUT FILES DO NOT EXIST
         fi
      else
#
# OOZ, 06Z, 12Z, 18Z normal cases
         let TEMP_MIN_HH=${ASIM_MIN_HH}
         let TEMP_MAX_HH=${ASIM_MAX_HH}
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         if [[ ${HH} == 00 ]]; then
            (( BIN_BEG_SEC=1 ))
            (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         fi
         export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
         rm -rf ${ASIM_OUTFILE}
         touch ${ASIM_OUTFILE}
         export FILE_COL=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_Columns${FILE_EXT}
         export FILE_ERR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_ERROR${FILE_EXT}
         export FILE_VMR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_VMR${FILE_EXT}
         if [[ -e ${FILE_COL} && -e ${FILE_ERR} && -e ${FILE_VMR} ]]; then 
            export OUTFILE_NM=TEMP_FILE.dat
            export INFILE_COL=\'${FILE_COL}\'
            export INFILE_ERR=\'${FILE_ERR}\'
            export INFILE_VMR=\'${FILE_VMR}\'
            export OUTFILE=\'${OUTFILE_NM}\'
#
# this is the call to an IDL routine to read and write variables
# if already processed (with output), then this can be skipped (do_iasi=0)
# else this needs to be called
            export FILE=iasi_o3_cpsr_extract.pro
            rm -rf ${FILE}
            cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/native_to_ascii/${FILE} ./.
#
            rm -rf job.ksh
            touch job.ksh
            RANDOM=$$
            export JOBRND=${RANDOM}_idl_iasi
            cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_o3_cpsr_extract.pro
iasi_o3_cpsr_extract,${INFILE_COL},${INFILE_ERR},${INFILE_VMR},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}, ${DATE}
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
#            qsub -Wblock=true job.ksh 
            chmod +x job.ksh
            ./job.ksh > index_mat.html 2>&1
#
# cat the output file to the assimlation window file
            export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
            if [[ -e ${OUTFILE_NM} ]]; then
               cat ${OUTFILE_NM} >> ${ASIM_OUTFILE}
#               rm -rf ${OUTFILE_NM}
            fi
         else
            echo APM IASI O3 INPUT FILES DO NOT EXIST
         fi
      fi   
#
# RUN_IASI_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${PAST_YYYY}
         export L_MM=${PAST_MM}
         export L_DD=${PAST_DD}
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
      if [[ ${L_HH} -eq 24 ]]; then
         NL_BIN_BEG=21.01
         NL_BIN_END=3.00
      elif [[ ${L_HH} -eq 6 ]]; then
         NL_BIN_BEG=3.01
         NL_BIN_END=9.00
      elif [[ ${L_HH} -eq 12 ]]; then
         NL_BIN_BEG=9.01
         NL_BIN_END=15.00
      elif [[ ${L_HH} -eq 18 ]]; then
         NL_BIN_BEG=15.01
         NL_BIN_END=21.00
      fi
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET ASCII DATA
      if [[ ! -e ${D_DATE}.dat ]]; then 
         echo APM IASI O3 ASCII FILE DOES NOTE EXIST
         exit
      fi
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/work/iasi_o3_cpsr_ascii_to_obs ./.
      ./iasi_o3_cpsr_ascii_to_obs > index.html 2>&1  
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export IASI_FILE=iasi_obs_seq${D_DATE}
      if [[ -s ${IASI_FILE} ]]; then
         cp ${IASI_FILE} obs_seq_iasi_o3_cpsr_${DATE}.out
      else
         touch NO_DATA_${D_DATE}
      fi
   fi
#
   
