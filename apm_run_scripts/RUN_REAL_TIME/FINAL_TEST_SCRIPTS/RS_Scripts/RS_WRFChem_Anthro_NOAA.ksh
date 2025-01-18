#!/bin/ksh -aux
   cd ${RUN_DIR}/${DATE}/wrfchem_chemi
#
   export L_DATE=${DATE}00
   export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} -f ccyymmddhhnn 2>/dev/null)
#
   while [[ ${L_DATE} -le ${LE_DATE} ]]; do
      export L_YYYY=$(echo $L_DATE | cut -c1-4)
      export L_MM=$(echo $L_DATE | cut -c5-6)
      export L_DD=$(echo $L_DATE | cut -c7-8)
      export L_HH=$(echo $L_DATE | cut -c9-10)
      export L_MN=$(echo $L_DATE | cut -c11-12)
      export L_SS=$(echo $L_DATE | cut -c13-14)
      export L_SS=00
#
      export FILE_PATH=${EXPERIMENT_WRFCHEMI_DIR}/${L_YYYY}/${L_MM}/${L_DD}
      cp ${FILE_PATH}/wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS} ./wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
      chmod 644 wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
      if [[ ${MAX_DOMAINS} == 2 ]]; then
         cp ${FILE_PATH}/wrfchemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS} ./.
         chmod 644 wrfchemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
      fi 
      export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 -f ccyymmddhhnn 2>/dev/null)
   done
