#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/ungrib
#
      rm -rf GRIBFILE.*
      cp ${VTABLE_DIR}/Vtable.${VTABLE_TYPE} Vtable
      cp ${WPS_DIR}/ungrib.exe ./.
#
      export L_FCST_RANGE=${LBC_END}
      export L_DATE=${DATE}00
      export L_YYYY=$(echo ${L_DATE} | cut -c1-4)
      export L_MM=$(echo ${L_DATE} | cut -c5-6)
      export L_DD=$(echo ${L_DATE} | cut -c7-8)
      export L_HH=$(echo ${L_DATE} | cut -c9-10)
      export L_MN=$(echo ${L_DATE} | cut -c11-12)
      export L_SS=$(echo ${L_DATE} | cut -c13-14)
      export L_SS=00
#
      if [[ ${L_HH} -eq 03 || ${L_HH} -eq 09 || ${L_HH} -eq 15 || ${L_HH} -eq 21 ]]; then
         export L_START_DATE=$($BUILD_DIR/da_advance_time.exe ${L_DATE} -3 -f ccyymmddhhnn  2>/dev/null)
         export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} 12 -f ccyymmddhhnn  2>/dev/null)
      else
         export L_START_DATE=${L_DATE}
         export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} ${L_FCST_RANGE} -f ccyymmddhhnn 2>/dev/null)
      fi
#      
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
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wps_namelist_RT_NOAA.ksh
#
# UNTAR THE PARENT FORECAST FILES
      ln -sf ${EXPERIMENT_NAM_DIR}/${L_START_YEAR}/${L_START_MONTH}/${L_START_DAY}/namanl_218_${L_START_YEAR}${L_START_MONTH}${L_START_DAY}* .
      ln -sf ${EXPERIMENT_NAM_DIR}/${L_END_YEAR}/${L_END_MONTH}/${L_END_DAY}/namanl_218_${L_END_YEAR}${L_END_MONTH}${L_END_DAY}* .
#
# LINK GRIB FILES
      ${WPS_DIR}/link_grib.csh nam*218*
#      RANDOM=$$
#      export JOBRND=${RANDOM}_ungrib
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} ungrib.exe SERIAL ${ACCOUNT}
#      qsub -Wblock=true job.ksh
      rm -rf index.html
      chmod +x ungrib.exe
      ./ungrib.exe > index.html 2>&1
#
# Clean directory
#      rm -rf GRIBFILE* gfs_4_*      
#      rm namelist.wps ungrib.exe ungrib.log Vtable
#
      
