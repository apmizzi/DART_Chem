#!/bin/ksh -aux
#      cd ${RUN_DIR}/${DATE}/localization
#
# GET WRFINPUT TEMPLATE
      cp ${WRFCHEM_TEMPLATE_DIR}/${WRFCHEM_TEMPLATE_FILE} wrfinput_d${CR_DOMAIN}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${FILE_DATE}.e001 wrfchemi_d${CR_DOMAIN}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${FILE_DATE}.e001 wrffirechemi_d${CR_DOMAIN}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${CR_DOMAIN}_${FILE_DATE}.e001 wrfbiochemi_d${CR_DOMAIN}
#
# Copy the emissions fields to be adjusted from the emissions input files
# to the wrfinput files
      rm jobx.ksh
      touch jobx.ksh
      chmod +x jobx.ksh
      cat << EOF > jobx.ksh
#!/bin/ksh -aux
ncrename -d emissions_zdim,chemi_zdim -O wrfchemi_d${CR_DOMAIN} wrfchemi_d${CR_DOMAIN}_temp
ncrename -d emissions_zdim_stag,fire_zdim_stag -O wrffirechemi_d${CR_DOMAIN} wrffirechemi_d${CR_DOMAIN}_temp
ncks -A -C -v ${WRFCHEMI_DARTVARS} wrfchemi_d${CR_DOMAIN}_temp wrfinput_d${CR_DOMAIN}
ncks -A -C -v ${WRFFIRECHEMI_DARTVARS} wrffirechemi_d${CR_DOMAIN}_temp wrfinput_d${CR_DOMAIN}
EOF
      TRANDOM=$$
      export JOBRND=${TRANDOM}_nco
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
      qsub -Wblock=true job.ksh
      mv index.html index_nco_1.html
#
# GET DART UTILITIES
      cp ${WRFCHEM_DART_WORK_DIR}/wrf_dart_obs_preprocess ./.
      cp ${DART_DIR}/models/wrf_chem/WRF_DART_utilities/wrf_dart_obs_preprocess.nml ./.
      rm -rf input.nml
      export NL_DEFAULT_STATE_VARIABLES=.false.
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
      ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input_preprocess.nml.ksh
#
# GET INPUT DATA
      rm -rf obs_seq.old
      rm -rf obs_seq.new
      cp ${COMBINE_OBS_DIR}/obs_seq_comb_${DATE}.out obs_seq.old
      TRANDOM=$$      
      export JOBRND=${TRANDOM}_prepr
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} "wrf_dart_obs_preprocess ${DAY_GREG} ${SEC_GREG}" SERIAL ${ACCOUNT} ${GENERAL_MODEL}
      sleep 15
      qsub -Wblock=true job.ksh
      mv index.html index_prepr.html
      mv obs_seq.new obs_seq_comb_filtered_${DATE}.out
#      rm -rf advance_time dart_log* input.nml job.ksh obs_seq.old wrf*
