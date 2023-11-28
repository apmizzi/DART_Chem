#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/iasi_co_cpsr_obs
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
               ./job.ksh > index_mat1.html 2>&1
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
                  ./job.ksh > index_mat2.html 2>&1
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
      export NL_IAS_OUTFILE=obs_seq_iasi_co_cpsr_${DATE}.out
      if [[ -s ${IAS_OUTFILE_NQ} ]]; then
         cp IASI_CO_${D_DATE}.dat ${D_DATE}.dat
         export NL_FILEDIR=\'./\' 
         export NL_FILENAME=${D_DATE}.dat
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
      fi
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_IAS_OUTFILE} ]]; then
         touch NO_IASI_CO_${DATE}
      fi
      rm *.dat *.pro dart_log* input.nml job.ksh iasi_co_profile* 
