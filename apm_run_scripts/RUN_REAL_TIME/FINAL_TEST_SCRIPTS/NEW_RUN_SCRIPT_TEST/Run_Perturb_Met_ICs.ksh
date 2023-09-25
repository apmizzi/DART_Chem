#!/bin/ksh -aux
#
#########################################################################
#
# RUN PERT_WRFCHEM_MET_IC
#
#########################################################################
#
   if [[ ${RUN_PERT_WRFCHEM_MET_IC} = "true" ]]; then 
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_met_ic ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_met_ic
         cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
      fi
#
      export NL_MAX_DOM=1
      export NL_OB_FORMAT=1
      export L_FCST_RANGE=${FCST_PERIOD}
      export L_START_DATE=${DATE}
      export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} ${L_FCST_RANGE} 2>/dev/null)
      export L_START_YEAR=$(echo $L_START_DATE | cut -c1-4)
      export L_START_MONTH=$(echo $L_START_DATE | cut -c5-6)
      export L_START_DAY=$(echo $L_START_DATE | cut -c7-8)
      export L_START_HOUR=$(echo $L_START_DATE | cut -c9-10)
      export L_END_YEAR=$(echo $L_END_DATE | cut -c1-4)
      export L_END_MONTH=$(echo $L_END_DATE | cut -c5-6)
      export L_END_DAY=$(echo $L_END_DATE | cut -c7-8)
      export L_END_HOUR=$(echo $L_END_DATE | cut -c9-10)
      export NL_START_YEAR=$(echo $L_START_DATE | cut -c1-4),$(echo $L_START_DATE | cut -c1-4)
      export NL_START_MONTH=$(echo $L_START_DATE | cut -c5-6),$(echo $L_START_DATE | cut -c5-6)
      export NL_START_DAY=$(echo $L_START_DATE | cut -c7-8),$(echo $L_START_DATE | cut -c7-8)
      export NL_START_HOUR=$(echo $L_START_DATE | cut -c9-10),$(echo $L_START_DATE | cut -c9-10)
      export NL_END_YEAR=$(echo $L_END_DATE | cut -c1-4),$(echo $L_END_DATE | cut -c1-4)
      export NL_END_MONTH=$(echo $L_END_DATE | cut -c5-6),$(echo $L_END_DATE | cut -c5-6)
      export NL_END_DAY=$(echo $L_END_DATE | cut -c7-8),$(echo $L_END_DATE | cut -c7-8)
      export NL_END_HOUR=$(echo $L_END_DATE | cut -c9-10),$(echo $L_END_DATE | cut -c9-10)
      export NL_START_DATE=\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\',\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\'
      export NL_END_DATE=\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\',\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\'
#
# LOOP THROUGH ALL BDY TENDENCY TIMES
      export P_DATE=${DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
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
         TRANDOM=$$
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#
# COARSE RESOLUTION GRID
            cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
            export LCR_DIR=wrfda_cr_${MEM}
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
            ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfda_namelist_v4.ksh
            cp ${EXPERIMENT_PREPBUFR_DIR}/${DATE}/prepbufr.gdas.${DATE}.wo40.be ob.bufr
            cp ${DA_INPUT_FILE} fg
            cp ${BE_DIR}/be.dat.cv3 be.dat
            cp ${WRFDA_DIR}/run/LANDUSE.TBL ./.
            cp ${WRFDA_DIR}/var/da/da_wrfvar.exe ./.
#
#            RANDOM=$$
            export JOBRND=${TRANDOM}_wrfda_cr
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${WRFDA_JOB_CLASS} ${WRFDA_TIME_LIMIT} ${WRFDA_NODES} ${WRFDA_TASKS} da_wrfvar.exe SERIAL ${ACCOUNT}
#            qsub job.ksh
            chmod +x da_wrfvar.exe
            ./da_wrfvar.exe > index.html 2>&1
#
# FINE RESOLUTION GRID
#            cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
#            export LFR_DIR=wrfda_fr_${MEM}
#            if [[ ! -e ${LFR_DIR} ]]; then
#               mkdir ${LFR_DIR}
#               cd ${LFR_DIR}
#            else
#               cd ${LFR_DIR}
#               rm -rf *
#            fi
#            export NL_E_WE=${NNXP_STAG_FR}
#            export NL_E_SN=${NNYP_STAG_FR}
#            export NL_DX=${DX_FR}
#            export NL_DY=${DX_FR}
#            export NL_GRID_ID=2
#            export NL_PARENT_ID=1
#            export NL_PARENT_GRID_RATIO=5
#            export NL_I_PARENT_START=${ISTR_FR}
#            export NL_J_PARENT_START=${JSTR_FR}
#            export DA_INPUT_FILE=../../real/wrfinput_d${FR_DOMAIN}_${ANALYSIS_DATE}
#            ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfda_namelist_v4.ksh
#            cp ${EXPERIMENT_PREPBUFR_DIR}/${DATE}/prepbufr.gdas.${DATE}.wo40.be ob.bufr
#            cp ${DA_INPUT_FILE} fg
#            cp ${BE_DIR}/be.dat.cv3 be.dat
#            cp ${WRFDA_DIR}/run/LANDUSE.TBL ./.
#            cp ${WRFDA_DIR}/var/da/da_wrfvar.exe ./.
#   
#            RANDOM=$$
#            export JOBRND=${TRANDOM}_wrfda_fr
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${WRFDA_JOB_CLASS} ${WRFDA_TIME_LIMIT} ${WRFDA_NODES} ${WRFDA_TASKS} da_wrfvar.exe SERIAL ${ACCOUNT}
#            qsub job.ksh
            let MEM=${MEM}+1
         done
#
# Wait for WRFDA to complete for all members
         cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
#
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
            export LCR_DIR=wrfda_cr_${MEM}
            export LFR_DIR=wrfda_fr_${MEM}
            if [[ -e ${LCR_DIR}/wrfvar_output ]]; then
               cp ${LCR_DIR}/wrfvar_output wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
            else
               sleep 45
               cp ${LCR_DIR}/wrfvar_output wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
            fi 
#            if [[ -e ${LFR_DIR}/wrfvar_output ]]; then
#               cp ${LFR_DIR}/wrfvar_output wrfinput_d${FR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
#            else
#               sleep 45
#               cp ${LFR_DIR}/wrfvar_output wrfinput_d${FR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
#            fi
            let MEM=${MEM}+1
         done
#
# Chia-Hua Recentering Fix
# Ensemble mean
         ncea -O -n ${NUM_MEMBERS},3,1 wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001' ens_mean
#
# Mean difference
         ncdiff -O ens_mean ${RUN_DIR}/${DATE}/real/wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}  mean_diff
#
# Recenter each member
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
            ncdiff -O wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM} mean_diff mem.${CMEM}
            mv mem.${CMEM} wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
            let MEM=${MEM}+1
         done
         ncea -O -n ${NUM_MEMBERS},3,1 wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001'  wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}_new_mean
         rm ens_mean
         rm mean_diff
# End Recentering Fix
#	 
	 export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
      export NL_E_WE=${NNXP_STAG_CR},${NNXP_STAG_FR}
      export NL_E_SN=${NNYP_STAG_CR},${NNYP_STAG_FR}
      export NL_DX=${DX_CR},${DX_FR}
      export NL_DY=${DX_CR},${DX_FR}
      export NL_GRID_ID=1,2
      export NL_PARENT_ID=0,1
      export NL_PARENT_GRID_RATIO=1,5
      export NL_I_PARENT_START=${ISTR_CR},${ISTR_FR}
      export NL_J_PARENT_START=${JSTR_CR},${JSTR_FR}
   fi
#
