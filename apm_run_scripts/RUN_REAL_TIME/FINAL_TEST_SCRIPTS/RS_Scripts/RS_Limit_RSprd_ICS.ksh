#!/bin/ksh -aux
   cd ${RUN_DIR}/${DATE}/wrfchem_chem_icbc
#
   cp ${LIMIT_RSPRD_DIR}/work/limit_rsprd_ics.exe ./limit_rsprd_ics.exe
   export L_DATE=${DATE}0000
   export L_YY=$(echo $L_DATE | cut -c1-4)
   export L_MM=$(echo $L_DATE | cut -c5-6)
   export L_DD=$(echo $L_DATE | cut -c7-8)
   export L_HH=$(echo $L_DATE | cut -c9-10)
   export L_MN=$(echo $L_DATE | cut -c11-12)
   export L_SS=$(echo $L_DATE | cut -c13-14)
#
   export WRFINPUT_OLD=wrfinput_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
   export WRFINPUT_NEW=wrfinput_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}_new
#
   rm -rf limit_rsprd_ics_nml.nl
   cat << EOF > limit_rsprd_ics_nml.nl
&limit_rsprd_ics_nml
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nchem_spcs=${NSPCS},
nnum_mems=${NUM_MEMBERS},
path_old='${RUN_DIR}/${DATE}/wrfchem_chem_icbc',
path_new='${RUN_DIR}/${DATE}/wrfchem_chem_icbc',
wrfinput_old='${WRFINPUT_OLD}',
wrfinput_new='${WRFINPUT_NEW}',
rsprd_crit=${NL_RSPRD_CRIT},
/
EOF
   rm -rf chem_ics_spcs_nml.nl
   cat << EOF > chem_ics_spcs_nml.nl
#
# These need to match the species in the respective input files
&chem_ics_spcs_nml
ch_chem_spcs=${NL_CHEM_ICBC_SPECIES}
/
EOF
#
   let MEM=1   
   while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
      export CMEM=e${MEM}
      if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
      if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
      cp ${WRFINPUT_OLD}.${CMEM} ${WRFINPUT_NEW}.${CMEM}
      let MEM=MEM+1
   done
#
   RANDOM=$$
   export JOBRND=${RANDOM}_limit_ics
#
# PARALLEL ON ${MODEL}
   ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${LIMIT_JOB_CLASS} ${LIMIT_TIME_LIMIT} ${LIMIT_NODES} ${LIMIT_TASKS} limit_rsprd_ics.exe PARALLEL ${ACCOUNT} ${LIMIT_MODEL}
#
   qsub -Wblock=true job.ksh
   rm index_limit_ics.html
   mv index.html index_limit_ics.html
#
   let MEM=1   
   while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
      export CMEM=e${MEM}
      if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
      if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
      cp ${WRFINPUT_NEW}.${CMEM} ${WRFINPUT_OLD}.${CMEM}
      rm ${WRFINPUT_NEW}.${CMEM}
      let MEM=MEM+1
   done
#
# Clean directory
#   rm *_cr_icbc_pert* job,ksh met_em.d* mozbc* perturb_chem_*
#   rm runICBC_parent_* run_mozbc_rt_* set00* wrfbdy_d01 wrfinput_d01
#   rm wrfbdy_d01_${DATE} wrfinput_do1_${DATE} wrfinput_d01_frac
#   rm wrfinput_d01_mean wrfinput_d01_sprd pert_chem_icbc job.ksh
#   rm wrfbdy_d01_*_:00 wrfinput_d01_*_:00
