#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/ensemble_mean_output
#
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then
         export OUTPUT_DIR=${WRFCHEM_INITIAL_DIR}
      else
         export OUTPUT_DIR=${WRFCHEM_CYCLE_CR_DIR}
      fi
      rm -rf wrfout_d${CR_DOMAIN}_*
#
# Calculate ensemble mean
      export PP_DATE=${DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${PP_DATE} ${FCST_PERIOD} -f ccyymmddhh 2>/dev/null)
      rm jobx.ksh
      touch jobx.ksh
      chmod +x jobx.ksh
      cat << EOF > jobx.ksh
#!/bin/ksh -aux
export P_DATE=${PP_DATE}
while [[ \${P_DATE} -le ${P_END_DATE} ]] ; do
   export P_YYYY=\$(echo \$P_DATE | cut -c1-4)
   export P_MM=\$(echo \$P_DATE | cut -c5-6)
   export P_DD=\$(echo \$P_DATE | cut -c7-8)
   export P_HH=\$(echo \$P_DATE | cut -c9-10)
   export P_FILE_DATE=\${P_YYYY}-\${P_MM}-\${P_DD}_\${P_HH}:00:00
   let MEM=1
   while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
      export CMEM=e\${MEM}
      export KMEM=\${MEM}
      if [[ \${MEM} -lt 1000 ]]; then export KMEM=0\${MEM}; fi
      if [[ \${MEM} -lt 100 ]]; then export KMEM=00\${MEM}; export CMEM=e0\${MEM}; fi
      if [[ \${MEM} -lt 10 ]]; then export KMEM=000\${MEM}; export CMEM=e00\${MEM}; fi
      rm -rf wrfout_d${CR_DOMAIN}_\${KMEM}
#     rm -rf wrfchemi_d${CR_DOMAIN}_\${KMEM}
      cp ${OUTPUT_DIR}/run_\${CMEM}/wrfout_d${CR_DOMAIN}_\${P_FILE_DATE} wrfout_d${CR_DOMAIN}_\${KMEM}
#     cp ${WRFCHEM_MET_IC_DIR}/wrfinput_d${CR_DOMAIN}_${START_FILE_DATE}.\${CMEM} wrfinput_d${CR_DOMAIN}_\${KMEM}
#     ln -sf ${OUTPUT_DIR}/run_\${CMEM}/wrfchemi_d${CR_DOMAIN}_\${P_FILE_DATE} wrfchemi_d${CR_DOMAIN}_\${KMEM}
      let MEM=\${MEM}+1
   done
   ncea -n ${NUM_MEMBERS},4,1 wrfout_d${CR_DOMAIN}_0001 wrfout_d${CR_DOMAIN}_\${P_DATE}_mean
   export P_DATE=\$(${BUILD_DIR}/da_advance_time.exe \${P_DATE} ${HISTORY_INTERVAL_HR} -f ccyymmddhh 2>/dev/null)
done
EOF
#
      TRANDOM=$$
      export JOBRND=${TRANDOM}_nco
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
      qsub -Wblock=true job.ksh
