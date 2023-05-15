#!/bin/ksh -aux
#########################################################################
#
# RUN WRFCHEM PERTURB EMISSIONS
#
#########################################################################
#
   if ${RUN_PERT_WRFCHEM_CHEM_EMISS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_chem_emiss ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         cd ${RUN_DIR}/${DATE}/wrfchem_chem_emiss
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_chem_emiss
      fi
#
# SET PARAMETERS
      export NL_EMISS_TIME=0.0
      export NL_SW_SEED=true
      export NL_SW_CORR_TM=false

      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then export NL_SW_CORR_TM=true; fi
#
# COPY PERTURBATION CODE
      rm -rf perturb_chem_emiss_CORR_RT_MA.exe
      rm -rf perturb_chem_emiss_CORR_RT_MA_MPI.exe
      cp ${PERT_CHEM_EMISS_DIR}/work/perturb_chem_emiss_CORR_RT_MA.exe ./.
      cp ${PERT_CHEM_EMISS_DIR}/work/perturb_chem_emiss_CORR_RT_MA_MPI.exe ./.
#
      export L_DATE=${DATE}
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${L_DATE} -le ${LE_DATE} ]] ; do
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
#
         export NL_PERT_PATH_PR=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         export NL_PERT_PATH_PO=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         if [[ ${L_DATE} -eq ${DATE} || ${L_HH} -eq 00 ]]; then
            export NL_PERT_PATH_PR=${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss
            export NL_PERT_PATH_PO=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         fi
#
# GET COARSE GRID EMISSON FILES
         export WRFCHEMI=wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
         export WRFFIRECHEMI=wrffirechemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
         export WRFBIOCHEMI=wrfbiochemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
# COPY DATA
         cp ${WRFCHEM_CHEMI_DIR}/${WRFCHEMI} ${WRFCHEMI}


# HSU
         if [[ ${L_DATE} -eq  ${DATE} ]];  then
             export WRFCHEMI_FIX=wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
            cp ${WRFCHEMI_FIX} wrfchemi_d01_fix
         fi

         chmod 644 ${WRFCHEMI}
         ncatted -O -a coordinates,E_CO,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_NO,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_NO2,c,c,"XLONG, XLAT" ${WRFCHEMI}
#         ncatted -O -a coordinates,E_OC,c,c,"XLONG, XLAT" ${WRFCHEMI}
#         ncatted -O -a coordinates,E_BC,c,c,"XLONG, XLAT" ${WRFCHEMI}
#         ncatted -O -a coordinates,E_PM_10,c,c,"XLONG, XLAT" ${WRFCHEMI}
#         ncatted -O -a coordinates,E_PM_25,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_SO2,c,c,"XLONG, XLAT" ${WRFCHEMI}
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
         if [[ ${L_HH} -eq 00 || ${L_HH} -eq 06 || ${L_HH} -eq 12 || ${L_HH} -eq 18 ]]; then
            cp ${WRFCHEM_BIO_DIR}/${WRFBIOCHEMI} ${WRFBIOCHEMI}
            chmod 644 ${WRFBIOCHEMI}
         fi

# HSU

         if [[  ${DATE} -eq ${FIRST_EMISS_INV_DATE} && ${ADD_EMISS} = "true" ]]; then
             export NL_WRFCHEMI_ADJ=${WRFCHEMI}_adjust
             cp ${WRFCHEMI} ${NL_WRFCHEMI_ADJ}
         fi

#
# COPY ENSEMBLE MEAN EMISSONS ADJUSTMENT FROM PREVIOUS CYCLE
         if [[ ${DATE} -gt  ${FIRST_EMISS_INV_DATE} && ${ADD_EMISS} = "true" ]]; then
            rm -rf wrfchemi_d${CR_DOMAIN}_prior_mean
            rm -rf wrfchemi_d${CR_DOMAIN}_post_mean
            rm -rf wrffirechemi_d${CR_DOMAIN}_prior_mean
            rm -rf wrffirechemi_d${CR_DOMAIN}_post_mean
#            if ${NL_PERT_CHEM}; then
               cp ${RUN_DIR}/${PAST_DATE}/dart_filter/wrfchemi_d${CR_DOMAIN}_prior_mean ./
               cp ${RUN_DIR}/${PAST_DATE}/dart_filter/wrfchemi_d${CR_DOMAIN}_post_mean ./
               cp ${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss/wrfchemi_adjust ./
               mv wrfchemi_adjust wrfchemi_adjust_for_this
#            fi
#            if ${NL_PERT_FIRE}; then
               cp ${RUN_DIR}/${PAST_DATE}/dart_filter/wrffirechemi_d${CR_DOMAIN}_prior_mean ./
               cp ${RUN_DIR}/${PAST_DATE}/dart_filter/wrffirechemi_d${CR_DOMAIN}_post_mean ./
#            fi
         fi
#

# Step1: PROPOGATE emissions adjustment from last cycle by applying *_adjust files
###############################################################################################
# wrfchemi
         if [[ ${DATE} -gt  ${FIRST_EMISS_INV_DATE} && ${ADD_EMISS} = "true" ]]; then
#            rm -rf ${WRFCHEMI}.${CMEM}
            cp ${WRFCHEMI} ${WRFCHEMI}_old
            cp ${WRFCHEMI} ${WRFCHEMI}_new
#
# wrffire
#            rm -rf ${WRFFIRECHEMI}.${CMEM}
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_old
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_new
#
# Set up namelist input file for adding the prior emissions adjustments
               export NL_WRFCHEMI_PRIOR=wrfchemi_d01_fix
               export NL_WRFCHEMI_POST=wrfchemi_adjust_for_this
               export NL_WRFCHEMI_OLD=${WRFCHEMI}
               export NL_WRFCHEMI_NEW=${WRFCHEMI}_new

#
               export NL_WRFFIRECHEMI_PRIOR=${WRFFIRECHEMI}
               export NL_WRFFIRECHEMI_POST=${WRFFIRECHEMI}
               export NL_WRFFIRECHEMI_OLD=${WRFFIRECHEMI}
               export NL_WRFFIRECHEMI_NEW=${WRFFIRECHEMI}_new


               cp ${ADJUST_EMISS_DIR}/work/adjust_chem_emiss_noaa.exe ./.
               rm -rf adjust_chem_emiss.nml
               cat <<  EOF > adjust_chem_emiss.nml
&adjust_chem_emiss
fac=${EMISS_DAMP_CYCLE},
facc=${EMISS_DAMP_INTRA_CYCLE},
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chemi=${NZ_CHEMI},
nz_firechemi=${NZ_FIRECHEMI},
nchemi_emiss=${NCHEMI_EMISS},
nfirechemi_emiss=${NFIRECHEMI_EMISS},
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
               ./adjust_chem_emiss_noaa.exe > index_adjust_chem_emiss
#
               cp ${NL_WRFCHEMI_NEW} ${NL_WRFCHEMI_OLD}
               cp ${NL_WRFFIRECHEMI_NEW} ${NL_WRFFIRECHEMI_OLD}
               rm ${NL_WRFFIRECHEMI_NEW}
               rm ${NL_WRFCHEMI_NEW}

       fi


#  Step 2:
# Adjust emissions based on FILTER output from last cycle (*_post_mean, *_prior_mean)
##################################################################################################
# INCLUDE ENSEMBLE MEAN EMISSIONS ADJUSTMENT FROM PREVIOUS CYCLE

           if [[ ${DATE} -gt  ${FIRST_EMISS_INV_DATE} && ${ADD_EMISS} = "true" ]]; then
# HSU
               cp ${WRFCHEMI} ${WRFCHEMI}_old
               cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_old
               cp ${WRFCHEMI}  ${WRFCHEMI}_new
               cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_new
#
# Set up namelist input file for adding the prior emissions adjustments
               export NL_WRFCHEMI_PRIOR=wrfchemi_d${CR_DOMAIN}_prior_mean
               export NL_WRFCHEMI_POST=wrfchemi_d${CR_DOMAIN}_post_mean
               export NL_WRFCHEMI_OLD=${WRFCHEMI}
               export NL_WRFCHEMI_NEW=${WRFCHEMI}_new
               export NL_WRFCHEMI_ORI=${WRFCHEMI}_old

#
               export NL_WRFFIRECHEMI_PRIOR=wrffirechemi_d${CR_DOMAIN}_prior_mean
               export NL_WRFFIRECHEMI_POST=wrffirechemi_d${CR_DOMAIN}_post_mean
               export NL_WRFFIRECHEMI_OLD=${WRFFIRECHEMI}
               export NL_WRFFIRECHEMI_NEW=${WRFFIRECHEMI}_new
               export NL_WRFFIRECHEMI_ORI=${WRFFIRECHEMI}_old


               cp ${ADJUST_EMISS_DIR}/work/adjust_chem_emiss_noaa.exe ./.
               rm -rf adjust_chem_emiss.nml
               cat <<  EOF > adjust_chem_emiss.nml
&adjust_chem_emiss
fac=${EMISS_DAMP_CYCLE},
facc=${EMISS_DAMP_INTRA_CYCLE},
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chemi=${NZ_CHEMI},
nz_firechemi=${NZ_FIRECHEMI},
nchemi_emiss=${NCHEMI_EMISS},
nfirechemi_emiss=${NFIRECHEMI_EMISS},
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
               ./adjust_chem_emiss_noaa.exe > index_adjust_chem_emiss
#
               cp ${NL_WRFCHEMI_NEW} ${NL_WRFCHEMI_OLD}
               cp ${NL_WRFFIRECHEMI_NEW} ${NL_WRFFIRECHEMI_OLD}
               rm ${NL_WRFFIRECHEMI_NEW}
               rm ${NL_WRFCHEMI_NEW}
               rm ${NL_WRFFIRECHEMI_ORI}
#               rm ${NL_WRFCHEMI_ORI}
            fi

# HSU copy adjusted wrfchemi file
         if [[ ${DATE} -gt  ${FIRST_EMISS_INV_DATE} && ${ADD_EMISS} = "true" ]]; then
             export NL_WRFCHEMI_ADJ=${WRFCHEMI}_adjust
             cp ${NL_WRFCHEMI_OLD}  ${NL_WRFCHEMI_ADJ}
         fi

#####################################################################################################
# COPY EMISSIONS FOR PERTURBATION

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
         rm -rf perturb_chem_emiss_corr_nml.nl
         cat << EOF > perturb_chem_emiss_corr_nml.nl
&perturb_chem_emiss_CORR_nml
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
year=${YYYY}
month=${MM}
day=${DD}
hour=${L_HH}
/
EOF
         rm -rf perturb_emiss_chem_spec_nml.nl
         cat << EOF > perturb_emiss_chem_spec_nml.nl
#
# These need to match the emissions species in the respective emissions files
&perturb_chem_emiss_spec_nml
ch_chem_spc='E_ACT','E_ALD','E_CH4','E_CO','E_CO2','E_CSL','E_ECI','E_ECJ','E_EOH','E_ETEG','E_ETH','E_GLY','E_GLYC','E_HC3','E_HC5','E_HC8','E_HCHO','E_HONO','E_IPOH','E_ISO','E_KET','E_MACR','E_MGLY','E_MOH','E_NH3','E_NO','E_NO2','E_NO3I','E_NO3J','E_OL2','E_OLI','E_OLT','E_ORA2','E_ORGI','E_ORGJ','E_PM10','E_PM25I','E_PM25J','E_PROG','E_SO2','E_SO4I','E_SO4J','E_TERP','E_TOL','E_UNID','E_XYL',
ch_fire_spc='ebu_in_co','ebu_in_no','ebu_in_so2','ebu_in_nh3','ebu_in_no2',
ch_biog_spc='MSEBIO_ISOP',
/
EOF
#ch_chem_spc='E_CO','E_NO','E_NO2','E_BIGALK','E_BIGENE','E_C2H4','E_C2H5OH','E_C2H6','E_C3H6','E_C3H8','E_CH2O','E_CH3CHO','E_CH3COCH3','E_CH3OH','E_MEK','E_SO2','E_TOLUENE','E_NH3','E_ISOP','E_C10H16','E_sulf','E_CO_A','E_CO_BB','E_CO02','E_CO03','E_XNO','E_XNO2','E_BALD','E_C2H2','E_BENZENE','E_XYLENE','E_CRES','E_HONO','E_PM25I','E_PM25J','E_PM_10','E_ECI','E_ECJ','E_ORGI','E_ORGJ','E_SO4I','E_SO4J','E_NO3I','E_NO3J','E_NH4I','E_NH4J','E_PM_25','E_OC','E_BC',
#ch_fire_spc='ebu_in_co','ebu_in_no','ebu_in_so2','ebu_in_bigalk','ebu_in_bigene','ebu_in_c2h4','ebu_in_c2h5oh','ebu_in_c2h6','ebu_in_c3h8','ebu_in_c3h6','ebu_in_ch2o','ebu_in_ch3cho','ebu_in_ch3coch3','ebu_in_ch3oh','ebu_in_mek','ebu_in_toluene','ebu_in_nh3','ebu_in_no2','ebu_in_open','ebu_in_c10h16','ebu_in_ch3cooh','ebu_in_cres','ebu_in_glyald','ebu_in_mgly','ebu_in_gly','ebu_in_acetol','ebu_in_isop','ebu_in_macr','ebu_in_mvk','ebu_in_oc','ebu_in_bc',
#ch_biog_spc='MSEBIO_ISOP',


#
# SERIAL VERSION
         RANDOM=$$
#         export JOBRND=${RANDOM}_cr_emiss_pert
#         ${HYBRID_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} perturb_chem_emiss_CORR_RT_MA.exe SERIAL ${ACCOUNT}
#
# PARALLEL VERSION
         export JOBRND=${RANDOM}_cr_emiss_pert
         ${HYBRID_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_emiss_CORR_RT_MA_MPI.exe PARALLEL ${ACCOUNT}
#
         sbatch -W job.ksh
#
# ADVANCE TIME
         (( NL_EMISS_TIME=${NL_EMISS_TIME} + 1 ))
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
      done

# change name
# HSU change adjust file name
         if [[ ${DATE} -ge  ${FIRST_EMISS_INV_DATE} && ${ADD_EMISS} = "true" ]]; then
             cp ${NL_WRFCHEMI_ADJ} wrfchemi_adjust
         fi

   fi
#