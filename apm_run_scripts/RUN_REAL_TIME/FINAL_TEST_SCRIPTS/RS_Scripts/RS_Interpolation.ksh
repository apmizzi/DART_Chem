#!/bin/ksh -aux
#
# for 2014072212 and 2014072218
# export BACK_DATE=2014072206
# export FORW_DATE=2014072300
# BACK_WT=.3333
# BACK_WT=.6667
#
# for 20142900
# export BACK_DATE=2014072818
# export FORW_DATE=2014072906
# BACK_WT=.5000
#
# for 20142912
# export BACK_DATE=2014072906
# export FORW_DATE=2014072918
# BACK_WT=.5000
#
#
#########################################################################
#
# RUN INTERPOLATION TO GET MISSING BACKGROUND DATA
#
#########################################################################
#
   if [[ ${RUN_INTERPOLATE} = "true" ]]; then 
      if [[ ! -d ${RUN_DIR}/${DATE}/metgrid ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/metgrid
      fi
      if [[ ! -d ${RUN_DIR}/${DATE}/real ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/real
      fi
#
# GET METGRID DATA
      cd ${RUN_DIR}/${DATE}/metgrid
      rm -rf met_em.d*
#
# LINK IN THE BACK AND FORW METGRID FILES
      export P_DATE=${BACK_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_END} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00.nc
         ln -sf ${RUN_DIR}/${BACK_DATE}/metgrid/met_em.d${CR_DOMAIN}.${P_FILE_DATE} ./BK_met_em.d${CR_DOMAIN}.${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${BACK_DATE}/metgrid/met_em.d${FR_DOMAIN}.${P_FILE_DATE} ./BK_met_em.d${FR_DOMAIN}.${P_FILE_DATE}
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
      export P_DATE=${FORW_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_END} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00.nc
         ln -sf ${RUN_DIR}/${FORW_DATE}/metgrid/met_em.d${CR_DOMAIN}.${P_FILE_DATE} ./FW_met_em.d${CR_DOMAIN}.${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${FORW_DATE}/metgrid/met_em.d${FR_DOMAIN}.${P_FILE_DATE} ./FW_met_em.d${FR_DOMAIN}.${P_FILE_DATE}
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
#
# DO INTERPOLATION
      export P_DATE=${DATE}
      export P_BACK_DATE=${BACK_DATE}
      export P_FORW_DATE=${FORW_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_END} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00
         export P_BK_YYYY=$(echo $P_BACK_DATE | cut -c1-4)
         export P_BK_MM=$(echo $P_BACK_DATE | cut -c5-6)
         export P_BK_DD=$(echo $P_BACK_DATE | cut -c7-8)
         export P_BK_HH=$(echo $P_BACK_DATE | cut -c9-10)
         export P_BACK_FILE_DATE=${P_BK_YYYY}-${P_BK_MM}-${P_BK_DD}_${P_BK_HH}:00:00
         export P_FW_YYYY=$(echo $P_FORW_DATE | cut -c1-4)
         export P_FW_MM=$(echo $P_FORW_DATE | cut -c5-6)
         export P_FW_DD=$(echo $P_FORW_DATE | cut -c7-8)
         export P_FW_HH=$(echo $P_FORW_DATE | cut -c9-10)
         export P_FORW_FILE_DATE=${P_FW_YYYY}-${P_FW_MM}-${P_FW_DD}_${P_FW_HH}:00:00
         export BACK_FILE_CR=BK_met_em.d${CR_DOMAIN}.${P_BACK_FILE_DATE}.nc
         export BACK_FILE_FR=BK_met_em.d${FR_DOMAIN}.${P_BACK_FILE_DATE}.nc
         export FORW_FILE_CR=FW_met_em.d${CR_DOMAIN}.${P_FORW_FILE_DATE}.nc
         export FORW_FILE_FR=FW_met_em.d${FR_DOMAIN}.${P_FORW_FILE_DATE}.nc
         export OUTFILE_CR=met_em.d${CR_DOMAIN}.${P_FILE_DATE}.nc
         export OUTFILE_FR=met_em.d${FR_DOMAIN}.${P_FILE_DATE}.nc
         export TIME_INTERP_DIR1=${DART_DIR}/
         export TIME_INTERP_DIR2=apm_run_scripts/RUN_TIME_INTERP/work
         export FIX_TIME_FILE=${TIME_INTERP_DIR1}/${TIME_INTERP_DIR2}/fix_time_stamp.exe
         export NUM_FIX_DATES=1
         cp ${FIX_TIME_FILE} ./.
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${P_FILE_DATE}'
file_str='${OUTFILE_CR}'
num_dates=${NUM_FIX_DATES}
file_sw=0
/
EOF
         ncflint -w ${BACK_WT} ${BACK_FILE_CR} ${FORW_FILE_CR} ${OUTFILE_CR}
         ./fix_time_stamp.exe
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${P_FILE_DATE}'
file_str='${OUTFILE_FR}'
num_dates=${NUM_FIX_DATES}
file_sw=0
/
EOF
         ncflint -w ${BACK_WT} ${BACK_FILE_FR} ${FORW_FILE_FR} ${OUTFILE_FR}
         ./fix_time_stamp.exe
         export P_BACK_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_BACK_DATE} ${LBC_FREQ} 2>/dev/null) 
         export P_FORW_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_FORW_DATE} ${LBC_FREQ} 2>/dev/null) 
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
#
# GET REAL DATA
      cd ${RUN_DIR}/${DATE}/real
      rm -rf wrfbdy_d*
      rm -rf wrfinput_d*
#
# LINK IN THE BACK AND FORW WRFBDY AND WRFINPUT FILES
      export P_DATE=${BACK_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00
         ln -sf ${RUN_DIR}/${BACK_DATE}/real/wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE} ./BK_wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${BACK_DATE}/real/wrfinput_d${CR_DOMAIN}_${P_FILE_DATE} ./BK_wrfinput_d${CR_DOMAIN}_${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${BACK_DATE}/real/wrfinput_d${FR_DOMAIN}_${P_FILE_DATE} ./BK_wrfinput_d${FR_DOMAIN}_${P_FILE_DATE}
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
      export P_DATE=${FORW_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00
         ln -sf ${RUN_DIR}/${FORW_DATE}/real/wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE} ./FW_wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${FORW_DATE}/real/wrfinput_d${CR_DOMAIN}_${P_FILE_DATE} ./FW_wrfinput_d${CR_DOMAIN}_${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${FORW_DATE}/real/wrfinput_d${FR_DOMAIN}_${P_FILE_DATE} ./FW_wrfinput_d${FR_DOMAIN}_${P_FILE_DATE}
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
#
# DO INTERPOLATION
      export P_DATE=${DATE}
      export P_BACK_DATE=${BACK_DATE}
      export P_FORW_DATE=${FORW_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00
         export P_BK_YYYY=$(echo $P_BACK_DATE | cut -c1-4)
         export P_BK_MM=$(echo $P_BACK_DATE | cut -c5-6)
         export P_BK_DD=$(echo $P_BACK_DATE | cut -c7-8)
         export P_BK_HH=$(echo $P_BACK_DATE | cut -c9-10)
         export P_BACK_FILE_DATE=${P_BK_YYYY}-${P_BK_MM}-${P_BK_DD}_${P_BK_HH}:00:00
         export P_FW_YYYY=$(echo $P_FORW_DATE | cut -c1-4)
         export P_FW_MM=$(echo $P_FORW_DATE | cut -c5-6)
         export P_FW_DD=$(echo $P_FORW_DATE | cut -c7-8)
         export P_FW_HH=$(echo $P_FORW_DATE | cut -c9-10)
         export P_FORW_FILE_DATE=${P_FW_YYYY}-${P_FW_MM}-${P_FW_DD}_${P_FW_HH}:00:00
         export BACK_BDYF_CR=BK_wrfbdy_d${CR_DOMAIN}_${P_BACK_FILE_DATE}
         export BACK_FILE_CR=BK_wrfinput_d${CR_DOMAIN}_${P_BACK_FILE_DATE}
         export BACK_FILE_FR=BK_wrfinput_d${FR_DOMAIN}_${P_BACK_FILE_DATE}
         export FORW_BDYF_CR=FW_wrfbdy_d${CR_DOMAIN}_${P_FORW_FILE_DATE}
         export FORW_FILE_CR=FW_wrfinput_d${CR_DOMAIN}_${P_FORW_FILE_DATE}
         export FORW_FILE_FR=FW_wrfinput_d${FR_DOMAIN}_${P_FORW_FILE_DATE}
         export BDYFILE_CR=wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE}
         export OUTFILE_CR=wrfinput_d${CR_DOMAIN}_${P_FILE_DATE}
         export OUTFILE_FR=wrfinput_d${FR_DOMAIN}_${P_FILE_DATE}
         export TIME_INTERP_DIR1=${DART_DIR}/
         export TIME_INTERP_DIR2=apm_run_scripts/RUN_TIME_INTERP/work
         export FIX_TIME_FILE=${TIME_INTERP_DIR1}/${TIME_INTERP_DIR2}/fix_time_stamp.exe
         let NUM_FIX_DATES=${FCST_PERIOD}/${LBC_FREQ}
         ((FX_IDX=0)) 
         export STR_FXDT=${P_DATE}
         export END_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${STR_FXDT} ${FCST_PERIOD} 2>/dev/null)
         while [[ ${STR_FXDT} -le ${END_FXDT} ]] ; do
            export FX_YYYY=$(echo $STR_FXDT | cut -c1-4)
            export FX_MM=$(echo $STR_FXDT | cut -c5-6)
            export FX_DD=$(echo $STR_FXDT | cut -c7-8)
            export FX_HH=$(echo $STR_FXDT | cut -c9-10)
            export FX_FILE_DATE[${FX_IDX}]=${FX_YYYY}-${FX_MM}-${FX_DD}_${FX_HH}:00:00
            let FX_IDX=${FX_IDX}+1
            export STR_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${STR_FXDT} ${LBC_FREQ} 2>/dev/null)
         done
         ((FX_IDX=0)) 
         export STR_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null)
         export END_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${STR_FXDT} ${FCST_PERIOD} 2>/dev/null)
         while [[ ${STR_FXDT} -le ${END_FXDT} ]] ; do
            export FX_YYYY=$(echo $STR_FXDT | cut -c1-4)
            export FX_MM=$(echo $STR_FXDT | cut -c5-6)
            export FX_DD=$(echo $STR_FXDT | cut -c7-8)
            export FX_HH=$(echo $STR_FXDT | cut -c9-10)
            export FX_FILE_NEXT_DATE[${FX_IDX}]=${FX_YYYY}-${FX_MM}-${FX_DD}_${FX_HH}:00:00
            let FX_IDX=${FX_IDX}+1
            export STR_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${STR_FXDT} ${LBC_FREQ} 2>/dev/null)
         done
         cp ${FIX_TIME_FILE} ./.
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${FX_FILE_DATE[0]}'
time_str2='${FX_FILE_DATE[1]}'
time_this_str1='${FX_FILE_DATE[0]}'
time_this_str2='${FX_FILE_DATE[1]}'
time_next_str1='${FX_FILE_NEXT_DATE[0]}'
time_next_str2='${FX_FILE_NEXT_DATE[1]}'
file_str='${BDYFILE_CR}'
num_dates=${NUM_FIX_DATES}
file_sw=1
/
EOF
         ncflint -w ${BACK_WT} ${BACK_BDYF_CR} ${FORW_BDYF_CR} ${BDYFILE_CR}
         ./fix_time_stamp.exe
         export TIME_INTERP_DIR1=${DART_DIR}/
         export TIME_INTERP_DIR2=apm_run_scripts/RUN_TIME_INTERP/work
         export FIX_TIME_FILE=${TIME_INTERP_DIR1}/${TIME_INTERP_DIR2}/fix_time_stamp.exe
         cp ${FIX_TIME_FILE} ./.
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${FX_FILE_DATE[0]}'
time_str2='${FX_FILE_DATE[1]}'
time_this_str1='${FX_FILE_DATE[0]}'
time_this_str2='${FX_FILE_DATE[1]}'
time_next_str1='${FX_FILE_NEXT_DATE[0]}'
time_next_str2='${FX_FILE_NEXT_DATE[1]}'
file_str='${OUTFILE_CR}'
num_dates=${NUM_FIX_DATES}
file_sw=0
/
EOF
         ncflint -w ${BACK_WT} ${BACK_FILE_CR} ${FORW_FILE_CR} ${OUTFILE_CR}
         ./fix_time_stamp.exe
         export TIME_INTERP_DIR1=${DART_DIR}/
         export TIME_INTERP_DIR2=apm_run_scripts/RUN_TIME_INTERP/work
         export FIX_TIME_FILE=${TIME_INTERP_DIR1}/${TIME_INTERP_DIR2}/fix_time_stamp.exe
         cp ${FIX_TIME_FILE} ./.
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${FX_FILE_DATE[0]}'
time_str2='${FX_FILE_DATE[1]}'
time_this_str1='${FX_FILE_DATE[0]}'
time_this_str2='${FX_FILE_DATE[1]}'
time_next_str1='${FX_FILE_NEXT_DATE[0]}'
time_next_str2='${FX_FILE_NEXT_DATE[1]}'
file_str='${OUTFILE_FR}'
num_dates=${NUM_FIX_DATES}
file_sw=0
/
EOF
         ncflint -w ${BACK_WT} ${BACK_FILE_FR} ${FORW_FILE_FR} ${OUTFILE_FR}
         ./fix_time_stamp.exe
         export P_BACK_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_BACK_DATE} ${LBC_FREQ} 2>/dev/null) 
         export P_FORW_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_FORW_DATE} ${LBC_FREQ} 2>/dev/null) 
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
   exit
   fi
