#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/real
#
      cp ${WRF_DIR}/main/real.exe ./.
      cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v1 ./.
      cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v2 ./.
#
# LINK IN THE METGRID FILES
      export P_DATE=${DATE}00
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_END} -f ccyymmddhhnn 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_MN=$(echo $P_DATE | cut -c11-12)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:${P_MN}:00.nc
         ln -sf ${RUN_DIR}/${DATE}/metgrid/met_em.d${CR_DOMAIN}.${P_FILE_DATE} ./.
#         ln -sf ${RUN_DIR}/${DATE}/metgrid/met_em.d${FR_DOMAIN}.${P_FILE_DATE} ./.
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ_TEXT} -f ccyymmddhhnn 2>/dev/null) 
      done
#
# LOOP THROUGH BDY TENDENCY TIMES FOR PERTURB_BC
      export P_DATE=${DATE}00
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} -f ccyymmddhhnn 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do      
#
# CREATE WRF NAMELIST
         export NL_IOFIELDS_FILENAME=' '
         export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\',\'hist_io_flds_v2\'
         export L_FCST_RANGE=${FCST_PERIOD}
         export NL_DX=${DX_CR},${DX_FR}
         export NL_DY=${DX_CR},${DX_FR}
         export L_START_DATE=${P_DATE}
         export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} ${L_FCST_RANGE} -f ccyymmddhhnn 2>/dev/null)
         export L_START_YEAR=$(echo $L_START_DATE | cut -c1-4)
         export L_START_MONTH=$(echo $L_START_DATE | cut -c5-6)
         export L_START_DAY=$(echo $L_START_DATE | cut -c7-8)
         export L_START_HOUR=$(echo $L_START_DATE | cut -c9-10)
         export L_START_MINUTE=$(echo $L_START_DATE | cut -c11-12)
         export L_START_SECOND=$(echo $L_START_DATE | cut -c13-14)
	 export L_START_SECOND=00
         export L_END_YEAR=$(echo $L_END_DATE | cut -c1-4)
         export L_END_MONTH=$(echo $L_END_DATE | cut -c5-6)
         export L_END_DAY=$(echo $L_END_DATE | cut -c7-8)
         export L_END_HOUR=$(echo $L_END_DATE | cut -c9-10)
         export L_END_MINUTE=$(echo $L_END_DATE | cut -c11-12)
         export L_END_SECOND=$(echo $L_END_DATE | cut -c13-15)
	 export L_END_SECOND=00
         export NL_START_YEAR=$(echo $L_START_DATE | cut -c1-4),$(echo $L_START_DATE | cut -c1-4)
         export NL_START_MONTH=$(echo $L_START_DATE | cut -c5-6),$(echo $L_START_DATE | cut -c5-6)
         export NL_START_DAY=$(echo $L_START_DATE | cut -c7-8),$(echo $L_START_DATE | cut -c7-8)
         export NL_START_HOUR=$(echo $L_START_DATE | cut -c9-10),$(echo $L_START_DATE | cut -c9-10)
         export NL_START_MINUTE=$(echo $L_START_DATE | cut -c11-12),$(echo $L_START_DATE | cut -c11-12)
         export NL_START_SECOND=$(echo $L_START_DATE | cut -c13-14),$(echo $L_START_DATE | cut -c13-14)
         export NL_START_SECOND=00,00
         export NL_END_YEAR=$(echo $L_END_DATE | cut -c1-4),$(echo $L_END_DATE | cut -c1-4)
         export NL_END_MONTH=$(echo $L_END_DATE | cut -c5-6),$(echo $L_END_DATE | cut -c5-6)
         export NL_END_DAY=$(echo $L_END_DATE | cut -c7-8),$(echo $L_END_DATE | cut -c7-8)
         export NL_END_HOUR=$(echo $L_END_DATE | cut -c9-10),$(echo $L_END_DATE | cut -c9-10)
         export NL_END_MINUTE=$(echo $L_END_DATE | cut -c11-12),$(echo $L_END_DATE | cut -c11-12)
         export NL_END_SECOND=$(echo $L_END_DATE | cut -c13-14),$(echo $L_END_DATE | cut -c13-14)
         export NL_END_SECOND=00,00
         export NL_START_DATE=\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:${L_START_MINUTE}:${L_START_SECOND}\',\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:${L_START_MINUTE}:${L_START_SECOND}\'
         export NL_END_DATE=\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:${L_END_MINUTE}:${L_END_SECOND}\',\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:${L_END_MINUTE}:${L_END_SECOND}\'
	 
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfchem_namelist_REAL_NOAA.ksh
#
#         RANDOM=$$
#         export JOBRND=${RANDOM}_real
#         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} real.exe SERIAlessL ${ACCOUNT}
#         qsub -Wblock=true job.ksh
         rm -rf index.html
         chmod +x real.exe
         ./real.exe > index.html 2>&1
#
         mv wrfinput_d${CR_DOMAIN} wrfinput_d${CR_DOMAIN}_$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
         mv wrfbdy_d${CR_DOMAIN} wrfbdy_d${CR_DOMAIN}_$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
         mv wrflowinp_d${CR_DOMAIN} wrflowinp_d${CR_DOMAIN}_$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
#         mv wrfinput_d${FR_DOMAIN} wrfinput_d${FR_DOMAIN}_$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
#         mv wrfbdy_d${FR_DOMAIN} wrfbdy_d${FR_DOMAIN}_$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
#
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ_TEXT} -f ccyymmddhhnn 2>/dev/null) 
      done
#
# Clean directory
#      rm hist_io_flds* namelist.* real.exe met_em.d* index.html
