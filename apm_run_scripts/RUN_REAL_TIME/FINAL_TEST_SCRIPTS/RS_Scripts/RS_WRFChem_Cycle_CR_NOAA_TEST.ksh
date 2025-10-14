#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/wrfchem_cycle_cr
#
# Run WRF-Chem for all ensemble members
      TRANDOM=$$
      let IMEM=1
      export L_NUM_MEMBERS=${NUM_MEMBERS}
      if ${RUN_SPECIAL_FORECAST}; then
         export L_NUM_MEMBERS=${NUM_SPECIAL_FORECAST}
      fi
      while [[ ${IMEM} -le ${L_NUM_MEMBERS} ]]; do
         export MEM=${IMEM}
         export NL_TIME_STEP=${NNL_TIME_STEP}
         if ${RUN_SPECIAL_FORECAST}; then
            export MEM=${SPECIAL_FORECAST_MEM[${IMEM}]}
            let NL_TIME_STEP=${NNL_TIME_STEP}*${SPECIAL_FORECAST_FAC}
         fi
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
         export L_RUN_DIR=run_${CMEM}
         cd ${RUN_DIR}/${DATE}/wrfchem_cycle_cr
         if ${RUN_SPECIAL_FORECAST}; then
            rm -rf ${L_RUN_DIR}
         fi
         if [[ ! -e ${L_RUN_DIR} ]]; then
            mkdir ${L_RUN_DIR}
            cd ${L_RUN_DIR}
         else
            cd ${L_RUN_DIR}
         fi
#
# Get WRF-Chem parameter files
         cp ${WRFCHEM_DART_WORK_DIR}/advance_time ./.
         cp ${WRFCHEM_DART_WORK_DIR}/input.nml ./.
         cp ${WRFCHEM_DIR}/test/em_real/wrf.exe ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_lat.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_lon.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_plev.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/bulkdens.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/bulkradii.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAM_ABS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAM_AEROPT_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.A1B ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.A2 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.RCP4.5 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.RCP6 ./.
         cp ${WRFCHEM_DIR}/test/em_real/capacity.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/CCN_ACTIVATE.BIN ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ALB_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ALB_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ASM_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ASM_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_DRDSDT0_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_EXT_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_EXT_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_KAPPA_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_TAU_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/coeff_p.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/coeff_q.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/constants.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA.expanded_rain ./.
         cp ${WRFCHEM_DIR}/test/em_real/GENPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/grib2map.tbl ./.
         cp ${WRFCHEM_DIR}/test/em_real/gribmap.txt ./.
         cp ${WRFCHEM_DIR}/test/em_real/kernels.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/kernels_z.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/LANDUSE.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/masses.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/MPTABLE.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone_lat.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone_plev.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTM_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTMG_LW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTMG_SW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/SOILPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/termvels.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr49t67 ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr49t85 ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr67t85 ./.
         cp ${WRFCHEM_DIR}/test/em_real/URBPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/VEGPARM.TBL ./.
         cp ${WRFCHEM_DIR}/run/HLC.TBL ./.
#         ln -sf ${EXPERIMENT_PHOT_DIR}/TUV/TUV.phot/* ./.	 
         cp -r ${EXPERIMENT_PHOT_DIR}/TUV/TUV.phot/* ./.	 
#
# Get WRF-Chem input and bdy files
         cp ${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CMEM} wrfinput_d${CR_DOMAIN}
         cp ${UPDATE_BC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CMEM} wrfbdy_d${CR_DOMAIN}
	 cp ${RUN_INPUT_DIR}/${DATE}/real/wrflowinp_d${CR_DOMAIN}_${START_FILE_DATE} wrflowinp_d${CR_DOMAIN}
#
# Get WRF-Chem emissions files
         export L_DATE=${START_DATE}00
         while [[ ${L_DATE} -le ${END_DATE} ]]; do
            export L_YY=`echo ${L_DATE} | cut -c1-4`
            export L_MM=`echo ${L_DATE} | cut -c5-6`
            export L_DD=`echo ${L_DATE} | cut -c7-8`
            export L_HH=`echo ${L_DATE} | cut -c9-10`
            export L_FILE_DATE=${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
            if [[ ${L_HH} -eq 00 || ${L_HH} -eq 03 || ${L_HH} -eq 06 || ${L_HH} -eq 09 || ${L_HH} -eq 12 || ${L_HH} -eq 15 || ${L_HH} -eq 18 || ${L_HH} -eq 21 ]]; then
               cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrfbiochemi_d${CR_DOMAIN}_${L_FILE_DATE}
            fi
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}		
            export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} +1 -f ccyymmddhhnn 2>/dev/null)
         done
#
# Update the emission files
         if [[ ${L_ADD_EMISS} = "true" ]]; then
            rm jobx.ksh
            touch jobx.ksh
            chmod +x jobx.ksh
            cat << EOF > jobx.ksh
rm -rf wrfchemi_d${CR_DOMAIN}_prior
rm -rf wrfchemi_d${CR_DOMAIN}_post
rm -rf wrffirechemi_d${CR_DOMAIN}_prior
rm -rf wrffirechemi_d${CR_DOMAIN}_post
rm -rf adjust_chem_emiss.exe
#
# Get updated cycle time emissions for this member
cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_prior
cp ${DART_FILTER_DIR}/wrfchemi_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_post
cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_prior
cp ${DART_FILTER_DIR}/wrffirechemi_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_post
cp ${ADJUST_EMISS_DIR}/work/adjust_chem_emiss.exe ./.
#
export L_DATE=${START_DATE}
while [[ \${L_DATE} -le ${END_DATE} ]]; do 
   export L_YY=$(echo \$L_DATE | cut -c1-4)
   export L_MM=$(echo \$L_DATE | cut -c5-6)
   export L_DD=$(echo \$L_DATE | cut -c7-8)
   export L_HH=$(echo \$L_DATE | cut -c9-10)
   export L_FILE_DATE=\${L_YY}-\${L_MM}-\${L_DD}_\${L_HH}:00:00
#
   export NL_WRFCHEMI_PRIOR=wrfchemi_d${CR_DOMAIN}_prior
   export NL_WRFCHEMI_POST=wrfchemi_d${CR_DOMAIN}_post
   export NL_WRFCHEMI_OLD=wrfchemi_d${CR_DOMAIN}_\${L_FILE_DATE}
   export NL_WRFCHEMI_NEW=wrfchemi_d${CR_DOMAIN}_new
   rm -rf  \${NL_WRFCHEMI_NEW}
   cp \${NL_WRFCHEMI_OLD} \${NL_WRFCHEMI_NEW}
#
   export NL_WRFFIRECHEMI_PRIOR=wrffirechemi_d${CR_DOMAIN}_prior
   export NL_WRFFIRECHEMI_POST=wrffirechemi_d${CR_DOMAIN}_post
   export NL_WRFFIRECHEMI_OLD=wrffirechemi_d${CR_DOMAIN}_\${L_FILE_DATE}
   export NL_WRFFIRECHEMI_NEW=wrffirechemi_d${CR_DOMAIN}_new
   rm -rf  \${NL_WRFFIRECHEMI_NEW}
   cp \${NL_WRFFIRECHEMI_OLD} \${NL_WRFFIRECHEMI_NEW}
#
   if [[ \${L_DATE} -eq ${START_DATE} ]]; then
      cp \${NL_WRFCHEMI_POST} \${NL_WRFCHEMI_NEW}    
      cp \${NL_WRFFIRECHEMI_POST} \${NL_WRFFIRECHEMI_NEW}    
   else
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
wrfchemi_old='\${NL_WRFCHEMI_OLD}',
wrfchemi_new='\${NL_WRFCHEMI_NEW}',
wrffirechemi_prior='\${NL_WRFFIRECHEMI_PRIOR}',
wrffirechemi_post='\${NL_WRFFIRECHEMI_POST}',
wrffirechemi_old='\${NL_WRFFIRECHEMI_OLD}',
wrffirechemi_new='\${NL_WRFFIRECHEMI_NEW}'
/
EOFF
      rm -rf index_adjust_chem_emiss
      ./adjust_chem_emiss.exe > index_adjust_chem_emiss
   fi
#
   rm -rf \${NL_WRFCHEMI_OLD}
   rm -rf \${NL_WRFFIRECHEMI_OLD}
   cp \${NL_WRFCHEMI_NEW} \${NL_WRFCHEMI_OLD}
   cp \${NL_WRFFIRECHEMI_NEW} \${NL_WRFFIRECHEMI_OLD}
   rm \${NL_WRFCHEMI_NEW}
   rm \${NL_WRFFIRECHEMI_NEW}
   export L_DATE=$(${BUILD_DIR}/da_advance_time.exe \${L_DATE} +1 -f ccyymmddhhnn 2>/dev/null)
done
rm -rf \${NL_WRFCHEMI_PRIOR}
rm -rf \${NL_WRFCHEMI_POST}
rm -rf \${NL_WRFFIRECHEMI_PRIOR}
rm -rf \${NL_WRFFIRECHEMI_POST}
EOF
            TRANDOM=$$
            export JOBRND=${TRANDOM}_adj
            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
            qsub job.ksh
            ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
            mv index.html index_adjust_emiss_log
         fi
         let IMEM=${IMEM}+1
      done




	 
      while [[ ${IMEM} -le ${L_NUM_MEMBERS} ]]; do
         export MEM=${IMEM}
         export NL_TIME_STEP=${NNL_TIME_STEP}
         if ${RUN_SPECIAL_FORECAST}; then
            export MEM=${SPECIAL_FORECAST_MEM[${IMEM}]}
            let NL_TIME_STEP=${NNL_TIME_STEP}*${SPECIAL_FORECAST_FAC}
         fi
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
         export L_RUN_DIR=run_${CMEM}
         cd ${RUN_DIR}/${DATE}/wrfchem_cycle_cr
         if ${RUN_SPECIAL_FORECAST}; then
            rm -rf ${L_RUN_DIR}
         fi
         if [[ ! -e ${L_RUN_DIR} ]]; then
            mkdir ${L_RUN_DIR}
            cd ${L_RUN_DIR}
         else
            cd ${L_RUN_DIR}
         fi
#
# Create WRF-Chem namelist.input 
         export NL_MAX_DOM=1
         rm -rf namelist.input
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfchem_namelist_RT_NOAA.ksh
#
         export JOBRND=${TRANDOM}_wrf
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${WRFCHEM_JOB_CLASS} ${WRFCHEM_TIME_LIMIT} ${WRFCHEM_NODES} ${WRFCHEM_TASKS} wrf.exe PARALLEL ${ACCOUNT} ${WRFCHEM_MODEL}
#
	 if [[ ${WRFCHEM_JOB_CLASS} == devel ]]; then
             qsub -Wblock=true job.ksh
	 else
             qsub job.ksh
	 fi    
         let IMEM=${IMEM}+1
      done
#
# Wait for WRFCHEM to complete for each member
      if [[ ${WRFCHEM_JOB_CLASS} != devel ]]; then
         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
      fi
#
# Clean directory
#      let IMEM=1
#      while [[ ${IMEM} -le ${L_NUM_MEMBERS} ]]; do
#         export MEM=${IMEM}
#         export CMEM=e${MEM}
#         export KMEM=${MEM}
#         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
#         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
#         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
#	 cd run_${CMEM}
#	 rm *_wrf.o* aerosol* bulk* CAM* capacity* CCN_* clim_* CLM_* coeff_* constants*
#	 rm ETAMPNEW* exo_coldens* freeze* GENPARM* grib* hist_io* HLC* job.ksh kernels*
#	 rm LANDUSE* masses* MPTABLE* namelist* onzone* qr_acr* RRTM* SOILPARM*
#	 rm termvels* tr* ubvals* URBPARM* VEGPARM* wrfapm* wrfbdy* wrfbiochemi* wrfchemi*
#	 rm wrf.exe wrffirechemi* wrfinput* wrf_season*
#         let IMEM=${IMEM}+1
#      done
