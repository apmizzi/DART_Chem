#!/bin/ksh -aux
#
#########################################################################
#
# RUN EXO_COLDENS
#
#########################################################################
#
   if ${RUN_EXO_COLDENS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/exo_coldens ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/exo_coldens
         cd ${RUN_DIR}/${DATE}/exo_coldens
      else
         cd ${RUN_DIR}/${DATE}/exo_coldens
      fi
#
# LINK NEEDED FILES
      export FILE_CR=wrfinput_d${CR_DOMAIN}
      export FILE_FR=wrfinput_d${FR_DOMAIN}
      rm -rf ${FILE_CR}
      rm -rf ${FILE_FR}
      ln -sf ${REAL_DIR}/${FILE_CR}_${FILE_DATE} ${FILE_CR}   
      ln -sf ${REAL_DIR}/${FILE_FR}_${FILE_DATE} ${FILE_FR}   
      export FILE=exo_coldens.nc
      rm -rf ${FILE}
      ln -sf ${EXPERIMENT_COLDENS_DIR}/${FILE} ${FILE}
      export FILE=exo_coldens.exe
      rm -rf ${FILE}
      ln -sf ${WES_COLDENS_DIR}/work/${FILE} ${FILE}
#
# CREATE INPUT FILE
      export FILE=exo_coldens.inp
      rm -rf ${FILE}
      cat << EOF > ${FILE}
&control
domains = 2,
/
EOF
#
# RUN exo_coldens
      rm -rf index.html
      chmod +x exo_coldens.exe
      ./exo_coldens.exe < exo_coldens.inp > index 2>&1
#
# TEST WHETHER OUTPUT EXISTS
      export FILE_CR=exo_coldens_d${CR_DOMAIN}
      export FILE_FR=exo_coldens_d${FR_DOMAIN}
      if [[ ! -e ${FILE_CR} || ! -e ${FILE_FR} ]]; then
         echo EXO_COLDENS FAILED
         exit
      else
         echo EXO_COLDENS SUCCESS
      fi
   fi
#
