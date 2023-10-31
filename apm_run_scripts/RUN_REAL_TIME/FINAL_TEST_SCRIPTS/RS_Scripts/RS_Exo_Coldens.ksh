#!/bin/ksh -aux
#
   cd ${RUN_DIR}/${DATE}/exo_coldens
#
# LINK NEEDED FILES
      export FILE_CR=wrfinput_d${CR_DOMAIN}
      export FILE_FR=wrfinput_d${FR_DOMAIN}
      rm -rf ${FILE_CR}
      rm -rf ${FILE_FR}
      ln -sf ${REAL_DIR}/${FILE_CR}_${FILE_DATE} ${FILE_CR}
      if [[ ${MAX_DOMAINS} == 2 ]]; then
         ln -sf ${REAL_DIR}/${FILE_FR}_${FILE_DATE} ${FILE_FR}
      fi
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
domains = ${MAX_DOMAINS},
/
EOF
#
# RUN exo_coldens
      rm -rf index.html
      chmod +x exo_coldens.exe
      ./exo_coldens.exe < exo_coldens.inp > index.html 2>&1
#
# TEST WHETHER OUTPUT EXISTS
      export FILE_CR=exo_coldens_d${CR_DOMAIN}
      export FILE_FR=exo_coldens_d${FR_DOMAIN}
      if [[ ! -e ${FILE_CR} || (${MAX_DOMAINS} == 2 && ! -e ${FILE_FR}) ]]; then
         echo EXO_COLDENS FAILED
         exit
      else
         echo EXO_COLDENS SUCCESS
      fi
#
# Clean directory
      rm exo_coldens.exe exo_coldens.inp exo_coldens.nc wrfinput_d*      
