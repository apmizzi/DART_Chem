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
         cp  wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}  wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}'_ori'
         ln -sf ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}'_old' ./.
         let MEM=${MEM}+1
      done
#
# Starting reset the clamping value
      cp ${ADJUST_EMISS_DIR}/work/post_emis_inflation.exe ./.
#
      export WRFCHEMI=wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}
      cp ${WRFCHEMI}.e001 ${WRFCHEMI}'_sprd_post'
      cp ${WRFCHEMI}.e001 ${WRFCHEMI}'_sprd_post_adj'
#
# Create namelist
      export NL_PERT_PATH_PR=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
      export NL_PERT_PATH_PO=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
      if [[ ${LL_DATE} -eq ${DATE} || ${L_HH} -eq 00 ]]; then
         export NL_PERT_PATH_PR=${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss
         export NL_PERT_PATH_PO=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
      fi
      rm -rf post_emiss_inflation_nml.nl
      cat << EOF > post_emiss_inflation_nml.nl
&post_emiss_inflation_nml
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chem=${NNZ_CHEM},
nchem_spcs=${NCHEMI_EMISS},
pert_path_pr='${NL_PERT_PATH_PR}',
pert_path_po='${NL_PERT_PATH_PO}',
nnum_mem=${NUM_MEMBERS},
wrfchemi='${WRFCHEMI}',
fac     =0.5,
/
EOF
#
      rm -rf post_emiss_inflation_spec_nml.nl
      cat << EOF > post_emiss_inflation_spec_nml.nl
&post_emiss_inflation_spec_nml
ch_chem_spc=${WRFCHEMI_DARTVARS}
/
EOF
#
# Run the posterior emissions inflation code
      TRANDOM=$$
      export JOBRND=${TRANDOM1}_inf
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LI\
MIT} ${GENERAL_NODES} ${GENERAL_TASKS} ./post_emis_inflation.exe SERIAL ${ACCOUNT} ${GENERAL_MODEL}
      qsub -Wblock=true job.ksh
#
