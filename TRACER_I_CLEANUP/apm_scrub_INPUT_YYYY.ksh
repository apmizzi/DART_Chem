#!/bin/ksh -aux
#
# THIS SCRIPT IS RUN BY 'run_traceri_scrub_thin_all.ksh'
#
#   export DATE_YYYY_STR=2022
#   export DATE_YYYY_END=2022
#   export MMDDHH_STR=040218
#   export MMDDHH_END=040221
#
   export RUN_SCRUB_AIRNOW_CO=true
   export RUN_SCRUB_AIRNOW_O3=true
   export RUN_SCRUB_AIRNOW_NO2=true
   export RUN_SCRUB_AIRNOW_SO2=true
   export RUN_SCRUB_GOME2A_NO2=true
   export RUN_SCRUB_MLS_O3=true
   export RUN_SCRUB_MLS_HNO3=true
   export RUN_SCRUB_MOPITT_CO=true
   export RUN_SCRUB_OMI_O3=true
   export RUN_SCRUB_OMI_NO2=true
   export RUN_SCRUB_OMI_SO2=true
   export RUN_SCRUB_PREPBUFR=true
   export RUN_SCRUB_SCIAM_NO2=true
   export RUN_SCRUB_TES_CO=true
   export RUN_SCRUB_TES_O3=true
   export RUN_SCRUB_UNGRIB=true
#
   export RUN_SCRUB_NOAA=true
   export RUN_SCRUB_METGRID=true
   export RUN_SCRUB_REAL=true
   export RUN_SCRUB_WRFCHEMI=true
   export RUN_SCRUB_WRFFIRE=true
   export RUN_SCRUB_WRFBIO=true
   export RUN_SCRUB_WRFCHEM_ICS=true
   export RUN_SCRUB_WRFCHEM_BCS=true
   export RUN_SCRUB_WRFCHEM_ICBCS=true
   export RUN_SCRUB_WRFCHEM_EMIS=true
#  
#   export WRFDA_VER=WRFDAv4.3.2_dmpar
#   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/${WRFDA_VER}/var/build
#
#   export OUTPUT_DIR=/nobackupp28/amizzi/OUTPUT_DATA
   export EXP_DIR_PRE=${OUTPUT_DIR}/INPUT_
   export EXP_DIR_SUF=_NOAA_EMISADJ_30MEMS
#
#   export DATE_DIR_INC=3
#   export DATE_YYYY_INC=1
#   export NUM_MEMBERS=30
#
   export DATE_YYYY=${DATE_YYYY_STR}
   export MMDDHH=${MMDDHH_STR}
#
   while [[ ${DATE_YYYY} -le ${DATE_YYYY_END} ]]; do
      export TARGET_DIR=${EXP_DIR_PRE}${DATE_YYYY}${EXP_DIR_SUF}
      export DATE_DIR_STR=${DATE_YYYY}${MMDDHH_STR}
      export DATE_DIR_END=${DATE_YYYY}${MMDDHH_END}
      export DATE_DIR=${DATE_DIR_STR}
      echo "APM delete ${TARGET_DIR}"
      while [[ ${DATE_DIR} -le ${DATE_DIR_END} ]]; do
#
# Go to TARGET_DIR for scrubbing
         cd ${TARGET_DIR}/${DATE_DIR}
#
# AIRNOW CO
         if [[ ${RUN_SCRUB_AIRNOW_CO} = "true" ]]; then
            rm -rf airnow_co_obs
         fi
#
# AIRNOW O3
         if [[ ${RUN_SCRUB_AIRNOW_O3} = "true" ]]; then
            rm -rf airnow_o3_obs
         fi
#
# AIRNOW NO2
         if [[ ${RUN_SCRUB_AIRNOW_NO2} = "true" ]]; then
            rm -rf airnow_no2_obs
         fi
#
# AIRNOW SO2
         if [[ ${RUN_SCRUB_AIRNOW_SO2} = "true" ]]; then
            rm -rf airnow_so2_obs
         fi
#
# GOME2A NO2
         if [[ ${RUN_SCRUB_GOME2A_NO2} = "true" ]]; then
            rm -rf gome2a_no2_trop_col_obs
         fi
#
# MLS O3
         if [[ ${RUN_SCRUB_MLS_O3} = "true" ]]; then
            rm -rf mls_o3_profile_obs
         fi
#
# MLS HNO3
         if [[ ${RUN_SCRUB_MLS_HNO3} = "true" ]]; then
            rm -rf mls_hno3_profile_obs
         fi
#
# MOPITT CO
         if [[ ${RUN_SCRUB_MOPITT_CO} = "true" ]]; then
            rm -rf mopitt_co_profile_obs
         fi
#
# OMI O3
         if [[ ${RUN_SCRUB_OMI_O3} = "true" ]]; then
            rm -rf omi_o3_profile_obs
         fi
#
# OMI NO2
         if [[ ${RUN_SCRUB_OMI_NO2} = "true" ]]; then
            rm -rf omi_no2_domino_trop_col_obs
         fi
#
# OMI SO2
         if [[ ${RUN_SCRUB_OMI_SO2} = "true" ]]; then
            rm -rf omi_so2_pbl_col_obs
         fi
#
# PREPBUF
         if [[ ${RUN_SCRUB_PREPBUFR} = "true" ]]; then
            rm -rf prepbufr_met_obs
         fi
#
# SCIAM NO2
         if [[ ${RUN_SCRUB_SCIAM_NO2} = "true" ]]; then
            rm -rf sciam_no2_trop_col_obs
         fi
#
# TES CO
         if [[ ${RUN_SCRUB_TES_CO} = "true" ]]; then
            rm -rf tes_co_profile_obs
         fi
#
# TES O3
         if [[ ${RUN_SCRUB_TES_O3} = "true" ]]; then
            rm -rf tes_o3_profile_obs
         fi
#
# UNGRIB
         if [[ ${RUN_SCRUB_UNGRIB} = "true" ]]; then
            rm -rf ungrib
         fi
#
# NOAA
         if [[ ${RUN_SCRUB_NOAA} = "true" ]]; then
	    rm -rf NOAA/combine_obs/index* 
            rm -rf NOAA/index_create*
	    rm -rf NOAA/preprocess_obs/*_nco.o*
	    rm -rf NOAA/preprocess_obs/*_prepr.o*
	    rm -rf NOAA/preprocess_obs/dart_log*
	    rm -rf NOAA/preprocess_obs/index*
	    rm -rf NOAA/preprocess_obs/input.nml
	    rm -rf NOAA/preprocess_obs/job*
	    rm -rf NOAA/preprocess_obs/obs_seq.old
	    rm -rf NOAA/preprocess_obs/SUCCESS
	    rm -rf NOAA/preprocess_obs/wrfbiochemi*
	    rm -rf NOAA/preprocess_obs/wrfchemi*
	    rm -rf NOAA/preprocess_obs/wrf_dart_obs_*
	    rm -rf NOAA/preprocess_obs/wrffirechemi*
	    rm -rf NOAA/preprocess_obs/wrfinput*
         fi
#
# METGRID
         if [[ ${RUN_SCRUB_METGRID} = "true" ]]; then
            rm -rf metgrid/index*
         fi
#
# REAL
         if [[ ${RUN_SCRUB_REAL} = "true" ]]; then
            rm -rf real/*_real.o*
            rm -rf real/hist_io_flds_*
            rm -rf real/index*
            rm -rf real/job*
	    rm -rf real/met_em*
	    rm -rf real/namelist*
	    rm -rf real/real*
	    rm -rf real/rsl.*
	    rm -rf real/SUCCESS
         fi
#
# WRFCHEMI
         if [[ ${RUN_SCRUB_WRFCHEMI} = "true" ]]; then
            rm -rf wrfchem_chemi/index*
         fi
#
# WRFFIRECHEMI
         if [[ ${RUN_SCRUB_WRFFIRE} = "true" ]]; then
            rm -rf wrfchem_fire/*_fire.o*
            rm -rf wrfchem_fire/*_fire.o*
            rm -rf wrfchem_fire/*_fire_emis*
            rm -rf wrfchem_fire/fire_emis*
            rm -rf wrfchem_fire/GLOBAL_FINN*
            rm -rf wrfchem_fire/grass_from_*
            rm -rf wrfchem_fire/index*
            rm -rf wrfchem_fire/job*
            rm -rf wrfchem_fire/shrub_from_*
            rm -rf wrfchem_fire/SUCCESS
            rm -rf wrfchem_fire/tempfor_from_*
            rm -rf wrfchem_fire/tropfor_from_*
            rm -rf wrfchem_fire/wrfinput_d01*
         fi
#
# WRFBIOCHEMI
         if [[ ${RUN_SCRUB_WRFBIO} = "true" ]]; then
            rm -rf wrfchem_bio/*_bio.o*
            rm -rf wrfchem_bio/btr*
            rm -rf wrfchem_bio/DSW*
            rm -rf wrfchem_bio/hrb*
            rm -rf wrfchem_bio/index*
            rm -rf wrfchem_bio/isoall*
            rm -rf wrfchem_bio/job*
            rm -rf wrfchem_bio/laiv*
            rm -rf wrfchem_bio/megan*
            rm -rf wrfchem_bio/ntr*
            rm -rf wrfchem_bio/shr*
            rm -rf wrfchem_bio/SUCCESS
            rm -rf wrfchem_bio/TAS*
            rm -rf wrfchem_bio/wrfinput_d01*
         fi
#
# WRFCHEM ICs
         if [[ ${RUN_SCRUB_WRFCHEM_ICS} = "true" ]]; then
            rm -rf wrfchem_met_ic/*_nco.o*
            rm -rf wrfchem_met_ic/*_wrfda_cr.o*
            rm -rf wrfchem_met_ic/index*
            rm -rf wrfchem_met_ic/job*
            rm -rf wrfchem_met_ic/SUCCESS
            rm -rf wrfchem_met_ic/wrfda_cr_*
         fi
#
# WRFCHEM BCs
         if [[ ${RUN_SCRUB_WRFCHEM_BCS} = "true" ]]; then
            rm -rf wrfchem_met_bc/*_nco.o*
            rm -rf wrfchem_met_bc/*_pert_bc.o*
            rm -rf wrfchem_met_bc/dart_log*
            rm -rf wrfchem_met_bc/index*
            rm -rf wrfchem_met_bc/input*
            rm -rf wrfchem_met_bc/job*
            rm -rf wrfchem_met_bc/pert_wrf_bc**
            rm -rf wrfchem_met_bc/SUCCESS
            rm -rf wrfchem_met_bc/wrfinput_next_*
            rm -rf wrfchem_met_bc/wrfinput_this_*
         fi
#
# WRFCHEM CHEM ICBCs
         if [[ ${RUN_SCRUB_WRFCHEM_ICBCS} = "true" ]]; then
            rm -rf wrfchem_chem_icbc/*_nco.o*
            rm -rf wrfchem_chem_icbc/*_cr_icbc_pert.o*
            rm -rf wrfchem_chem_icbc/*_mozbc_bc.o*
            rm -rf wrfchem_chem_icbc/*_mozbc_ic.o*
            rm -rf wrfchem_chem_icbc/index_*
            rm -rf wrfchem_chem_icbc/job*
	    rm -rf wrfchem_chem_icbc/met_em*
            rm -rf wrfchem_chem_icbc/mozbc.exe*
            rm -rf wrfchem_chem_icbc/perturb_chem_icbc*
            rm -rf wrfchem_chem_icbc/SUCCESS
            rm -rf wrfchem_chem_icbc/wrfchem.namelist.input
            rm -rf wrfchem_chem_icbc/*0_mean
            rm -rf wrfchem_chem_icbc/*0_vari*
         fi
#
# WRFCHEM EMIS
         if [[ ${RUN_SCRUB_WRFCHEM_EMIS} = "true" ]]; then
            rm -rf wrfchem_chem_emiss/adjust_chem_emiss*
            rm -rf wrfchem_chem_emiss/*_cr_emiss_pert.o*
            rm -rf wrfchem_chem_emiss/index_*
            rm -rf wrfchem_chem_emiss/job*
            rm -rf wrfchem_chem_emiss/perturb_chem_*            
            rm -rf wrfchem_chem_emiss/perturb_emiss_*            
            rm -rf wrfchem_chem_emiss/SUCCESS
            rm -rf wrfchem_chem_emiss/wrfinput_d01.template
         fi
         export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
      done
      let DATE_YYYY=${DATE_YYYY}+${DATE_YYYY_INC}
   done
