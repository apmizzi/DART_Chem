#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/wrfchem_met_bc
#
# LOOP THROUGH ALL MEMBERS IN THE ENSEMBLE
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
         export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -W 2>/dev/null)
         rm -rf wrfbdy_this
         export DA_BDY_PATH=${RUN_DIR}/${DATE}/real
         export DA_BDY_FILE=${DA_BDY_PATH}/wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}
         cp ${DA_BDY_FILE} wrfbdy_this
         rm -rf pert_wrf_bc
         cp ${WRFCHEM_DART_WORK_DIR}/pert_wrf_bc ./.
         rm -rf input.nml
         ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
#
# LOOP THROUGH ALL BDY TENDENCY TIMES FOR THIS MEMBER.
         export L_DATE=${DATE}
         export L_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} -f ccyymmddhhnn 2>/dev/null)
         TRANDOM=$$
         while [[ ${L_DATE} -lt ${L_END_DATE} ]]; do
            rm -rf wrfinput_this_*
            rm -rf wrfinput_next_*
            export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 0 -W 2>/dev/null)
            export NEXT_L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${LBC_FREQ_TEXT} 2>/dev/null)
            export NEXT_ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${LBC_FREQ_TEXT} -W 2>/dev/null)
            export DA_INPUT_PATH=${RUN_DIR}/${DATE}/wrfchem_met_ic
            ln -fs ${DA_INPUT_PATH}/wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM} wrfinput_this_${L_DATE} 
            ln -fs ${DA_INPUT_PATH}/wrfinput_d${CR_DOMAIN}_${NEXT_ANALYSIS_DATE}.${CMEM} wrfinput_next_${L_DATE} 
#
# Create pert_wrf_bc namelist
            rm -rf pert_wrf_bc_nml.nl
            cat << EOF > pert_wrf_bc_nml.nl
&pert_wrf_bc_nml
wrfbdy_this_file='wrfbdy_this'
wrfinput_this_file='wrfinput_this_${L_DATE}'
wrfinput_next_file='wrfinput_next_${L_DATE}'
/
EOF
#            export JOBRND=${TRANDOM}_pert_bc
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} pert_wrf_bc SERIAL ${ACCOUNT}
#            qsub -Wblock=true job.ksh
            chmod +x pert_wrf_bc
            ./pert_wrf_bc > index.html 2>&1
            export L_DATE=${NEXT_L_DATE}
         done
#         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
         export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -W 2>/dev/null)
         mv wrfbdy_this wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
         let MEM=${MEM}+1
      done
#
# Chia-Hua Recentering Fix
# Ensemble mean
      ncea -O -n ${NUM_MEMBERS},3,1 wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001' ens_mean
#
# Mean difference
      ncdiff -O ens_mean ${RUN_DIR}/${DATE}/real/wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}  mean_diff
#
# Recenter each member
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
         ncdiff -O wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM} mean_diff mem.${CMEM}
         mv mem.${CMEM} wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
         let MEM=${MEM}+1
      done
      ncea -O -n ${NUM_MEMBERS},3,1 wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001'  wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}_new_mean
      rm ens_mean
      rm mean_diff
# End Recentering Fix
#	 
# Clean directory
#      rm dart_log.* input.nml pert_wrf_bc*
#      rm wrfinput_next_*
#      rm wrfinput_this_*
#      rm wrfbdy_d01_*_new_mean
