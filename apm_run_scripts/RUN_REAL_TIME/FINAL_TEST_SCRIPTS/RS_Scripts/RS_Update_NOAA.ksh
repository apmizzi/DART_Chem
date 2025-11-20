#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/update_bc
#
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
#
         export CYCLING=true
         export OPS_FORC_FILE=${WRFCHEM_CHEM_ICBC_DIR}/wrfinput_d${CR_DOMAIN}_${FILE_DATE}.${CMEM}
         export BDYCDN_IN=${WRFCHEM_CHEM_ICBC_DIR}/wrfbdy_d${CR_DOMAIN}_${FILE_DATE}.${CMEM}
         cp ${BDYCDN_IN} wrfbdy_d${CR_DOMAIN}_${FILE_DATE}_prior.${CMEM}
         export DA_OUTPUT_FILE=${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM} 
         export BDYCDN_OUT=wrfbdy_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM}    
#
         export NL_LOW_BDY_ONLY=false
         export NL_UPDATE_LSM=false
         cp -f $OPS_FORC_FILE real_output
         cp -f $DA_OUTPUT_FILE wrfvar_output
         cp -f $BDYCDN_IN wrfbdy_d01_input
         cp -f $BDYCDN_IN wrfbdy_d01
#
         cat <<EOF > parame.in
&control_param
wrfvar_output_file = 'wrfvar_output',
wrf_bdy_file       = 'wrfbdy_d01',
wrf_input          = 'real_output'
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
         cp $BUILD_DIR/da_update_bc.exe .
         RANDOM=$$
         export JOBRND=${RANDOM}_updatebc
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} da_update_bc.exe SERIAL ${ACCOUNT} ${GENERAL_MODEL}
         qsub -Wblock=true job.ksh
         cp wrfbdy_d01 wrfbdy_d01_output
         cp wrfbdy_d01 $BDYCDN_OUT
#
         let MEM=$MEM+1
      done
