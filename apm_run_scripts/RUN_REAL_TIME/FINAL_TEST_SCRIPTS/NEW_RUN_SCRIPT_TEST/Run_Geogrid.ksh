#!/bin/ksh -aux
#
#########################################################################
#
# RUN GEOGRID
#
#########################################################################
#
   if [[ ${RUN_GEOGRID} = "true" ]]; then
      mkdir -p ${RUN_DIR}/geogrid
      cd ${RUN_DIR}/geogrid
#
      cp ${WPS_DIR}/geogrid.exe ./.
      export NL_DX=${DX_CR}
      export NL_DY=${DX_CR}
      export NL_START_DATE=${FILE_DATE}
      export NL_END_DATE=${NEXT_FILE_DATE}
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wps_namelist_RT.ksh
#
#      RANDOM=$$
#      export JOBRND=${RANDOM}_geogrid
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} geogrid.exe SERIAL ${ACCOUNT}
#      qsub -Wblock=true job.ksh
      rm -rf index.html
      chmod +x geogrid.exe
      ./geogrid.exe > index.html 2>&1
   fi
#
