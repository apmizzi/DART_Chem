#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/update_bc
      export L_WORK_DIR=${RUN_DIR}/${DATE}/update_bc
#
      JOB_LIST=""
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
#
# Get background forecasts
         mkdir run_${CMEM}
	 JOB_LIST="${JOB_LIST} run_${CMEM}"
         export DA_PRIOR_FILE=${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${FILE_DATE}_da_prior.${CMEM}
         export DA_POSTERIOR_FILE=${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM} 
         export BDYCDN_PRIOR=${WRFCHEM_CHEM_ICBC_DIR}/wrfbdy_d${CR_DOMAIN}_${FILE_DATE}.${CMEM}
	 if [[ ! -e run_${CMEM}/wrfbdy_d${CR_DOMAIN}_${FILE_DATE}_prior.${CMEM} ]]; then
            cp ${BDYCDN_PRIOR} run_${CMEM}/wrfbdy_d${CR_DOMAIN}_${FILE_DATE}_prior.${CMEM}
	 fi 
         export BDYCDN_POSTERIOR=wrfbdy_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM}    
#
         export CYCLING=true
         export NL_LOW_BDY_ONLY=false
         export NL_UPDATE_LSM=false
         ln -sf ${DA_PRIOR_FILE} run_${CMEM}/real_output
         ln -sf ${DA_POSTERIOR_FILE} run_${CMEM}/wrfvar_output
         cp -f ${BDYCDN_PRIOR} run_${CMEM}/wrfbdy_d01
         cp ${BUILD_DIR}/da_update_bc.exe run_${CMEM}/.
#
         cat <<EOF > run_${CMEM}/parame.in
&control_param
wrfvar_output_file = 'wrfvar_output',
wrf_bdy_file       = 'wrfbdy_d01',
wrf_input          = 'real_output'
cycling            = .${CYCLING}.,
debug              = .true.,
low_bdy_only       = .${NL_LOW_BDY_ONLY}.,
update_lsm         = .${NL_UPDATE_LSM}.,
/
EOF
#
#         RANDOM=$$
#         export JOBRND=${RANDOM}_updatebc
#         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} da_update_bc.exe SERIAL ${ACCOUNT} ${GENERAL_MODEL}
#         qsub -Wblock=true job.ksh
#         cp wrfbdy_d01 ${BDYCDN_POSTERIOR}
         let MEM=${MEM}+1
      done
#
# GNU Parallel
      RANDOM=$$
      export JOBRND=${RANDOM}_updatebc
      export EXE_LINE="parallel -j 30 'cd {1}; ./da_update_bc.exe >& index.log'"
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_GNU_PARALLEL.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} 1 30 "${EXE_LINE}" PARALLEL ${ACCOUNT} ${GENERAL_MODEL}
      qsub -Wblock=true job.bsh > index_update_bc 2>&1
#      
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
         export BDYCDN_POSTERIOR=wrfbdy_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM}    
         cp run_${CMEM}/wrfbdy_d01 ${BDYCDN_POSTERIOR}
         mv run_${CMEM}/*prior* ./.
         let MEM=${MEM}+1
      done
      rm -rf run_*
      rm -rf job.*
      rm -rf index*
      rm -rf *updatebc.o*
      rm -rf parame.in
      rm -rf real_output
      rm -rf wrfbdy_d01
      rm -rf wrfbdy_d01_input
      rm -rf wrfvar_output
#
