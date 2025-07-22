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
# Process filter output without calling filter	 
      if ! ${SKIP_FILTER}; then
#
# Get DART files
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
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./.
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./.
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}
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
#         set -A temp `echo ${ASIM_MIN_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
#         (( temp[1]=${temp[1]}+1 ))
#         export NL_FIRST_OBS_DAYS=${temp[0]}
#         export NL_FIRST_OBS_SECONDS=${temp[1]}
         export NL_FIRST_OBS_DAYS=${ASIM_MIN_DAY_GREG}
         export NL_FIRST_OBS_SECONDS=${ASIM_MIN_SEC_GREG}
#         set -A temp `echo ${ASIM_MAX_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
#         export NL_LAST_OBS_DAYS=${temp[0]}
#         export NL_LAST_OBS_SECONDS=${temp[1]}
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
      fi
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
#
# Calculate ensemble mean emissions posterior
#ncea -n ${NUM_MEMBERS},3,1 wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.e001 wrfchemi_d${CR_DOMAIN}_post_mean
#ncea -n ${NUM_MEMBERS},3,1 wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.e001 wrffirechemi_d${CR_DOMAIN}_post_mean
EOF
#
      TRANDOM=$$
      export JOBRND=${TRANDOM}_nco
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
      qsub -Wblock=true job.ksh
      sleep 30
      mv index.html index_nco2.html
#
