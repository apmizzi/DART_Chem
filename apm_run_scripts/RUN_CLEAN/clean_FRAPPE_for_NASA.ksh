#!/bin/ksh -aeux
#
export NUM_MEMBERS=10
export WRFDA_VERSION=WRFDAv3.9.1.1_dmpar
export BUILD_DIR=/nobackupp11/amizzi/TRUNK/${WRFDA_VERSION}/var/build
#
export EXP=real_FRAPPE_CONTROL_NASA
export EXP=real_FRAPPE_ALLCHEM_RELAX_NASA
export EXP=real_FRAPPE_ALLCHEM_EMISS_ADJ_NASA
#
export SOURCE_PATH=/nobackupp11/amizzi/OUTPUT_DATA/${EXP}
#
export DATE_STR=2014071400
export DATE_END=2014071900

export CYCLE_PERIOD=6
#
# Copy file into ${L_DATE} subdirectory
export L_DATE=${DATE_STR}
#
# KEEP PARTS OF THE FOLLOWING
# wrfchem_chem_icbc
# wrfchem_chem_emiss
# dart_filter
# ensemble_mean_input
# ensemble_mean_output
# ensmean_cycle_fr
# wrfchem_cycle_cr
#
while [[ ${L_DATE} -le ${DATE_END} ]] ; do
   if [[ -e  ${SOURCE_PATH}/geogrid ]]; then
      cd ${SOURCE_PATH}/geogrid
      rm -rf *geogrid.log*
      rm -rf geogrid.*
      rm -rf index.html
      rm -rf job.ksh
      rm -rf SUCCESS
      cd ${SOURCE_PATH}/${L_DATE}
   fi   
   rm -rf ungrib
#   rm -rf metgrid
   if [[ -e  ${SOURCE_PATH}/${L_DATE}/metgrid ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/metgrid
      rm -rf *metgrid.*
      rm -rf FILE:*
      rm -rf geo_em.d*
      rm -rf index*
      rm -rf job*
      rm -rf metgrid.exe*
      rm -rf METGRID.TBL*
      rm -rf namelist.wps*
      rm -rf SUCCESS
      cd ${SOURCE_PATH}/${L_DATE}
   fi
#   rm -rf real
   if [[ -e  ${SOURCE_PATH}/${L_DATE}/real ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/real
      rm -rf *real.*
      rm -rf hist_io*
      rm -rf index*
      rm -rf job*
      rm -rf met_em.d*
      rm -rf namelist*
      rm -rf real*
      rm -rf rsl.*
      rm -rf SUCCESS
      cd ${SOURCE_PATH}/${L_DATE}
   fi
   rm -rf wrfchem_met_ic
   rm -rf wrfchem_met_bc
   rm -rf exo_coldens
   rm -rf seasons_wes
   rm -rf wrfchem_bio
   rm -rf wrfchem_fire
   rm -rf wrfchem_chemi
   if [[ -e  ${SOURCE_PATH}/${L_DATE}/wrfchem_chem_icbc ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/wrfchem_chem_icbc
      rm -rf *_cr_icbc_pert.*
      rm -rf job*
      rm -rf met_em*
      rm -rf mozbc*
      rm -rf perturb_chem*
      rm -rf pert_chem_icbc
      rm -rf run*
      rm -rf set*
      rm -rf SUCCESS
#      rm -rf wrfbdy*
#      rm -rf wrfinput*
      cd ${SOURCE_PATH}/${L_DATE}
   fi
   if [[ -e  ${SOURCE_PATH}/${L_DATE}/wrfchem_chem_emiss ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/wrfchem_chem_emiss
      rm -rf *_cr_emiss_pert.*
      rm -rf job*
      rm -rf perturb_chem*
      rm -rf pert_chem_emiss
      rm -rf perturb_emiss*
      rm -rf SUCCESS
#      rm -rf wrfbiochemi*
#      rm -rf wrfchemi*
#      rm -rf wrffirechemi*
      rm -rf wrfinput*
      cd ${SOURCE_PATH}/${L_DATE}
   fi   
   rm -rf mopitt_co_obs
   rm -rf iasi_co_obs
   rm -rf iasi_o3_obs
   rm -rf airnow_co_obs
   rm -rf airnow_o3_obs
   rm -rf airnow_no2_obs
   rm -rf airnow_so2_obs
   rm -rf airnow_pm10_obs
   rm -rf airnow_pm25_obs
   rm -rf modis_aod_obs
   rm -rf omi_o3_obs
   rm -rf omi_no2_obs
   rm -rf omi_so2_obs
   rm -rf tropomi_co_obs
   rm -rf tropomi_o3_obs
   rm -rf tropomi_no2_obs
   rm -rf tropomi_so2_obs
   rm -rf tempo_o3_obs
   rm -rf tempo_no2_obs
   rm -rf prepbufr_met_obs
   rm -rf localization
#  rm -rf combine_obs
   if [[ -e  ${SOURCE_PATH}/${L_DATE}/combine_obs ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/combine_obs
      rm -rf dart_log*
      rm -rf input*
      rm -rf obs_sequence_tool
      cd ${SOURCE_PATH}/${L_DATE}
   fi
#   rm -rf preprocess_obs
   if [[ -e  ${SOURCE_PATH}/${L_DATE}/preprocess_obs ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/preprocess_obs
      rm -rf *_preproc.*
      rm -rf SUCCESS
      rm -rf dart_log*
      rm -rf input*
      rm -rf obs_seq.old
      rm -rf job.*
      rm -rf wrf_dart_obs*
      rm -rf wrfbio*
      rm -rf wrfchem*
      rm -rf wrffire*
      rm -rf wrfinput*
      cd ${SOURCE_PATH}/${L_DATE}
   fi
   if [[ -e ${SOURCE_PATH}/${L_DATE}/dart_filter ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/dart_filter
      rm -rf *filter.*
      rm -rf control_impact*
      rm -rf input_list*
      rm -rf output_list*
      rm -rf sampling_error*
      rm -rf advance_time
      rm -rf dart_log*
      rm -rf filter
      rm -rf filter_apm.nml
      rm -rf filter_ic_new.*
      rm -rf filter_ic_old.*
      rm -rf final_full*
#      rm -rf index.html
#      rm -rf input.nml
      rm -rf job.ksh
      rm -rf SUCCESS
      rm -rf ubvals_*
#      rm -rf wrfchemi_d*
#      rm -rf wrffirechemi_d*
#      rm -rf wrfinput_d*
#      rm -rf wrfout_d*   
      rm -rf wrk_dart_e*
      rm -rf wrk_wrf_e*
      cd ${SOURCE_PATH}/${L_DATE}
   fi
   rm -rf update_bc
   if [[ -e ${SOURCE_PATH}/${L_DATE}/wrfchem_initial ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/wrfchem_initial
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${IMEM}
         if [[ ${IMEM} -lt 100 ]]; then export CMEM=e0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export CMEM=e00${IMEM}; fi
         cd run_${CMEM}
         rm -rf *wrf.*
         rm -rf advance_time
         rm -rf aerosol*
         rm -rf bulkdens*
         rm -rf bulkradii*
         rm -rf CAM*
         rm -rf capacity*
         rm -rf CCN*
         rm -rf clim_p_trop* 
         rm -rf CLM*
         rm -rf coeff*
         rm -rf constants*
         rm -rf ETAMPNEW*
         rm -rf exo_coldens*
         rm -rf freeze*
         rm -rf GENPARM*
         rm -rf grib*
         rm -rf hist_io_flds*
         rm -rf namelist.output
#         rm -rf index.html
#         rm -rf input.nml
#         rm -rf job.ksh
         rm -rf kernels*
         rm -rf LANDUSE*
         rm -rf masses*
         rm -rf MPTABLE*
#         rm -rf namelist*
         rm -rf ozone*
         rm -rf qr_acr*
         rm -rf RRTM*
         rm -rf rsl.error*
         rm -rf rsl.out*
         rm -rf SOILPARM*
         rm -rf SUCCESS
         rm -rf termvels*
         rm -rf tr*
         rm -rf URBPARM*
         rm -rf VEGPARM*
         rm -rf wrfapm_d*
         rm -rf wrf.exe
         rm -rf wrf_season*
         rm -rf job_list
         rm -rf test_list
#         rm -rf wrfchemi_d*
#         rm -rf wrffirechemi_d*
#         rm -rf wrfbiochemi_d*
         cd ../
         let IMEM=${IMEM}+1
      done
      cd ${SOURCE_PATH}/${L_DATE}
   fi
   if [[ -e ${SOURCE_PATH}/${L_DATE}/wrfchem_cycle_cr ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/wrfchem_cycle_cr
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${IMEM}
         if [[ ${IMEM} -lt 100 ]]; then export CMEM=e0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export CMEM=e00${IMEM}; fi
         cd run_${CMEM}
         rm -rf *wrf.*
         rm -rf advance_time
         rm -rf aerosol*
         rm -rf bulkdens*
         rm -rf bulkradii*
         rm -rf CAM*
         rm -rf capacity*
         rm -rf CCN*
         rm -rf clim_p_trop* 
         rm -rf CLM*
         rm -rf coeff*
         rm -rf constants*
         rm -rf ETAMPNEW*
         rm -rf exo_coldens*
         rm -rf freeze*
         rm -rf GENPARM*
         rm -rf grib*
         rm -rf hist_io_flds*
#         rm -rf index.html
#         rm -rf input.nml
#         rm -rf job.ksh
         rm -rf kernels*
         rm -rf LANDUSE*
         rm -rf masses*
         rm -rf MPTABLE*
#         rm -rf namelist*
         rm -rf namelist.output
         rm -rf ozone*
         rm -rf qr_acr*
         rm -rf RRTM*
         rm -rf rsl.error*
         rm -rf rsl.out*
         rm -rf SOILPARM*
         rm -rf SUCCESS
         rm -rf termvels*
         rm -rf tr*
         rm -rf URBPARM*
         rm -rf VEGPARM*
         rm -rf wrfapm_d*
         rm -rf wrf.exe
         rm -rf wrf_season*
         rm -rf job_list
         rm -rf test_list
         rm -rf ubvals*
#         rm -rf wrfchemi_d*
#         rm -rf wrffirechemi_d*
#         rm -rf wrfbiochemi_d*
         cd ../
         let IMEM=${IMEM}+1
      done
      cd ${SOURCE_PATH}/${L_DATE}
   fi
   if [[ -e ${SOURCE_PATH}/${L_DATE}/ensemble_mean_output ]]; then
      cd ${SOURCE_PATH}/${L_DATE}/ensemble_mean_output
      rm -rf advance_time
      rm -rf dart_log*
      rm -rf input*
      rm -rf wrfout_d01_0*
      rm -rf wrfchemi_d01*
      cd ${SOURCE_PATH}/${L_DATE}
   fi      
   export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${CYCLE_PERIOD} 2>/dev/null)
done


