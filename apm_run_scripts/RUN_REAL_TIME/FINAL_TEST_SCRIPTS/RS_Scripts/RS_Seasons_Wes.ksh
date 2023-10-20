#!/bin/ksh -aux
#
   cd ${RUN_DIR}/${DATE}/seasons_wes
#
# LINK NEEDED FILES
      export FILE_CR=wrfinput_d${CR_DOMAIN}
      export FILE_FR=wrfinput_d${FR_DOMAIN}
      rm -rf ${FILE_CR}
      rm -rf ${FILE_FR}
      ln -sf ${REAL_DIR}/${FILE_CR}_${FILE_DATE} ${FILE_CR}   
      ln -sf ${REAL_DIR}/${FILE_FR}_${FILE_DATE} ${FILE_FR}   
      export FILE=season_wes_usgs.nc
      rm -rf ${FILE}
      ln -sf ${EXPERIMENT_COLDENS_DIR}/${FILE} ${FILE}
      export FILE=wesely.exe
      rm -rf ${FILE}
      ln -sf ${WES_COLDENS_DIR}/work/${FILE} ${FILE}
#
# CREATE INPUT FILE
      export FILE=wesely.inp
      rm -rf ${FILE}
      cat << EOF > ${FILE}
&control
domains = 2,
/
EOF
#
# RUN wesely
      rm -rf index.html
      chmod +x wesely.exe
      ./wesely.exe < wesely.inp > index.html 2>&1
#
# TEST WHETHER OUTPUT EXISTS
      export FILE_CR=wrf_season_wes_usgs_d${CR_DOMAIN}.nc
      export FILE_FR=wrf_season_wes_usgs_d${FR_DOMAIN}.nc
      if [[ ! -e ${FILE_CR} || ! -e ${FILE_FR} ]]; then
         echo WESELY FAILED
         exit
      else
         echo WESELY SUCCESS
      fi
#
# Clean directory
      rm season_wes_usgs.nc wesely.exe wesely.inp wrfinput_d*
