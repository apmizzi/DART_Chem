#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/ungrib
#
      rm -rf GRIBFILE.*
      cp ${VTABLE_DIR}/Vtable.${VTABLE_TYPE} Vtable
      cp ${WPS_DIR}/ungrib.exe ./.
#
      export L_FCST_RANGE=${LBC_END}
      export L_START_DATE=${DATE}
      export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} ${L_FCST_RANGE} 2>/dev/null)
      export L_START_YEAR=$(echo $L_START_DATE | cut -c1-4)
      export L_START_MONTH=$(echo $L_START_DATE | cut -c5-6)
      export L_START_DAY=$(echo $L_START_DATE | cut -c7-8)
      export L_START_HOUR=$(echo $L_START_DATE | cut -c9-10)
      export L_END_YEAR=$(echo $L_END_DATE | cut -c1-4)
      export L_END_MONTH=$(echo $L_END_DATE | cut -c5-6)
      export L_END_DAY=$(echo $L_END_DATE | cut -c7-8)
      export L_END_HOUR=$(echo $L_END_DATE | cut -c9-10)
      export NL_START_YEAR=$(echo $L_START_DATE | cut -c1-4),$(echo $L_START_DATE | cut -c1-4)
      export NL_START_MONTH=$(echo $L_START_DATE | cut -c5-6),$(echo $L_START_DATE | cut -c5-6)
      export NL_START_DAY=$(echo $L_START_DATE | cut -c7-8),$(echo $L_START_DATE | cut -c7-8)
      export NL_START_HOUR=$(echo $L_START_DATE | cut -c9-10),$(echo $L_START_DATE | cut -c9-10)
      export NL_END_YEAR=$(echo $L_END_DATE | cut -c1-4),$(echo $L_END_DATE | cut -c1-4)
      export NL_END_MONTH=$(echo $L_END_DATE | cut -c5-6),$(echo $L_END_DATE | cut -c5-6)
      export NL_END_DAY=$(echo $L_END_DATE | cut -c7-8),$(echo $L_END_DATE | cut -c7-8)
      export NL_END_HOUR=$(echo $L_END_DATE | cut -c9-10),$(echo $L_END_DATE | cut -c9-10)
      export NL_START_DATE=\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\',\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\'
      export NL_END_DATE=\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\',\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\'
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wps_namelist_RT.ksh
#
# UNTAR THE PARENT FORECAST FILES
      FILES=''
      if [[ -e ${EXPERIMENT_LS_MET}/${DATE} ]]; then
         if [[ -e ${EXPERIMENT_LS_MET}/${DATE}/${GRIB_PART1}${DATE}${GRIB_PART2} ]]; then
            tar xvfs ${EXPERIMENT_LS_MET}/${DATE}/${GRIB_PART1}${DATE}${GRIB_PART2}
         else
            echo 'APM: ERROR - No GRIB files in directory'
            exit
         fi
         sleep 15
#  
         if [[ ${SINGLE_FILE} == false ]]; then
            export CCHH=${HH}00
            (( LBC_ITR=${LBC_START} ))
            while [[ ${LBC_ITR} -le ${LBC_END} ]]; do
               if [[ ${LBC_ITR} -lt 1000 ]]; then export CFTM=${LBC_ITR}; fi
               if [[ ${LBC_ITR} -lt 100  ]]; then export CFTM=0${LBC_ITR}; fi
               if [[ ${LBC_ITR} -lt 10   ]]; then export CFTM=00${LBC_ITR}; fi
               if [[ ${LBC_ITR} -eq 0    ]]; then export CFTM=000; fi
#               export FILE=${EXPERIMENT_LS_MET}/${DATE}/${GRIB_PART1}${START_YEAR}${START_MONTH}${START_DAY}_${CCHH}_${CFTM}.grb2
               export FILE=${GRIB_PART1}${START_YEAR}${START_MONTH}${START_DAY}_${CCHH}_${CFTM}.grb2
               FILES="${FILES} ${FILE}"
               (( LBC_ITR=${LBC_ITR}+${LBC_FREQ} ))
            done
         else
            echo 'APM: Large scale single file input option does not work'
         fi
      fi
#
# LINK GRIB FILES
      ${WPS_DIR}/link_grib.csh $FILES
#      RANDOM=$$
#      export JOBRND=${RANDOM}_ungrib
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} ungrib.exe SERIAL ${ACCOUNT}
#      qsub -Wblock=true job.ksh
      rm -rf index.html
      chmod +x ungrib.exe
      ./ungrib.exe > index.html 2>&1
#
# Clean directory
      rm -rf GRIBFILE* gfs_4_*      
      rm namelist.wps ungrib.exe ungrib.log Vtable
