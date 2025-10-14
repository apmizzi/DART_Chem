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
      export NL_NUM_CHEMI_FILES=4
      export NL_NUM_FIRECHEMI_FILES=4
#
#########################################################################
#
# PROPOGATE HISTORICAL EMISSIONS ADJUSTMENT FROM PREVIOIS CYCLE
#
#########################################################################
#
      if [[ ${DATE} -gt  ${FIRST_EMISS_INV_DATE} && ${ADD_EMISS} = "true" ]]; then
         if [[ ! -e emissions_scaling ]]; then
            mkdir emissions_scaling
            cd emissions_scaling
            cp ${ADJUST_EMISS_DIR}/work/adjust_chem_emiss.exe ./.
         else
            cd emissions_scaling
            cp ${ADJUST_EMISS_DIR}/work/adjust_chem_emiss.exe ./.
         fi        
         rm jobx.ksh
         touch jobx.ksh
         chmod +x jobx.ksh
         cat << EOF > jobx.ksh
let MEM=1
while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
   export CMEM=e\${MEM}
   if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
   if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
#
   export NL_WRFCHEMI=wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.\${CMEM}
   export NL_WRFCHEMI_PRIOR=wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}_prior.\${CMEM}
   export NL_WRFCHEMI_POST=wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}_post.\${CMEM}
   export NL_WRFFIRECHEMI=wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.\${CMEM}
   export NL_WRFFIRECHEMI_PRIOR=wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}_prior.\${CMEM}
   export NL_WRFFIRECHEMI_POST=wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}_post.\${CMEM}
#
   rm -rf \${NL_WRFCHEMI}
   rm -rf \${NL_WRFCHEMI_PRIOR}
   rm -rf \${NL_WRFCHEMI_POST}
   rm -rf \${NL_WRFFIRECHEMI}
   rm -rf \${NL_WRFFIRECHEMI_PRIOR}
   rm -rf \${NL_WRFFIRECHEMI_POST}
#
   cp ${RUN_DIR}/${PAST_DATE}/dart_filter/\${NL_WRFCHEMI_PRIOR} \${NL_WRFCHEMI_PRIOR}
   cp ${RUN_DIR}/${PAST_DATE}/dart_filter/\${NL_WRFCHEMI} \${NL_WRFCHEMI_POST}
   cp ${RUN_DIR}/${PAST_DATE}/dart_filter/\${NL_WRFFIRECHEMI_PRIOR} \${NL_WRFFIRECHEMI_PRIOR}
   cp ${RUN_DIR}/${PAST_DATE}/dart_filter/\${NL_WRFFIRECHEMI} \${NL_WRFFIRECHEMI_POST}
#
   let ICNT=1
   export L_DATE=${DATE}
      while [[ \${L_DATE} -le ${END_DATE} ]]; do 
      export L_YY=\$(echo \$L_DATE | cut -c1-4)
      export L_MM=\$(echo \$L_DATE | cut -c5-6)
      export L_DD=\$(echo \$L_DATE | cut -c7-8)
      export L_HH=\$(echo \$L_DATE | cut -c9-10)
      export L_FILE_DATE=\${L_YY}-\${L_MM}-\${L_DD}_\${L_HH}:00:00
!
      export NL_WRFCHEMI=${RUN_INPUT_DIR}/${DATE}/wrfchem_chem_emiss/wrfchemi_d${CR_DOMAIN}_\${L_FILE_DATE}.\${CMEM}
      export NL_WRFCHEMI_OLD[\${ICNT}]=wrfchemi_d${CR_DOMAIN}_\${L_FILE_DATE}.\${CMEM}_old
      export NL_WRFCHEMI_NEW[\${ICNT}]=wrfchemi_d${CR_DOMAIN}_\${L_FILE_DATE}.\${CMEM}_new
      export NL_WRFFIRECHEMI=${RUN_INPUT_DIR}/${DATE}/wrfchem_chem_emiss/wrffirechemi_d${CR_DOMAIN}_\${L_FILE_DATE}.\${CMEM}
      export NL_WRFFIRECHEMI_OLD[\${ICNT}]=wrffirechemi_d${CR_DOMAIN}_\${L_FILE_DATE}.\${CMEM}_old
      export NL_WRFFIRECHEMI_NEW[\${ICNT}]=wrffirechemi_d${CR_DOMAIN}_\${L_FILE_DATE}.\${CMEM}_new
!
      cp \${NL_WRFCHEMI} \${NL_WRFCHEMI_OLD[\${ICNT}]}
      cp \${NL_WRFCHEMI_OLD[\${ICNT}]} \${NL_WRFCHEMI_NEW[\${ICNT}]}
      cp \${NL_WRFFIRECHEMI} \${NL_WRFFIRECHEMI_OLD[\${ICNT}]}
      cp \${NL_WRFFIRECHEMI_OLD[\${ICNT}]} \${NL_WRFFIRECHEMI_NEW[\${ICNT}]}
!
      let ICNT=\${ICNT}+1
      export L_DATE=\$(${BUILD_DIR}/da_advance_time.exe \${L_DATE} +1 -f ccyymmddhhnn 2>/dev/null)
   done
#
   rm -rf adjust_chem_emiss_dims.nml
   cat <<  EOFF > adjust_chem_emiss_dims.nml
&adjust_chem_emiss_dims
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chemi=${NZ_CHEMI},
nz_firechemi=${NZ_FIRECHEMI},
nchemi_emiss=${NUM_WRFCHEMI_DARTVARS},
nfirechemi_emiss=${NUM_WRFFIRECHEMI_DARTVARS},
num_chemi_files=${NL_NUM_CHEMI_FILES},
num_firechemi_files=${NL_NUM_FIRECHEMI_FILES},
/   
EOFF
   rm -rf adjust_chem_emiss.nml
   cat <<  EOFF > adjust_chem_emiss.nml
&adjust_chem_emiss
chemi_spcs=${WRFCHEMI_DARTVARS},
firechemi_spcs=${WRFFIRECHEMI_DARTVARS},
fac=${EMISS_DAMP_CYCLE},
facc=${EMISS_DAMP_INTRA_CYCLE},
wrfchemi_prior='\${NL_WRFCHEMI_PRIOR}',
wrfchemi_post='\${NL_WRFCHEMI_POST}',
wrfchemi_old='\${NL_WRFCHEMI_OLD[1]}','\${NL_WRFCHEMI_OLD[2]}','\${NL_WRFCHEMI_OLD[3]}','\${NL_WRFCHEMI_OLD[4]}',
wrfchemi_new='\${NL_WRFCHEMI_NEW[1]}','\${NL_WRFCHEMI_NEW[2]}','\${NL_WRFCHEMI_NEW[3]}','\${NL_WRFCHEMI_NEW[4]}',
wrffirechemi_prior='\${NL_WRFFIRECHEMI_PRIOR}',
wrffirechemi_post='\${NL_WRFFIRECHEMI_POST}',
wrffirechemi_old='\${NL_WRFFIRECHEMI_OLD[1]}','\${NL_WRFFIRECHEMI_OLD[2]}','\${NL_WRFFIRECHEMI_OLD[3]}','\${NL_WRFFIRECHEMI_OLD[4]}',
wrffirechemi_new='\${NL_WRFFIRECHEMI_NEW[1]}','\${NL_WRFFIRECHEMI_NEW[2]}','\${NL_WRFFIRECHEMI_NEW[3]}','\${NL_WRFFIRECHEMI_NEW[4]}'
/   
EOFF
   rm -rf index_adjust_chem_emiss
   ./adjust_chem_emiss.exe > index_adjust_chem_emiss
#
   let ICNT=01
   while [[ \${ICNT} -le ${NL_NUM_CHEMI_FILES} ]]; do
      rm -rf \${NL_WRFCHEMI_OLD[\${ICNT}]}
      rm -rf \${NL_WRFFIRECHEMI_OLD[\${ICNT}]}
      let ICNT=\${ICNT}+1
   done
   rm -rf \${NL_WRFCHEMI_PRIOR}
   rm -rf \${NL_WRFCHEMI_POST}
   rm -rf \${NL_WRFFIRECHEMI_PRIOR}
   rm -rf \${NL_WRFFIRECHEMI_POST}
let MEM=MEM+1
done
EOF
#
         TRANDOM=$$
         export JOBRND=${TRANDOM}_adj
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
         qsub -Wblock=true job.ksh
         mv index.html index_adjust_emiss_log
      fi
#
#########################################################################
#
# RUN DART FILTER
#
#########################################################################
#
# Get DART files
      cd ${RUN_DIR}/${DATE}/dart_filter/
      cp ${WRFCHEM_DART_WORK_DIR}/filter      ./.
      cp ${WRFCHEM_DART_WORK_DIR}/advance_time ./.
      cp ${WRFCHEM_DART_WORK_DIR}/input.nml ./.
      cp ${DART_DIR}/assimilation_code/programs/gen_sampling_err_table/work/sampling_error_correction_table.nc ./.
#
# Get background forecasts
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} ]]; then
         export BACKGND_FCST_DIR=${WRFCHEM_INITIAL_DIR}
      else
         export BACKGND_FCST_DIR=${WRFCHEM_LAST_CYCLE_CR_DIR}
      fi
#
# Get observations
      if [[ -n ${PREPROCESS_OBS_DIR}/obs_seq_comb_filtered_${START_DATE}.out ]]; then      
         cp  ${PREPROCESS_OBS_DIR}/obs_seq_comb_filtered_${START_DATE}.out obs_seq.out
      else
         echo APM ERROR: NO DART OBSERVATIONS
         exit
      fi
#
# Create namelist
      rm input.nml	 
      ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
      cp ${EXPERIMENT_STATIC_FILES}/ubvals_b40.20th.track1_1996-2005.nc ./.
#
# Copy DART file that controls the observation/state variable update localization
      cp ${LOCALIZATION_DIR}/control_impact_runtime.txt ./control_impact_runtime.table
#
# Loop through members, link, copy background files, create input/output lists
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
#
# Copy background input file
         cp ${BACKGND_FCST_DIR}/run_${CMEM}/wrfout_d${CR_DOMAIN}_${FILE_DATE} wrfinput_d${CR_DOMAIN}_${CMEM}
#   
# Copy emission input files
         if [[ ${DATE} -gt  ${FIRST_EMISS_INV_DATE} && ${ADD_EMISS} = "true" ]]; then
            cp emissions_scaling/wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}_new wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
            cp emissions_scaling/wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}_new wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
            cp emissions_scaling/wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}_new wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}
            cp emissions_scaling/wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}_new wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}  
         else
            cp ${RUN_INPUT_DIR}/${DATE}/wrfchem_chem_emiss/wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./.
            cp ${RUN_INPUT_DIR}/${DATE}/wrfchem_chem_emiss/wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./.
            cp ${RUN_INPUT_DIR}/${DATE}/wrfchem_chem_emiss/wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}
            cp ${RUN_INPUT_DIR}/${DATE}/wrfchem_chem_emiss/wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}
         fi	       
         let MEM=${MEM}+1
      done
#
# Rename the emissions dimensions and copy to input files
      rm -rf input_list.txt
      rm -rf output_list.txt
      touch input_list.txt
      touch output_list.txt
      rm jobx.ksh
      touch jobx.ksh
      chmod +x jobx.ksh
      cat << EOF > jobx.ksh
#!/bin/ksh -aux
let MEM=1
while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
   export CMEM=e\${MEM}
   export KMEM=\${MEM}
   if [[ \${MEM} -lt 1000 ]]; then export KMEM=0\${MEM}; fi
   if [[ \${MEM} -lt 100 ]]; then export KMEM=00\${MEM}; export CMEM=e0\${MEM}; fi
   if [[ \${MEM} -lt 10 ]]; then export KMEM=000\${MEM}; export CMEM=e00\${MEM}; fi
   ncrename -d emissions_zdim,chemi_zdim_stag -O wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM} wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM}
   ncrename -d emissions_zdim_stag,fire_zdim_stag -O wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM} wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM}
   ncks -A -C -v ${WRFCHEMI_DARTVARS} wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM} wrfinput_d${CR_DOMAIN}_\${CMEM}
   ncks -A -C -v ${WRFFIRECHEMI_DARTVARS} wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM} wrfinput_d${CR_DOMAIN}_\${CMEM}
#
# Add files to the DART input and output list
   echo wrfinput_d${CR_DOMAIN}_\${CMEM} >> input_list.txt
   echo wrfinput_d${CR_DOMAIN}_\${CMEM} >> output_list.txt
   let MEM=\${MEM}+1
done
EOF
#
      TRANDOM=$$
      export JOBRND=${TRANDOM}_nco
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
      qsub -Wblock=true job.ksh
      mv index.html index_nco1.html
#
# Copy template files
      cp wrfinput_d${CR_DOMAIN}_e001 wrfinput_d${CR_DOMAIN}      
#
# Copy "out" inflation files from prior cycle to "in" inflation files for current cycle
      if ${USE_DART_INFL}; then
         if [[ ${DATE} -eq ${FIRST_DART_INFLATE_DATE} ]]; then
            export NL_INF_INITIAL_FROM_RESTART_PRIOR=.false.
            export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.false.
            export NL_INF_INITIAL_FROM_RESTART_POST=.false.
            export NL_INF_SD_INITIAL_FROM_RESTART_POST=.false.
         else
            export NL_INF_INITIAL_FROM_RESTART_PRIOR=.true.
            export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.true.
            export NL_INF_INITIAL_FROM_RESTART_POST=.true.
            export NL_INF_SD_INITIAL_FROM_RESTART_POST=.true.
         fi
         if [[ ${DATE} -ne ${FIRST_DART_INFLATE_DATE} ]]; then
            if [[ ${NL_INF_FLAVOR_PRIOR} != 0 ]]; then
               export INF_OUT_FILE_MN_PRIOR=${RUN_DIR}/${PAST_DATE}/dart_filter/output_priorinf_mean.nc
               export INF_OUT_FILE_SD_PRIOR=${RUN_DIR}/${PAST_DATE}/dart_filter/output_priorinf_sd.nc
               cp ${INF_OUT_FILE_MN_PRIOR} input_priorinf_mean.nc
               cp ${INF_OUT_FILE_SD_PRIOR} input_priorinf_sd.nc
            fi
            if [[ ${NL_INF_FLAVOR_POST} != 0 ]]; then
               export INF_OUT_FILE_MN_POST=${RUN_DIR}/${PAST_DATE}/dart_filter/output_postinf_mean.nc
               export INF_OUT_FILE_SD_POST=${RUN_DIR}/${PAST_DATE}/dart_filter/output_postinf_sd.nc
               cp ${INF_OUT_FILE_MN_POST} input_postinf_mean.nc
               cp ${INF_OUT_FILE_SD_POST} input_postinf_sd.nc
            fi 
         fi
      fi
#
# Generate input.nml 
      export NL_FIRST_OBS_DAYS=${ASIM_MIN_DAY_GREG}
      export NL_FIRST_OBS_SECONDS=${ASIM_MIN_SEC_GREG}
      export NL_LAST_OBS_DAYS=${ASIM_MAX_DAY_GREG}
      export NL_LAST_OBS_SECONDS=${ASIM_MAX_SEC_GREG}
      export NL_NUM_INPUT_FILES=1
      export NL_FILENAME_SEQ="'obs_seq.out'"
      export NL_FILENAME_OUT="'obs_seq.processed'"
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
#
# Make filter_apm_nml for special_outlier_threshold
      rm -rf filter_apm.nml
      cat << EOF > filter_apm.nml
&filter_apm_nml
special_outlier_threshold=${NL_SPECIAL_OUTLIER_THRESHOLD}
/
EOF
#
# Run DART_FILTER
# Create job script for this member and run it 
      RANDOM=$$
      export JOBRND=${RANDOM}_filter
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${FILTER_JOB_CLASS} ${FILTER_TIME_LIMIT} ${FILTER_NODES} ${FILTER_TASKS} filter PARALLEL ${ACCOUNT} ${FILTER_MODEL}
      qsub -Wblock=true job.ksh
      mv index.html index_dart.html
#
# Check whether DART worked properly
      if [[ ! -f output_postinf_mean.nc || ! -f output_mean.nc || ! -f output_postinf_sd.nc || ! -f output_sd.nc || ! -f obs_seq.final ]]; then
         echo APM: ERROR in DART FILTER EXIT
         exit
      fi
#
# Remove emissions fields from the DART output files and copy to the emissions input files
      rm jobx.ksh
      touch jobx.ksh
      chmod +x jobx.ksh
      cat << EOF > jobx.ksh
#!/bin/ksh -aux
let MEM=${DART_MEM_STR}
while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
   export CMEM=e\${MEM}
   export KMEM=\${MEM}
   if [[ \${MEM} -lt 1000 ]]; then export KMEM=0\${MEM}; fi
   if [[ \${MEM} -lt 100 ]]; then export KMEM=00\${MEM}; export CMEM=e0\${MEM}; fi
   if [[ \${MEM} -lt 10 ]]; then export KMEM=000\${MEM}; export CMEM=e00\${MEM}; fi
#
# Copy the adjusted emissions fields from the wrfinput files to the emissions input files
   ncks -O -x -v ${WRFCHEMI_DARTVARS} wrfinput_d${CR_DOMAIN}_\${CMEM} wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.\${CMEM}
   ncks -O -x -v ${WRFFIRECHEMI_DARTVARS} wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.\${CMEM} wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.\${CMEM}
   ncks -A -C -v ${WRFCHEMI_DARTVARS} wrfinput_d${CR_DOMAIN}_\${CMEM} wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM}
   ncks -A -C -v ${WRFFIRECHEMI_DARTVARS} wrfinput_d${CR_DOMAIN}_\${CMEM} wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM}
   ncrename -d chemi_zdim_stag,emissions_zdim -O wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM} wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM}
   ncrename -d fire_zdim_stag,emissions_zdim_stag -O wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM} wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.\${CMEM}
   rm -rf wrfinput_d${CR_DOMAIN}_\${CMEM}
   let MEM=\${MEM}+1
done
EOF
#
      TRANDOM=$$
      export JOBRND=${TRANDOM}_nco
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
      qsub -Wblock=true job.ksh
      mv index.html index_nco2.html
#
