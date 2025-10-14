#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/dart_filter
#
# Construct background file name/date
      export LL_DATE=${DATE}
      export LL_END_DATE=${DATE}
      export LL_YY=`echo ${LL_DATE} | cut -c1-4`
      export LL_MM=`echo ${LL_DATE} | cut -c5-6`
      export LL_DD=`echo ${LL_DATE} | cut -c7-8`
      export LL_HH=`echo ${LL_DATE} | cut -c9-10`
      export LL_MN=00
      export LL_SS=00
      export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:${LL_MN}:${LL_SS}
#
# Copy original posterior emissions to backup files
#
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
#
         export WRFCHEMI_PRIOR_MEM=wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}
         export WRFCHEMI_POST_MEM=wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
         export WRFCHEMI_MEM_OLD=wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}_old
         export WRFFIRECHEMI_PRIOR_MEM=wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}
         export WRFFIRECHEMI_POST_MEM=wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
         export WRFFIRECHEMI_MEM_OLD=wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}_old
#
         cp  ${WRFCHEMI_PRIOR_MEM} ${WRFCHEMI_MEM_OLD}
         cp  ${WRFFIRECHEMI_PRIOR_MEM} ${WRFFIRECHEMI_MEM_OLD}
         let MEM=${MEM}+1
      done
#
      cp ${ADJUST_EMISS_DIR}/work/post_emis_inflation.exe ./.
      export WRFCHEMI=wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}
      cp ${WRFCHEMI}.e001 ${WRFCHEMI}'_sprd_post'
      cp ${WRFCHEMI}.e001 ${WRFCHEMI}'_sprd_post_adj'
      export WRFFIRECHEMI=wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}
      cp ${WRFFIRECHEMI}.e001 ${WRFFIRECHEMI}'_sprd_post'
      cp ${WRFFIRECHEMI}.e001 ${WRFFIRECHEMI}'_sprd_post_adj'
#
# Create namelist
      rm -rf post_emiss_inflation_nml.nl
      cat << EOF > post_emiss_inflation_nml.nl
&post_emiss_inflation_nml
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chem=${NNZ_CHEM},
nchem_spcs=${NUM_WRFCHEMI_DARTVARS},
nfire_spcs=${NUM_WRFFIRECHEMI_DARTVARS},
nnum_mem=${NUM_MEMBERS},
wrfchemi='${WRFCHEMI}',
wrffirechemi='${WRFFIRECHEMI}',
fac=0.5,
/
EOF
#
      rm -rf post_emiss_inflation_spec_nml.nl
      cat << EOF > post_emiss_inflation_spec_nml.nl
&post_emiss_inflation_spec_nml
ch_chem_spc=${WRFCHEMI_DARTVARS}
ch_fire_spc=${WRFFIRECHEMI_DARTVARS}
/
EOF
#
# Run the posterior emissions inflation code
      TRANDOM=$$
      export JOBRND=${TRANDOM}_inf
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LI\
MIT} ${GENERAL_NODES} ${GENERAL_TASKS} ./post_emis_inflation.exe SERIAL ${ACCOUNT} ${GENERAL_MODEL}
      qsub -Wblock=true job.ksh
#
