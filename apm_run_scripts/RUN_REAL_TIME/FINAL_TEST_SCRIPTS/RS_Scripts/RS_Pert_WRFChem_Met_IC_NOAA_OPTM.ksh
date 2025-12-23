.#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
#
      DIR_LABEL_LIST=""
      export NL_MAX_DOM=1
      export NL_OB_FORMAT=1
      export L_START_DATE=${DATE}
      export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} ${FCST_PERIOD} -f ccyymmddhhnn 2>/dev/null)
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
      export L_END_SECOND=$(echo $L_END_DATE | cut -c13-14)
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
#
# LOOP THROUGH ALL BDY TENDENCY TIMES
      export P_DATE=${DATE}00
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} -f ccyymmddhhnn 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export L_YYYY=$(echo $P_DATE | cut -c1-4)
         export L_MM=$(echo $P_DATE | cut -c5-6)
         export L_DD=$(echo $P_DATE | cut -c7-8)
         export L_HH=$(echo $P_DATE | cut -c9-10)
         if [[ ${L_HH} -ge 00 && ${L_HH} -lt 06 ]]; then export L_HH=00; fi
         if [[ ${L_HH} -ge 06 && ${L_HH} -lt 12 ]]; then export L_HH=06; fi
         if [[ ${L_HH} -ge 12 && ${L_HH} -lt 18 ]]; then export L_HH=12; fi
         if [[ ${L_HH} -ge 18 && ${L_HH} -lt 24 ]]; then export L_HH=18; fi
#
# SET WRFDA PARAMETERS
         export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
         export NL_ANALYSIS_DATE=\'${ANALYSIS_DATE}\'
         export NL_TIME_WINDOW_MIN=\'$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} -${ASIM_WINDOW} -W 2>/dev/null)\'
         export NL_TIME_WINDOW_MAX=\'$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} +${ASIM_WINDOW} -W 2>/dev/null)\'
         export NL_ANALYSIS_TYPE=\'RANDOMCV\'
         export NL_PUT_RAND_SEED=true
#
# LOOP THROUGH ALL MEMBERS IN THE ENSEMBLE
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#
# COARSE RESOLUTION GRID
            cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
	    DIR_LABEL_LIST="$DIR_LABEL_LIST ${MEM}_${P_DATE}"
            export LCR_DIR=wrfda_cr_${MEM}_${P_DATE}
            if [[ ! -e ${LCR_DIR} ]]; then
               mkdir ${LCR_DIR}
               cd ${LCR_DIR}
            else
               cd ${LCR_DIR}
               rm -rf *
            fi
            export NL_E_WE=${NNXP_STAG_CR}
            export NL_E_SN=${NNYP_STAG_CR}
            export NL_DX=${DX_CR}
            export NL_DY=${DX_CR}
            export NL_GRID_ID=1
            export NL_PARENT_ID=0
            export NL_PARENT_GRID_RATIO=1
            export NL_I_PARENT_START=${ISTR_CR}
            export NL_J_PARENT_START=${JSTR_CR}
            export DA_INPUT_FILE=../../real/wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}
            export NL_SEED_ARRAY1=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -f hhddmmyycc)
            export NL_SEED_ARRAY2=`echo ${MEM} \* 100000 | bc -l `
            ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfda_namelist_NOAA.ksh
            cp ${EXPERIMENT_PREPBUFR_DIR}/${L_YYYY}/${L_MM}/${L_DD}/prepbufr.gdas.${L_YYYY}${L_MM}${L_DD}${L_HH}*nr ./ob.bufr
            cp ${DA_INPUT_FILE} fg
            cp ${BE_DIR}/be.dat.cv3 be.dat
            cp ${WRFDA_DIR}/run/LANDUSE.TBL ./.
            cp ${WRFDA_DIR}/var/da/da_wrfvar.exe ./.
#
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_has.ksh ${JOBRND} ${WRFDA_JOB_CLASS} ${WRFDA_TIME_LIMIT} ${WRFDA_NODES} ${WRFDA_TASKS} da_wrfvar.exe SERIAL ${ACCOUNT}
            let MEM=${MEM}+1
         done
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ_TEXT} -f ccyymmddhhnn 2>/dev/null)
      done
#
# Run using GNU Parallel
      cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
      TRANDOM=$$
      export JOBRND=${TRANDOM}_wrfda_cr
      rm -rf jobx.ksh
      cat > jobx.ksh << EOF
#!/bin/bash
#PBS -W group_list=${ACCOUNT}
#PBS -N ${JOBRND}
#PBS -q normal
#PBS -l walltime=00:60:00
#PBS -j oe
#PBS -l select=1:ncpus=128:model=rom_ait
cd \$PBS_O_WORKDIR
. /home7/gkedzior/run_tracer_env
export MPI_DSM_DISTRIBUTE=0
parallel 'cd wrfda_cr_{1}; ./da_wrfvar.exe >& index.log' ::: ${DIR_LABEL_LIST}
EOF
      qsub -Wblock=true jobx.ksh
#
# LOOP THROUGH ALL BDY TENDENCY TIMES
      export P_DATE=${DATE}00
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} -f ccyymmddhhnn 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
         export L_YYYY=$(echo $P_DATE | cut -c1-4)
         export L_MM=$(echo $P_DATE | cut -c5-6)
         export L_DD=$(echo $P_DATE | cut -c7-8)
         export L_HH=$(echo $P_DATE | cut -c9-10)
         if [[ ${L_HH} -ge 00 && ${L_HH} -lt 06 ]]; then export L_HH=00; fi
         if [[ ${L_HH} -ge 06 && ${L_HH} -lt 12 ]]; then export L_HH=06; fi
         if [[ ${L_HH} -ge 12 && ${L_HH} -lt 18 ]]; then export L_HH=12; fi
         if [[ ${L_HH} -ge 18 && ${L_HH} -lt 24 ]]; then export L_HH=18; fi
#
	 let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
            export LCR_DIR=wrfda_cr_${MEM}_${P_DATE}
            cp ${LCR_DIR}/wrfvar_output wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
            let MEM=${MEM}+1
         done
#
# Chia-Hua Recentering Fix
         rm jobx.ksh
         touch jobx.ksh
         chmod +x jobx.ksh
         cat << EOF > jobx.ksh
#!/bin/ksh -aux
cp ${RUN_DIR}/${DATE}/real/wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE} wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}_parent
ncea -O -n ${NUM_MEMBERS},3,1 wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001' ens_mean
ncdiff -O ens_mean ${RUN_DIR}/${DATE}/real/wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}  mean_diff
let MEM=1
while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
   export CMEM=e\${MEM}
   if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
   if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
   ncdiff -O wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.$\{CMEM} mean_diff mem.\${CMEM}
   mv mem.\${CMEM} wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.\${CMEM}
   let MEM=\${MEM}+1
done
ncea -O -n ${NUM_MEMBERS},3,1 wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001' wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}_new_mean
rm -rf ens_mean
rm -rf mean_diff
EOF
         TRANDOM=$$
         export JOBRND=${TRANDOM}_nco
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
         qsub -Wblock=true job.ksh
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ_TEXT} -f ccyymmddhhnn 2>/dev/null)
      done
#
# Reset dual resolution cycling parameters      
      export NL_E_WE=${NNXP_STAG_CR},${NNXP_STAG_FR}
      export NL_E_SN=${NNYP_STAG_CR},${NNYP_STAG_FR}
      export NL_DX=${DX_CR},${DX_FR}
      export NL_DY=${DX_CR},${DX_FR}
      export NL_GRID_ID=1,2
      export NL_PARENT_ID=0,1
      export NL_PARENT_GRID_RATIO=1,5
      export NL_I_PARENT_START=${ISTR_CR},${ISTR_FR}
      export NL_J_PARENT_START=${JSTR_CR},${JSTR_FR}
#
# Clean directory
#      let MEM=1
#      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
#         export CMEM=e${MEM}
#         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
#         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#         mv wrfda_cr_${MEM}/rsl.error.0000 rsl.error.${CMEM}
#         mv wrfda_cr_${MEM}/rsl.out.0000 rsl.out.${CMEM}
#         let MEM=${MEM}+1
#      done
#      rm -rf wrfda_cr_*
#      rm wrfinput_*_new_mean
