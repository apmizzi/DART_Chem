#!/bin/ksh -aux
   cd ${RUN_DIR}/${DATE}/wrfchem_chem_emiss
#
# SET PARAMETERS
      export NL_EMISS_TIME=0.0
      export NL_SW_SEED=true
      export NL_SW_CORR_TM=true
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then export NL_SW_CORR_TM=false; fi
#
# COPY PERTURBATION CODE
      rm -rf perturb_chem_emiss_CORR_RT_MA_MPI_PERT_TEST.exe
      cp ${PERT_CHEM_EMISS_DIR}/work/perturb_chem_emiss_CORR_RT_MA_MPI_PERT_TEST.exe ./.
#
# COPY THE WRFINPUT (for grid information)
      export WRFINPUT_FILE=wrfinput_d${CR_DOMAIN}
      export WRFINPUT_FULL=wrfinput_d01_${YYYY}-${MM}-${DD}_${HH}:00:00
      rm -rf ${WRFINPUT_FILE}
      cp ${REAL_DIR}/${WRFINPUT_FULL} ${WRFINPUT_FILE}
#
#########################################################################
#
# PERTURB THE EMISSIONS FILES
#
#########################################################################
#
      export LS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 1 -f ccyymmddhh 2>/dev/null)
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} ${FCST_PERIOD} -f ccyymmddhh 2>/dev/null)
      export L_YY_OLD=$(echo ${DATE} | cut -c1-4)
      export L_MM_OLD=$(echo ${DATE} | cut -c5-6)
      export L_DD_OLD=$(echo ${DATE} | cut -c7-8)
      export L_HH_OLD=$(echo ${DATE} | cut -c9-10)
      if [[ ${RUN_SPECIAL_PERT_SKIP} = "true" ]]; then
         export LS_DATE=${SPECIAL_PERT_DATE}
         export DATE_OLD=$(${BUILD_DIR}/da_advance_time.exe ${LS_DATE} -1 -f ccyymmddhh 2>/dev/null)
         export L_YY_OLD=$(echo ${DATE_OLD} | cut -c1-4)
         export L_MM_OLD=$(echo ${DATE_OLD} | cut -c5-6)
         export L_DD_OLD=$(echo ${DATE_OLD} | cut -c7-8)
         export L_HH_OLD=$(echo ${DATE_OLD} | cut -c9-10)
      fi
#
      export L_DATE=${LS_DATE}      
      while [[ ${L_DATE} -le ${LE_DATE} ]]; do
         export L_YY=$(echo ${L_DATE} | cut -c1-4)
         export L_MM=$(echo ${L_DATE} | cut -c5-6)
         export L_DD=$(echo ${L_DATE} | cut -c7-8)
         export L_HH=$(echo ${L_DATE} | cut -c9-10)
#
         if [[ ${L_DATE} -eq ${LS_DATE} ]]; then
            export CHEMI_PATH_OLD=${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss
            export FIRECHEMI_PATH_OLD=${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss
            export BIOGCHEMI_PATH_OLD=${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss
            export CHEMI_PATH_NEW=${WRFCHEM_CHEMI_DIR}
            export FIRECHEMI_PATH_NEW=${WRFCHEM_FIRE_DIR}
            export BIOGCHEMI_PATH_NEW=${WRFCHEM_BIO_DIR}
            export CHEMI_PATH_PERT=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
            export FIRECHEMI_PATH_PERT=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
            export BIOGCHEMI_PATH_PERT=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         else
            export CHEMI_PATH_OLD=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
            export FIRECHEMI_PATH_OLD=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
            export BIOGCHEMI_PATH_OLD=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
            export CHEMI_PATH_NEW=${WRFCHEM_CHEMI_DIR}
            export FIRECHEMI_PATH_NEW=${WRFCHEM_FIRE_DIR}
            export BIOGCHEMI_PATH_NEW=${WRFCHEM_BIO_DIR}
         fi
#
         export CHEMI_OLD=wrfchemi_d${CR_DOMAIN}_${L_YY_OLD}-${L_MM_OLD}-${L_DD_OLD}_${L_HH_OLD}:00:00
         export FIRECHEMI_OLD=wrffirechemi_d${CR_DOMAIN}_${L_YY_OLD}-${L_MM_OLD}-${L_DD_OLD}_${L_HH_OLD}:00:00
         export BIOGCHEMI_OLD=wrfbiochemi_d${CR_DOMAIN}_${L_YY_OLD}-${L_MM_OLD}-${L_DD_OLD}_${L_HH_OLD}:00:00
         export CHEMI_NEW=wrfchemi_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
         export FIRECHEMI_NEW=wrffirechemi_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
         export BIOGCHEMI_NEW=wrfbiochemi_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
#	     
         cp ${CHEMI_PATH_NEW}/${CHEMI_NEW} ${CHEMI_NEW}
	 chmod 644 ${CHEMI_NEW}
         cp ${FIRECHEMI_PATH_NEW}/${FIRECHEMI_NEW} ${FIRECHEMI_NEW}
         chmod 644 ${FIRECHEMI_NEW}
         if [[ ${L_HH} -eq 00 || ${L_HH} -eq 03 || ${L_HH} -eq 06 || ${L_HH} -eq 09 || ${L_HH} -eq 12 || ${L_HH} -eq 15 || ${L_HH} -eq 18 || ${L_HH} -eq 21 ]]; then
             cp ${BIOGCHEMI_PATH_NEW}/${BIOGCHEMI_NEW} ${BIOGCHEMI_NEW}
             chmod 644 ${BIOGCHEMI_NEW}
         fi
         ncatted -O -a coordinates,ebu_in_co,c,c,"XLONG, XLAT" ${FIRECHEMI_NEW}
         ncatted -O -a coordinates,ebu_in_no,c,c,"XLONG, XLAT" ${FIRECHEMI_NEW}
         ncatted -O -a coordinates,ebu_in_no2,c,c,"XLONG, XLAT" ${FIRECHEMI_NEW}
         ncatted -O -a coordinates,ebu_in_so2,c,c,"XLONG, XLAT" ${FIRECHEMI_NEW}
#
# CREATE ENSEMBLE MEMBER FILES AS TEMPLATES	 
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#
            if [[ ${L_DATE} -eq ${LS_DATE} ]]; then
               rm -rf ${CHEMI_OLD}.${CMEM}
               rm -rf ${FIRECHEMI_OLD}.${CMEM}
               cp ${CHEMI_PATH_OLD}/${CHEMI_OLD}.${CMEM} ${CHEMI_OLD}.${CMEM}
               cp ${FIRECHEMI_PATH_OLD}/${FIRECHEMI_OLD}.${CMEM} ${FIRECHEMI_OLD}.${CMEM}
               if [[ ${L_HH} -eq 00 || ${L_HH} -eq 03 || ${L_HH} -eq 06 || ${L_HH} -eq 09 || ${L_HH} -eq 12 || ${L_HH} -eq 15 || ${L_HH} -eq 18 || ${L_HH} -eq 21 ]]; then
                  rm -rf ${BIOGCHEMI_OLD}.${CMEM}
                  cp ${BIOGCHEMI_PATH_OLD}/${BIOGCHEMI_OLD}.${CMEM} ${BIOGCHEMI_OLD}.${CMEM}
               fi
            fi
#
	    rm -rf ${CHEMI_NEW}.${CMEM}
            rm -rf ${FIRECHEMI_NEW}.${CMEM}
            cp ${CHEMI_NEW} ${CHEMI_NEW}.${CMEM}
            cp ${FIRECHEMI_NEW} ${FIRECHEMI_NEW}.${CMEM}
            if [[ ${L_HH} -eq 00 || ${L_HH} -eq 03 || ${L_HH} -eq 06 || ${L_HH} -eq 09 || ${L_HH} -eq 12 || ${L_HH} -eq 15 || ${L_HH} -eq 18 || ${L_HH} -eq 21 ]]; then
               rm -rf ${BIOGCHEMI_NEW}.${CMEM}	    
               cp ${BIOGCHEMI_NEW} ${BIOGCHEMI_NEW}.${CMEM}
            fi
            let MEM=MEM+1
         done
#
# CREATE NAMELIST
         rm -rf perturb_chem_emiss_corr_nml.nl
         cat << EOF > perturb_chem_emiss_corr_nml.nl
&perturb_chem_emiss_CORR_nml
date=${L_MM}${L_DD}${L_HH},
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chem=${NZ_CHEMI},
nz_fire=${NZ_FIRECHEMI},
nz_biog=${NZ_BIOGCHEMI},
nchem_spcs=${NNCHEM_SPC},
nfire_spcs=${NNFIRE_SPC},
nbiog_spcs=${NNBIO_SPC},
chemi_path_old='${CHEMI_PATH_OLD}',
chemi_path_new='${CHEMI_PATH_NEW}',
chemi_path_pert='${CHEMI_PATH_PERT}',
firechemi_path_old='${FIRECHEMI_PATH_OLD}',
firechemi_path_new='${FIRECHEMI_PATH_NEW}',
firechemi_path_pert='${FIRECHEMI_PATH_PERT}',
biogchemi_path_old='${BIOGCHEMI_PATH_OLD}',
biogchemi_path_new='${BIOGCHEMI_PATH_NEW}',
biogchemi_path_pert='${BIOGCHEMI_PATH_PERT}',
chemi_file_old='${CHEMI_OLD}',
chemi_file_new='${CHEMI_NEW}',
firechemi_file_old='${FIRECHEMI_OLD}',
firechemi_file_new='${FIRECHEMI_NEW}',
biogchemi_file_old='${BIOGCHEMI_OLD}',
biogchemi_file_new='${BIOGCHEMI_NEW}',
nnum_mems=${NUM_MEMBERS},
sprd_chem=${NL_SPREAD_CHEMI},
sprd_fire=${NL_SPREAD_FIRE},
sprd_biog=${NL_SPREAD_BIOG},
sw_corr_tm=${NL_SW_CORR_TM},
sw_seed=${NL_SW_SEED},
sw_chem=${NL_PERT_CHEM},
sw_fire=${NL_PERT_FIRE},
sw_biog=${NL_PERT_BIO},
corr_lngth_hz=${NL_HZ_CORR_LNGTH},
corr_lngth_vt=${NL_VT_CORR_LNGTH},
corr_lngth_tm=${NL_TM_CORR_LNGTH_BC},
corr_tm_delt=${NL_EMISS_TIME},
/
EOF
            rm -rf perturb_emiss_chem_spec_nml.nl
            cat << EOF > perturb_emiss_chem_spec_nml.nl
#
# These need to match the emissions species in the respective emissions files
&perturb_chem_emiss_spec_nml
ch_chem_spc=${NL_CHEM_ANTHRO_EMIS},
ch_fire_spc=${NL_CHEM_FIRE_EMIS},
ch_biog_spc=${NL_CHEM_BIOG_EMIS},
/
EOF
            RANDOM=$$
            export JOBRND=${RANDOM}_cr_emiss_pert
            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_emiss_CORR_RT_MA_MPI_PERT_TEST.exe PARALLEL ${ACCOUNT} ${PERT_MODEL}
            qsub -Wblock=true job.ksh
#
            mv index.html index_${L_DATE}.html
            if [[ -e pert_chem_emis_temp && ${NL_PERT_CHEM} = "true" ]]; then
               mv pert_chem_emis_temp pert_chem_emis
            fi    
            if [[ -e pert_fire_emis_temp && ${NL_PERT_FIRE} = "true" ]]; then
               mv pert_fire_emis_temp pert_fire_emis
            fi    
            if [[ -e pert_biog_emis_temp && ${NL_PERT_BIO} = "true" ]]; then
               mv pert_biog_emis_temp pert_biog_emis
            fi
#
#########################################################################
#
# RECENTER THE PERTURBED EMISSIONS FILES
#
#########################################################################
#
            rm jobx.ksh
            touch jobx.ksh
            chmod +x jobx.ksh
            cat << EOF > jobx.ksh
#!/bin/ksh -aux
if [[ ${NL_PERT_CHEM} = "true" ]]; then
   rm -rf ens_mean_chem
   rm -rf mean_diff_chem
   rm -rf new_mean_chem_${L_DATE}
   ncea -O -n ${NUM_MEMBERS},3,1 ${CHEMI_NEW}.e001 ens_mean_chem
   ncdiff -O ens_mean_chem ${CHEMI_NEW} mean_diff_chem
   let MEM=1
   while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
      export CMEM=e\${MEM}
      if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
      if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
      ncdiff -O ${CHEMI_NEW}.\${CMEM} mean_diff_chem ${CHEMI_NEW}.\${CMEM}
      let MEM=MEM+1
   done
   ncea -O -n ${NUM_MEMBERS},3,1 ${CHEMI_NEW}.e001 new_mean_chem_${L_DATE}
fi
if [[ ${NL_PERT_FIRE} = "true" ]]; then
   rm -rf ens_mean_fire
   rm -rf mean_diff_fire
   rm -rf new_mean_fire_${L_DATE}
   ncea -O -n ${NUM_MEMBERS},3,1 ${FIRECHEMI_NEW}.e001 ens_mean_fire
   ncdiff -O ens_mean_fire ${FIRECHEMI_NEW} mean_diff_fire
   let MEM=1
   while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
      export CMEM=e\${MEM}
      if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
      if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
      ncdiff -O ${FIRECHEMI_NEW}.\${CMEM} mean_diff_fire ${FIRECHEMI_NEW}.\${CMEM}
      let MEM=MEM+1
   done
   ncea -O -n ${NUM_MEMBERS},3,1 ${FIRECHEMI_NEW}.e001 new_mean_fire_${L_DATE}
fi
if [[ ${NL_PERT_BIO} = "true" ]]; then
   rm -rf ens_mean_bio
   rm -rf mean_diff_bio
   rm -rf new_mean_bio_${L_DATE}
   ncea -O -n ${NUM_MEMBERS},3,1 ${BIOGCHEMI_NEW}.e001 ens_mean_bio
   ncdiff -O ens_mean_bio ${BIOGCHEMI_NEW} mean_diff_bio
   let MEM=1
   while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
      export CMEM=e\${MEM}
      if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
      if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
      ncdiff -O ${BIOGCHEMI_NEW}.\${CMEM} mean_diff_bio ${BIOGCHEMI_NEW}.\${CMEM}
      let MEM=MEM+1
   done
   ncea -O -n ${NUM_MEMBERS},3,1 ${BIOGCHEMI_NEW}.e001 new_mean_bio_${L_DATE}
fi
EOF
         TRANDOM=$$
         export JOBRND=${TRANDOM}_nco
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
         qsub -Wblock=true job.ksh
#
# ADVANCE TIME
         (( NL_EMISS_TIME=${NL_EMISS_TIME} + 1 ))
         export L_YY_OLD=${L_YY}
         export L_MM_OLD=${L_MM}
         export L_DD_OLD=${L_DD}
         export L_HH_OLD=${L_HH}
	 export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 -f ccyymmddhh 2>/dev/null)
      done
#
# Clean directory
#      export L_DATE=${DATE}
#      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
#      while [[ ${L_DATE} -le ${LE_DATE} ]] ; do
#         export L_YYYY=$(echo $L_DATE | cut -c1-4)
#         export L_MM=$(echo $L_DATE | cut -c5-6)
#         export L_DD=$(echo $L_DATE | cut -c7-8)
#         export L_HH=$(echo $L_DATE | cut -c9-10)
#         export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#	 rm wrfbiochemi_d01_${L_FILE_DATE} wrfchemi_d01_${L_FILE_DATE}
#	 rm wrffirechemi_d01_${L_FILE_DATE}
#         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 -f ccyymmddhhnn 2>/dev/null)
#      done
#      rm *_cr_emiss_pert* adjust_chem_* job.ksh perturb_chem_*
#      rm wrffirechemi_d01_${DATE} wrf*_frac wrf*_mean wrf*_sprd wrfinput_d*
