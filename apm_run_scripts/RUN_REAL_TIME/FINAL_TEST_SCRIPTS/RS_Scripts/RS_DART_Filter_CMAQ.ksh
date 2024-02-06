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
      export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
#
# Process filter output without calling filter	 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
      if ! ${SKIP_FILTER}; then
#
# Get DART files
         cp ${CMAQ_DART_WORK_DIR}/filter      ./.
         cp ${CMAQ_DART_WORK_DIR}/advance_time ./.
         cp ${CMAQ_DART_WORK_DIR}/input.nml ./.
         cp ${DART_DIR}/assimilation_code/programs/gen_sampling_err_table/work/sampling_error_correction_table.nc ./.
#
# Get observations
         if [[ ${PREPROCESS_OBS_DIR}/obs_seq_comb_filtered_${START_DATE}.out ]]; then      
            cp  ${PREPROCESS_OBS_DIR}/obs_seq_comb_filtered_${START_DATE}.out obs_seq.out
         else
            echo APM ERROR: NO DART OBSERVATIONS
            exit
         fi
#
# Copy DART file that controls the observation/state variable update localization
         cp ${LOCALIZATION_DIR}/control_impact_runtime.txt ./control_impact_runtime.table
#
# Get background forecasts (These are the CCTM_CGRID_xxx ensemble of CMAQ output files).
         if [[ ${DATE} -eq ${FIRST_FILTER_DATE} ]]; then
            export BACKGND_FCST_DIR=${WRFCHEM_INITIAL_DIR}
         else
            export BACKGND_FCST_DIR=${WRFCHEM_LAST_CYCLE_CR_DIR}
         fi
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            export KMEM=${MEM}
            if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
            if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
            cp ${BACKGND_FCST_DIR}/run_${CMEM}/cmaqout_d${CR_DOMAIN}_${FILE_DATE} cmaqinput_d${CR_DOMAIN}_${CMEM}
#
# Add files to the DART input and output lists
            echo cmaqinput_d${CR_DOMAIN}_${CMEM} >> input_list.txt
            echo cmaqinput_d${CR_DOMAIN}_${CMEM} >> output_list.txt
            let MEM=${MEM}+1
         done
#
# Copy template files
         cp cmaqinput_d${CR_DOMAIN}_e001 cmaqinput_d${CR_DOMAIN}      
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
      fi   
#
# Generate input.nml
      set -A temp `echo ${ASIM_MIN_DATE} 0 -g | ${CMAQ_DART_WORK_DIR}/advance_time`
      (( temp[1]=${temp[1]}+1 ))
      export NL_FIRST_OBS_DAYS=${temp[0]}
      export NL_FIRST_OBS_SECONDS=${temp[1]}
      set -A temp `echo ${ASIM_MAX_DATE} 0 -g | ${CMAQ_DART_WORK_DIR}/advance_time`
      export NL_LAST_OBS_DAYS=${temp[0]}
      export NL_LAST_OBS_SECONDS=${temp[1]}
      export NL_NUM_INPUT_FILES=1
      export NL_FILENAME_SEQ="'obs_seq.out'"
      export NL_FILENAME_OUT="'obs_seq.processed'"
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input_cmaq.nml.ksh	 
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
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_has.ksh ${JOBRND} ${FILTER_JOB_CLASS} ${FILTER_TIME_LIMIT} ${FILTER_NODES} ${FILTER_TASKS} filter PARALLEL ${ACCOUNT}
      qsub -Wblock=true job.ksh

exit
      
#
# Check whether DART worked properly
      if [[ ! -f output_postinf_mean.nc || ! -f output_mean.nc || ! -f output_postinf_sd.nc || ! -f output_sd.nc || ! -f obs_seq.final ]]; then
         echo APM: ERROR in DART FILTER EXIT
         exit
      fi
