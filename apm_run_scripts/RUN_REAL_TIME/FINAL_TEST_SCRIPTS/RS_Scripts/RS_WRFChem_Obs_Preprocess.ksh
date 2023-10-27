
#!/bin/ksh -aux
#      cd ${RUN_DIR}/${DATE}/localization
#
# GET WRFINPUT TEMPLATE
      cp ${WRFCHEM_TEMPLATE_DIR}/${WRFCHEM_TEMPLATE_FILE} wrfinput_d${CR_DOMAIN}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${FILE_DATE}.e001 wrfchemi_d${CR_DOMAIN}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${FILE_DATE}.e001 wrffirechemi_d${CR_DOMAIN}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${CR_DOMAIN}_${FILE_DATE}.e001 wrfbiochemi_d${CR_DOMAIN}
      ncrename -d emissions_zdim_stag,chemi_zdim_stag -O wrfchemi_d${CR_DOMAIN} wrfchemi_d${CR_DOMAIN}_temp
      ncrename -d emissions_zdim_stag,fire_zdim_stag -O wrffirechemi_d${CR_DOMAIN} wrffirechemi_d${CR_DOMAIN}_temp
#
# Copy the emissions fields to be adjusted from the emissions input files
# to the wrfinput files
      ncks -A -v ${WRFCHEMI_DARTVARS} wrfchemi_d${CR_DOMAIN}_temp wrfinput_d${CR_DOMAIN}
      ncks -A -v ${WRFFIRECHEMI_DARTVARS} wrffirechemi_d${CR_DOMAIN}_temp wrfinput_d${CR_DOMAIN}
#
# GET DART UTILITIES
      cp ${WRFCHEM_DART_WORK_DIR}/wrf_dart_obs_preprocess ./.
      cp ${DART_DIR}/models/wrf_chem/WRF_DART_utilities/wrf_dart_obs_preprocess.nml ./.
      rm -rf input.nml
      export NL_DEFAULT_STATE_VARIABLES=.false.
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
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
      ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
#
# GET INPUT DATA
      rm -rf obs_seq.old
      rm -rf obs_seq.new
      cp ${COMBINE_OBS_DIR}/obs_seq_comb_${DATE}.out obs_seq.old
#
      rm -rf job.ksh
      touch job.ksh
      cat << EOF > job.ksh
#!/bin/ksh -aeux
#PBS -N prepr
#PBS -l walltime=${GENERAL_TIME_LIMIT}
#PBS -q ${GENERAL_JOB_CLASS}
#PBS -j oe
#PBS -l select=${GENERAL_NODES}:ncpus=1:model=san
#PBS -l site=needed=/home1+/nobackupp11
./wrf_dart_obs_preprocess ${DAY_GREG} ${SEC_GREG} > index.html 2>&1
export RC=\$?
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOF
#
      qsub -Wblock=true job.ksh
      mv obs_seq.new obs_seq_comb_filtered_${DATE}.out 
