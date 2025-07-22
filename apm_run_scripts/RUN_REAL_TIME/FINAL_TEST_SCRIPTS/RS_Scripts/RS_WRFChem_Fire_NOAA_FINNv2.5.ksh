#!/bin/ksh -aux
      cd ${RUN_DIR}/${DATE}/wrfchem_fire
#
# LINK NEEDED FILES
      export FILE_CR=wrfinput_d${CR_DOMAIN}
#      export FILE_FR=wrfinput_d${FR_DOMAIN}
      rm -rf ${FILE_CR}
#      rm -rf ${FILE_FR}
      ln -sf ${REAL_DIR}/${FILE_CR}_${FILE_DATE} ${FILE_CR}   
#      ln -sf ${REAL_DIR}/${FILE_FR}_${FILE_DATE} ${FILE_FR}   
      rm -rf GLOBAL_FINNv25_*.txt
      cp ${EXPERIMENT_WRFFIRECHEMI_DIR}/${YYYY}/${NL_FIRE_FILE} ./.
      export FILE=fire_emis
      rm -rf ${FILE}
      cp ${EXPERIMENT_WRFFIRECHEMI_DIR}/${YYYY}/${FILE} ./.
      rm -rf grass_from_img.nc
      rm -rf shrub_from_img.nc
      rm -rf tempfor_from_img.nc
      rm -rf tropfor_from_img.nc
      ln -sf ${EXPERIMENT_WRFFIRECHEMI_DIR}/${YYYY}/*img.nc ./.
#
# CREATE INPUT FILE
      export FILE_nml=fire_emis.mozc.inp
      rm -rf ${FILE_nml}
      cat << EOF > ${FILE_nml}
&control
domains = ${MAX_DOMAINS},
fire_filename(1) = '${NL_FIRE_FILE}',
start_date = '${FIRE_START_DATE}', 
end_date = '${FIRE_END_DATE}',
fire_directory = './',
wrf_directory = './',
wrf2fire_map = 'co -> CO', 'no2 -> NO2', 'so2 -> SO2', 'iso -> ISOP',
               'csl -> CRESOL', 'ald -> CH3CHO+GLYALD', 'hcho -> CH2O',
               'no -> NO', 'ora2 -> CH3COOH', 'hc3 -> C3H8', 'hc5 -> C2H4', 
               'hc8 -> BIGALK', 'eth -> C2H6', 'olt -> C3H6', 'oli -> BIGENE',
               'tol -> TOLUENE', 'xyl -> XYLENE', 'ket -> CH3COCH3 + MEK', 
               'ch4 -> CH4', 'oc -> 1.4*OC;aerosol', 'bc -> BC;aerosol',
               'pm25 -> PM25 + -1.*OC + 1.*BC;aerosol', 'pm10->PM10 + -1.*PM25;aerosol',
/
EOF
#
      RANDOM=$$
      export JOBRND=${RANDOM}_fire
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} "fire_emis.exe < fire_emis.mozc.inp" SERIAL ${ACCOUNT}
#      qsub -Wblock=true job.ksh
      chmod +x fire_emis
      ./fire_emis < fire_emis.mozc.inp > index.html 2>&1
      #
      export L_DATE=${DATE}00
      while [[ ${L_DATE} -le ${END_DATE} ]]; do
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
         export L_MN=$(echo $L_DATE | cut -c11-12)
         export L_SS=$(echo $L_DATE | cut -c13-14)
	 export L_SS=00
         export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
         export DD_DATE=${L_YYYY}${L_MM}${L_DD}
#
# TEST WHETHER OUTPUT EXISTS
         export FILE_CR=wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}
         export FILE_FR=wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE}
         if [[ ! -e ${FILE_CR} || (${MAX_DOMAINS} -eq 2 && ! -e ${FILE_FR}) ]]; then
            echo WRFFIRE FAILED
            exit
         else
            echo WRFFIRE SUCCESS
         fi
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 -f ccyymmddhhnn 2>/dev/null)
      done
#
# Clean directory
#      rm fire_emis* GLOBAL_FINNv15* grass_from_img* shrub_from_img* tempfor_from_img*
#      rm tropfor_from_img* wrfinput_d*
