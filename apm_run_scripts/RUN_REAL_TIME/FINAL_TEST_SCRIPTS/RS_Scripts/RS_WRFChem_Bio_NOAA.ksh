#!/bin/ksh -aux
      cd ${RUN_DIR}/${DATE}/wrfchem_bio
#
# LOOP THROUGHT CURRENT AND NEXT DATE
      export L_DATE=${DATE}00
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} -f ccyymmddhhnn 2>/dev/null)
      while [[ ${L_DATE} -le ${LE_DATE} ]]; do 
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
         export L_MN=$(echo $L_DATE | cut -c11-12)
         export L_SS=$(echo $L_DATE | cut -c13-14)
	 export L_SS=00
         export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
#
# LINK NEEDED FILES
         export FILE_CR=wrfinput_d${CR_DOMAIN}
         export FILE_FR=wrfinput_d${FR_DOMAIN}
         rm -rf ${FILE_CR}
         rm -rf ${FILE_FR}
         cp ${REAL_DIR}/${FILE_CR}_${L_FILE_DATE} ${FILE_CR}
         if [[ ${MAX_DOMAINS} == 2 ]]; then
            cp ${REAL_DIR}/${FILE_FR}_${L_FILE_DATE} ${FILE_FR}   
         fi
         export FILE_CR=wrfbiochemi_d${CR_DOMAIN}
         export FILE_FR=wrfbiochemi_d${FR_DOMAIN}
         if [[ ${L_DATE} -eq ${DATE} ]]; then
            rm -rf ${FILE_CR}
            rm -rf ${FILE_FR}
         fi
         rm -rf btr*.nc
         rm -rf DSW*.nc
         rm -rf hrb*.nc
         rm -rf iso*.nc
         rm -rf lai*.nc
         rm -rf ntr*.nc
         rm -rf shr*.nc
         rm -rf TAS*.nc
         cp ${EXPERIMENT_WRFBIOCHEMI_DIR}/MEGAN-DATA/*.nc ./.
         export FILE=megan_bio_emiss.exe
         rm -rf ${FILE}
         cp ${MEGAN_BIO_DIR}/work/${FILE} ${FILE}
#
# CREATE INPUT FILE
         export FILE=megan_bio_emiss.inp
         rm -rf ${FILE}
         cat << EOF > ${FILE}
&control
domains = ${MAX_DOMAINS},
start_lai_mnth = 1,
end_lai_mnth = 12
/
EOF
#
         RANDOM=$$
         export JOBRND=${RANDOM}_bio
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${BIO_JOB_CLASS} ${BIO_TIME_LIMIT} ${BIO_NODES} ${BIO_TASKS} "megan_bio_emiss.exe < megan_bio_emiss.inp" SERIAL ${ACCOUNT} ${BIO_MODEL}
         qsub -Wblock=true job.ksh
#
# TEST WHETHER OUTPUT EXISTS
         export FILE_CR=wrfbiochemi_d${CR_DOMAIN}
         export FILE_FR=wrfbiochemi_d${FR_DOMAIN}
         if [[ ! -e ${FILE_CR} || (${MAX_DOMAINS} == 2 && ! -e ${FILE_FR}) ]]; then
            echo WRFCHEM_BIO FAILED
            exit
         else
            echo WRFCHEM_BIO SUCCESS
            mv ${FILE_CR} ${FILE_CR}_${L_FILE_DATE}
            if [[ ${MAX_DOMAINS} == 2 ]]; then
               mv ${FILE_FR} ${FILE_FR}_${L_FILE_DATE}
            fi
         fi
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${LBC_FREQ_TEXT} -f ccyymmddhhnn 2>/dev/null)
      done
#
# Clean directory
#      rm btr2001* DSW.nc hrb2001* isoall2000* laiv2003* megan_bio_emiss.* ntr2001*
#      rm shr2001* TAS.nc wrfinput_d* 
