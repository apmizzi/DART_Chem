#!/bin/ksh -aux
   cd ${RUN_DIR}/${DATE}/wrfchem_chem_emiss
#
# SET PARAMETERS
      export NL_EMISS_TIME=0
      export NL_SW_SEED=true
      export NL_SW_CORR_TM=false
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then export NL_SW_CORR_TM=true; fi
#
# COPY ADJUSTMENT AND PERTURBATION CODE
      rm -rf adjust_chem_emiss.exe
      rm -rf perturb_chem_emiss_CORR_RT_MA.exe
      rm -rf perturb_chem_emiss_CORR_RT_MA_MPI.exe
      cp ${ADJUST_EMISS_DIR}/work/adjust_chem_emiss.exe ./.
      cp ${PERT_CHEM_EMISS_DIR}/work/perturb_chem_emiss_CORR_RT_MA.exe ./.
      cp ${PERT_CHEM_EMISS_DIR}/work/perturb_chem_emiss_CORR_RT_MA_MPI.exe ./.
#
#########################################################################
#
# PERTURB THE EMISSIONS FILES
#
#########################################################################
#
# COPY CURRENT ARCHIVE EMISSIONS      
      export L_DATE=${DATE}
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${L_DATE} -le ${LE_DATE} ]] ; do
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
         ncatted -O -a coordinates,E_CO,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_NO,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_NO2,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_OC,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_BC,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_PM_10,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_PM_25,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_SO2,c,c,"XLONG, XLAT" ${WRFCHEMI}
         cp ${WRFCHEM_FIRE_DIR}/${WRFFIRECHEMI} ${WRFFIRECHEMI}
         chmod 644 ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_co,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_no,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_no2,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_so2,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_oc,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_bc,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_c2h4,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_ch2o,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_ch3oh,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         if [[ ${L_HH} -eq 00 || ${L_HH} -eq 06 || ${L_HH} -eq 12 || ${L_HH} -eq 18 ]]; then
            cp ${WRFCHEM_BIO_DIR}/${WRFBIOCHEMI} ${WRFBIOCHEMI}
            chmod 644 ${WRFBIOCHEMI}
         fi
#
# CREATE ENSEMBLE MEMBER FILES AS TEMPLATES	 
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#
# copy ensemble members 
            export WRFINPUT=wrfinput_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00.${CMEM}
            rm -rf wrfinput_d${CR_DOMAIN}.${CMEM}
            cp ${WRFCHEM_CHEM_ICBC_DIR}/${WRFINPUT} wrfinput_d${CR_DOMAIN}.${CMEM}
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
            if [[ ${L_HH} -eq 00 || ${L_HH} -eq 06 || ${L_HH} -eq 12 || ${L_HH} -eq 18 ]]; then
               cp ${WRFBIOCHEMI} ${WRFBIOCHEMI}.${CMEM}
            fi
	    let MEM=MEM+1
         done
#
# CREATE ENSEMBLE STATS FILES AS TEMPLATES	 
         if [[ ${NL_PERT_CHEM} == true ]]; then 
            cp ${WRFCHEMI} ${WRFCHEMI}_mean
            cp ${WRFCHEMI} ${WRFCHEMI}_sprd
            cp ${WRFCHEMI} ${WRFCHEMI}_frac
         fi
         if [[ ${NL_PERT_FIRE} == true ]]; then 
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_mean
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_sprd
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_frac
         fi
         if [[ ${NL_PERT_BIO} == true ]]; then 
            if [[ ${L_HH} -eq 00 || ${L_HH} -eq 06 || ${L_HH} -eq 12 || ${L_HH} -eq 18 ]]; then
               cp ${WRFBIOCHEMI} ${WRFBIOCHEMI}_mean
               cp ${WRFBIOCHEMI} ${WRFBIOCHEMI}_sprd
               cp ${WRFBIOCHEMI} ${WRFBIOCHEMI}_frac
            fi
         fi
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
#         export JOBRND=${RANDOM}_cr_emiss_pert
#         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} perturb_chem_emiss_CORR_RT_MA.exe SERIAL ${ACCOUNT}
#
# PARALLEL VERSION
#         export JOBRND=${RANDOM}_cr_emiss_pert
#         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_emiss_CORR_RT_MA_MPI.exe PARALLEL ${ACCOUNT}
#
#
# PARALLEL ON HASWELL
         export JOBRND=${RANDOM}_cr_emiss_pert
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_has.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_emiss_CORR_RT_MA_MPI.exe PARALLEL ${ACCOUNT}
#
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
#         rm -rf perturb_emiss_chem_spec_nml.nl
#         cat << EOF > perturb_emiss_chem_spec_nml.nl
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
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
      done
#
#########################################################################
#
# PROPOGATE HISTORICAL AND DART EMISSIONS ADJUSTMENT FROM PREVIOIS CYCLE
#
#########################################################################
#
# COPY FILES FOR HISTORICAL EMISSIONS PROPAGATION
      if [[ ${DATE} -gt  ${FIRST_EMISS_INV_DATE} && ${L_ADD_EMISS} = "true" ]]; then
         TRANDOM=$$
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
            rm -rf wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            rm -rf wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            rm -rf wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            rm -rf wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            cp ${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss/wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_old ./wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            cp ${RUN_DIR}/${PAST_DATE}/dart_filter/wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM} ./wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            cp ${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss/wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_old ./wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            cp ${RUN_DIR}/${PAST_DATE}/dart_filter/wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM} ./wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
#
            export L_DATE=${DATE}
            export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
            while [[ ${L_DATE} -le ${LE_DATE} ]] ; do
               export L_YYYY=$(echo $L_DATE | cut -c1-4)
               export L_MM=$(echo $L_DATE | cut -c5-6)
               export L_DD=$(echo $L_DATE | cut -c7-8)
               export L_HH=$(echo $L_DATE | cut -c9-10)
	       export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
	       cp wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               cp wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               cp wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
               cp wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
#
# Set up namelist input file for adding the prior emissions adjustments
               export NL_WRFCHEMI_PRIOR=wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
               export NL_WRFCHEMI_POST=wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
               export NL_WRFCHEMI_OLD=wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               export NL_WRFCHEMI_NEW=wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
#
               export NL_WRFFIRECHEMI_PRIOR=wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
               export NL_WRFFIRECHEMI_POST=wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
               export NL_WRFFIRECHEMI_OLD=wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               export NL_WRFFIRECHEMI_NEW=wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
#
	       rm -rf adjust_chem_emiss_dims.nml
               cat <<  EOF > adjust_chem_emiss_dims.nml
&adjust_chem_emiss_dims
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chemi=${NZ_CHEMI},
nz_firechemi=${NZ_FIRECHEMI},
nchemi_emiss=${NCHEMI_EMISS},
nfirechemi_emiss=${NFIRECHEMI_EMISS},
/
EOF
	       rm -rf adjust_chem_emiss.nml
               cat <<  EOF > adjust_chem_emiss.nml
&adjust_chem_emiss
chemi_spcs=${WRFCHEMI_DARTVARS},
firechemi_spcs=${WRFFIRECHEMI_DARTVARS},
fac=${EMISS_DAMP_CYCLE},
facc=${EMISS_DAMP_INTRA_CYCLE},
wrfchemi_prior='${NL_WRFCHEMI_PRIOR}',
wrfchemi_post='${NL_WRFCHEMI_POST}',
wrfchemi_old='${NL_WRFCHEMI_OLD}',
wrfchemi_new='${NL_WRFCHEMI_NEW}',
wrffirechemi_prior='${NL_WRFFIRECHEMI_PRIOR}',
wrffirechemi_post='${NL_WRFFIRECHEMI_POST}',
wrffirechemi_old='${NL_WRFFIRECHEMI_OLD}',
wrffirechemi_new='${NL_WRFFIRECHEMI_NEW}'
/
EOF
               ./adjust_chem_emiss.exe > index_adjust_chem_emiss
#               export JOBRND=${TRANDOM}_adj
#               ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} adjust_chem_emiss.exe SERIAL ${ACCOUNT}
#               qsub job.ksh
#
               export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
            done
            let MEM=MEM+1
         done
#         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
#
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
            rm -rf wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            rm -rf wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            rm -rf wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            rm -rf wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            export L_DATE=${DATE}
            export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
            while [[ ${L_DATE} -le ${LE_DATE} ]] ; do
               export L_YYYY=$(echo $L_DATE | cut -c1-4)
               export L_MM=$(echo $L_DATE | cut -c5-6)
               export L_DD=$(echo $L_DATE | cut -c7-8)
               export L_HH=$(echo $L_DATE | cut -c9-10)
	       export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
	       rm -rf wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}
	       rm -rf wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}
               cp wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}
               cp wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}
#               rm -rf wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
#               rm -rf wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               rm -rf wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
               rm -rf wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
#
               export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
            done
            let MEM=MEM+1
         done

      fi
#
# Clean directory
      export L_DATE=${DATE}
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${L_DATE} -le ${LE_DATE} ]] ; do
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
         export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
	 rm wrfbiochemi_d01_${L_FILE_DATE} wrfchemi_d01_${L_FILE_DATE}
	 rm wrffirechemi_d01_${L_FILE_DATE}
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
      done
#      rm *_cr_emiss_pert* adjust_chem_* job.ksh perturb_chem_*
#      rm wrffirechemi_d01_${DATE} wrf*_frac wrf*_mean wrf*_sprd wrfinput_d*
