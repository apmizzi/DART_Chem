#!/bin/ksh -aux
#
#########################################################################
#
# RUN WRFCHEM_CHEMI
#
#########################################################################
#
   if ${RUN_WRFCHEM_CHEMI}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_chemi ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_chemi
         cd ${RUN_DIR}/${DATE}/wrfchem_chemi
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_chemi
      fi
      export L_DATE=${DATE}
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
#
      while [[ ${L_DATE} -le ${LE_DATE} ]]; do
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
#
         export FILE_PATH=${EXPERIMENT_WRFCHEMI_DIR}
         cp ${FILE_PATH}/wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00 ./.
         cp ${FILE_PATH}/wrfchemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00 ./.
         chmod 644 wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00 
         chmod 644 wrfchemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00 
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
      done
   fi
#
