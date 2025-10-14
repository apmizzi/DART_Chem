#!/bin/ksh -aux
   cd ${RUN_DIR}/${DATE}/wrfchem_chem_emiss
#
# SET PARAMETERS
      export NL_EMISS_TIME=0.0
      export NL_SW_SEED=true
      export NL_SW_CORR_TM=false
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then export NL_SW_CORR_TM=true; fi
      export NL_SW_CORR_TM=false
#
# COPY ADJUSTMENT AND PERTURBATION CODE
      rm -rf adjust_chem_emiss.exe
      rm -rf perturb_chem_emiss_CORR_RT_MA.exe
      rm -rf perturb_chem_emiss_CORR_RT_MA_MPI.exe
      cp ${ADJUST_EMISS_DIR}/work/adjust_chem_emiss.exe ./.
      cp ${PERT_CHEM_EMISS_DIR}/work/perturb_chem_emiss_CORR_RT_MA_MPI.exe ./.
#
#########################################################################
#
# PERTURB THE EMISSIONS FILES
#
#########################################################################
#
# COPY CURRENT ARCHIVE EMISSIONS      
#      export L_DATE=${DATE}00
#      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} -f ccyymmddhhnn 2>/dev/null)
      export L_DATE=${DATE}
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} -f ccyymmddhh 2>/dev/null)
      if [[ ${RUN_SPECIAL_PERT_SKIP} = "true" ]]; then
         export L_DATE=${SPECIAL_PERT_DATE}
      fi
#
      while [[ ${L_DATE} -le ${LE_DATE} ]]; do
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
#
# GET COARSE GRID EMISSON FILES
         export WRFCHEMI=wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
         export WRFFIRECHEMI=wrffirechemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
         export WRFBIOCHEMI=wrfbiochemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
# COPY DATA
         cp ${WRFCHEM_CHEMI_DIR}/${WRFCHEMI} ${WRFCHEMI}
         chmod 644 ${WRFCHEMI}
#         ncatted -O -a coordinates,E_CO,c,c,"XLONG, XLAT" ${WRFCHEMI}
#         ncatted -O -a coordinates,E_NO,c,c,"XLONG, XLAT" ${WRFCHEMI}
#         ncatted -O -a coordinates,E_NO2,c,c,"XLONG, XLAT" ${WRFCHEMI}
#         ncatted -O -a coordinates,E_SO2,c,c,"XLONG, XLAT" ${WRFCHEMI}
         cp ${WRFCHEM_FIRE_DIR}/${WRFFIRECHEMI} ${WRFFIRECHEMI}
         chmod 644 ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_co,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_no,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_no2,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_so2,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
#         ncatted -O -a coordinates,ebu_in_oc,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
#         ncatted -O -a coordinates,ebu_in_bc,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
#         ncatted -O -a coordinates,ebu_in_c2h4,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
#         ncatted -O -a coordinates,ebu_in_ch2o,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
#         ncatted -O -a coordinates,ebu_in_ch3oh,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         if [[ ${L_HH} -eq 00 || ${L_HH} -eq 03 || ${L_HH} -eq 06 || ${L_HH} -eq 09 || ${L_HH} -eq 12 || ${L_HH} -eq 15 || ${L_HH} -eq 18 || ${L_HH} -eq 21 ]]; then
             cp ${WRFCHEM_BIO_DIR}/${WRFBIOCHEMI} ${WRFBIOCHEMI}
             chmod 644 ${WRFBIOCHEMI}
         fi
#
# COPY THE WRFINPUT TEMPLATE (for grid information)
         rm -rf wrfinput_d${CR_DOMAIN}.template
         cp ${WRFCHEM_TEMPLATE_DIR}/${WRFCHEM_TEMPLATE_FILE} wrfinput_d${CR_DOMAIN}.template
#
# CREATE ENSEMBLE MEMBER FILES AS TEMPLATES	 
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#
# wrfchemi
            rm -rf ${WRFCHEMI}.${CMEM}
            cp ${WRFCHEMI} ${WRFCHEMI}.${CMEM}
#
# wrffire
            rm -rf ${WRFFIRECHEMI}.${CMEM}
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}.${CMEM}
#
# wrfbio
            if [[ ${L_HH} -eq 00 || ${L_HH} -eq 03 || ${L_HH} -eq 06 || ${L_HH} -eq 09 || ${L_HH} -eq 12 || ${L_HH} -eq 15 || ${L_HH} -eq 18 || ${L_HH} -eq 21 ]]; then
               rm -rf ${WRFBIOCHEMI}.${CMEM}	    
               cp ${WRFBIOCHEMI} ${WRFBIOCHEMI}.${CMEM}
            fi
            let MEM=MEM+1
         done
#
#
# CREATE NAMELIST
         export NL_PERT_PATH_PR=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         export NL_PERT_PATH_PO=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         if [[ ${L_DATE} -eq ${DATE} || ${L_HH} -eq 00 ]]; then
            export NL_PERT_PATH_PR=${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss
            export NL_PERT_PATH_PO=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         fi
#      
         rm -rf perturb_chem_emiss_corr_nml.nl
         cat << EOF > perturb_chem_emiss_corr_nml.nl
&perturb_chem_emiss_CORR_nml
date=${L_MM}${L_DD}${L_HH},
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chem=${NNZ_CHEM},
nchem_spcs=${NNCHEM_SPC},
nfire_spcs=${NNFIRE_SPC},
nbiog_spcs=${NNBIO_SPC},
pert_path_pr='${NL_PERT_PATH_PR}',
pert_path_po='${NL_PERT_PATH_PO}',
nnum_mem=${NUM_MEMBERS},
wrfchemi='${WRFCHEMI}',
wrffirechemi='${WRFFIRECHEMI}',
wrfbiogchemi='${WRFBIOCHEMI}',
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
#
# SERIAL VERSION
            RANDOM=$$
#
# PARALLEL ON ${PERT_MODEL}
            export JOBRND=${RANDOM}_cr_emiss_pert
            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_emiss_CORR_RT_MA_MPI.exe PARALLEL ${ACCOUNT} ${PERT_MODEL}
#
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
# Recenter the perturbed ensemblesn (based on icbc - change to emiss)
            rm jobx.ksh
            touch jobx.ksh
            chmod +x jobx.ksh
            cat << EOF > jobx.ksh
#!/bin/ksh -aux
if [[ ${NL_PERT_CHEM} = "true" ]]; then
   rm -rf ens_mean_chem
   rm -rf mean_diff_chem
   rm -rf new_mean_chem_${L_DATE}
   ncea -O -n ${NUM_MEMBERS},3,1 ${WRFCHEMI}.e001 ens_mean_chem
   ncdiff -O ens_mean_chem ${WRFCHEMI} mean_diff_chem
   let MEM=1
   while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
      export CMEM=e\${MEM}
      if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
      if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
      ncdiff -O ${WRFCHEMI}.\${CMEM} mean_diff_chem ${WRFCHEMI}.\${CMEM}
      let MEM=MEM+1
   done
   ncea -O -n ${NUM_MEMBERS},3,1 ${WRFCHEMI}.e001 new_mean_chem_${L_DATE}
fi
if [[ ${NL_PERT_FIRE} = "true" ]]; then
   rm -rf ens_mean_fire
   rm -rf mean_diff_fire
   rm -rf new_mean_fire_${L_DATE}
   ncea -O -n ${NUM_MEMBERS},3,1 ${WRFFIRECHEMI}.e001 ens_mean_fire
   ncdiff -O ens_mean_fire ${WRFFIRECHEMI} mean_diff_fire
   let MEM=1
   while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
      export CMEM=e\${MEM}
      if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
      if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
      ncdiff -O ${WRFFIRECHEMI}.\${CMEM} mean_diff_fire ${WRFFIRECHEMI}.\${CMEM}
      let MEM=MEM+1
   done
   ncea -O -n ${NUM_MEMBERS},3,1 ${WRFFIRECHEMI}.e001 new_mean_fire_${L_DATE}
fi
if [[ ${NL_PERT_BIO} = "true" ]]; then
   rm -rf ens_mean_bio
   rm -rf mean_diff_bio
   rm -rf new_mean_bio_${L_DATE}
   ncea -O -n ${NUM_MEMBERS},3,1 ${WRFBIOCHEMI}.e001 ens_mean_bio
   ncdiff -O ens_mean_bio ${WRFBIOCHEMI} mean_diff_bio
   let MEM=1
   while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
      export CMEM=e\${MEM}
      if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
      if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
      ncdiff -O ${WRFBIOCHEMI}.\${CMEM} mean_diff_bio ${WRFBIOCHEMI}.\${CMEM}
      let MEM=MEM+1
   done
   ncea -O -n ${NUM_MEMBERS},3,1 ${WRFBIOCHEMI}.e001 new_mean_bio_${L_DATE}
fi
EOF
         TRANDOM=$$
         export JOBRND=${TRANDOM}_nco
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
         qsub -Wblock=true job.ksh
#	 
# GET FINE GRID EMISSON FILES FOR THIS MEMBER
#         export WRFCHEMI=wrfchemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#         export WRFFIRECHEMI=wrffirechemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#         export WRFBIOCHEMI=wrfbiochemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#         export WRFINPUT=wrfinput_d${FR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00
#   
#         export WRFINPUT_DIR=${WRFCHEM_CHEM_ICBC_DIR}
#         cp ${WRFINPUT_DIR}/${WRFINPUT} wrfinput_d${FR_DOMAIN}
#       
#         let MEM=1
#         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
#            export CMEM=e${MEM}
#            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
#            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#            if [[ ${NL_PERT_CHEM} == true ]]; then
#               cp ${WRFCHEM_CHEMI_DIR}/${WRFCHEMI} ${WRFCHEMI}.${CMEM}
#            fi
#            if [[ ${NL_PERT_FIRE} == true ]]; then
#               cp ${WRFCHEM_FIRE_DIR}/${WRFFIRECHEMI} ${WRFFIRECHEMI}.${CMEM}
#            fi
#            if [[ ${NL_PERT_BIO} == true ]]; then
#               cp ${WRFCHEM_BIO_DIR}/${WRFBIOCHEMI} ${WRFBIOCHEMI}.${CMEM}
#            fi
#            let MEM=MEM+1
#         done
#
# CREATE NAMELIST
#         rm -rf perturb_chem_emiss_CORR_nml.nl
#         cat << EOF > perturb_chem_emiss_CORR_nml.nl
#&perturb_chem_emiss_CORR_nml
#date=${L_MM}${L_DD}${L_HH},
#nx=${NNXP_FR},
#ny=${NNYP_FR},
#nz=${NNZP_FR},
#nz_chem=${NNZ_CHEM},
#nchem_spc=${NNCHEM_SPC},
#nfire_spc=${NNFIRE_SPC},
#nbio_spc=${NNBIO_SPC},
#pert_path='${RUN_DIR}',
#nnum_mem=${NUM_MEMBERS},
#wrfchemi='${WRFCHEMI}',
#wrffirechemi='${WRFFIRECHEMI}',
#wrfbiochemi='${WRFBIOCHEMI}',
#sprd_chem=${NL_SPREAD_CHEMI},
#sprd_fire=${NL_SPREAD_FIRE},
#sprd_biog=${NL_SPREAD_BIOG},
#sw_chem=${NL_PERT_CHEM},
#sw_fire=${NL_PERT_FIRE},
#sw_biog=${NL_PERT_BIO},
#/
#EOF
#            rm -rf perturb_emiss_chem_spec_nml.nl
#            cat << EOF > perturb_emiss_chem_spec_nml.nl
#
# These need to match the emissions species in the respective emissions files
#&perturb_chem_emiss_spec_nml
#ch_chem_spc=${NL_CHEM_ANTHRO_EMIS},
#ch_fire_spc=${NL_CHEM_FIRE_EMIS},
#ch_biog_spc=${NL_CHEM_BIOG_EMIS},
#/
#EOF
#
#         RANDOM=$$
#         export JOBRND=${RANDOM}_fr_emiss_pert
#         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} perturb_chem_emiss_CORR_RT_CONST.exe SERIAL ${ACCOUNT}
#         qsub -Wblock=true job.ksh
#
# ADVANCE TIME
         (( NL_EMISS_TIME=${NL_EMISS_TIME} + 1 ))
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
