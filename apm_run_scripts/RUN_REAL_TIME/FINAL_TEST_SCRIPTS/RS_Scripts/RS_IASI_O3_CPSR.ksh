#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs
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
            ./job.ksh > index_mat2.html 2>&1
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
#
# Clean directory
#      rm *.dat bias_correct* dart_log* input.nml job.ksh iasi_o3_cpsr*      
