#!/bin/ksh -aux
#
# THIS SCRIPT IS RUN BY 'run_traceri_scrub_thin_all.ksh'
#
#   export DATE_YYYY_STR=2023
#   export DATE_YYYY_END=2023
#   export MMDDHH_STR=040200
#   export MMDDHH_END=040300
#
#   export WRFDA_VER=WRFDAv4.3.2_dmpar
#   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/${WRFDA_VER}/var/build
#
#   export OUTPUT_DIR=/nobackupp28/amizzi/OUTPUT_DATA
   export EXP_DIR_PRE=${OUTPUT_DIR}/OUTPUT_
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
# DART_FILTER	 
         if [[ ${RUN_SCRUB_FILTER} = "true" ]]; then
	    if [[ -d dart_filter ]]; then
               rm -rf dart_filter/*_inf.o*
               rm -rf dart_filter/*_nco*
               rm -rf dart_filter/*_filter*
               rm -rf dart_filter/advance_time
#               rm -rf dart_filter/control_impact_runtime.table
               rm -rf dart_filter/dart_log.*
               rm -rf dart_filter/emissions_scaling
               rm -rf dart_filter/filter*
               rm -rf dart_filter/index*
               rm -rf dart_filter/input_rs*
               rm -rf dart_filter/input_list*.*
               rm -rf dart_filter/input.nml*
               rm -rf dart_filter/obs_seq.out
               rm -rf dart_filter/output_list*
               rm -rf dart_filter/post_emiss_inflation*
               rm -rf dart_filter/post_emis_inflation*
               rm -rf dart_filter/job*
               rm -rf dart_filter/sampling_error_correction_table*
               rm -rf dart_filter/SUCCESS
               rm -rf dart_filter/ubvals_b40*
               rm -rf dart_filter/wrfinput_d01
#               rm -rf dart_filter/wrfout_*_da_prior.e*
#               rm -rf dart_filter/wrfout_*_filt.e*
#               rm -rf dart_filter/wrfchemi_*_da_prior.e*
#               rm -rf dart_filter/wrfchemi_*_filt.e*
#               rm -rf dart_filter/wrffirechemi_*_da_prior.e*
#               rm -rf dart_filter/wrffirechemi_*_filt.e*
            fi
	 fi
#
# UPDATE_BC
         if [[ ${RUN_SCRUB_UPDATE_BC} = "true" ]]; then
            rm -rf update_bc/da_update_bc*
            rm -rf update_bc/index*
            rm -rf update_bc/parame*
            rm -rf update_bc/real_output
            rm -rf update_bc/wrfbdy_d01
            rm -rf update_bc/wrfbdy_d01_input
            rm -rf update_bc/wrfvar_output
         fi
#
# WRFCHEM_INITIAL
         if [[ ${RUN_SCRUB_WRFCHEM} = "true" ]]; then
	    if [[ -d wrfchem_initial ]]; then
               let MEM=1
               while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
                  export CMEM=e${MEM}
                  if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
                  if [[ ${MEM} -lt 10 ]]; then export CMEM=e00${MEM}; fi
                  export L_RUN_DIR=run_${CMEM}
                  rm -rf wrfchem_initial/index_rs.html
                  rm -rf wrfchem_initial/${L_RUN_DIR}/*_wrf.o*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/aerosol*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/bulkdens*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/bulkradii*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/CAM_ABS_DATA
                  rm -rf wrfchem_initial/${L_RUN_DIR}/CAM_AEROPT_DATA
                  rm -rf wrfchem_initial/${L_RUN_DIR}/CAMtr_volume_mixing_ratio*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/capacity.asc
                  rm -rf wrfchem_initial/${L_RUN_DIR}/CCN_ACTIVATE.BIN
                  rm -rf wrfchem_initial/${L_RUN_DIR}/CLM_*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/coeff_*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/constants.asc*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/DATAE1*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/DATAJ1*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/ETAMPNEW_*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/GENPARM.TBL
                  rm -rf wrfchem_initial/${L_RUN_DIR}/grib2map.tbl
                  rm -rf wrfchem_initial/${L_RUN_DIR}/gribmap.txt
                  rm -rf wrfchem_initial/${L_RUN_DIR}/HLC.TBL
                  rm -rf wrfchem_initial/${L_RUN_DIR}/index*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/input*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/job*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/kernels*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/LANDUSE.TBL
                  rm -rf wrfchem_initial/${L_RUN_DIR}/masses.asc
                  rm -rf wrfchem_initial/${L_RUN_DIR}/MPTABLE.TBL
                  rm -rf wrfchem_initial/${L_RUN_DIR}/namelist*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/ozone*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/RRTM*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/rsl.error.*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/rsl.out.*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/SOILPARM.TBL
                  rm -rf wrfchem_initial/${L_RUN_DIR}/SUCCESS
                  rm -rf wrfchem_initial/${L_RUN_DIR}/termvels.asc
                  rm -rf wrfchem_initial/${L_RUN_DIR}/tr*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/URBPARM.TBL
                  rm -rf wrfchem_initial/${L_RUN_DIR}/VEGPARM.TBL
                  rm -rf wrfchem_initial/${L_RUN_DIR}/wrf.exe
                  rm -rf wrfchem_initial/${L_RUN_DIR}/wrf_tuv_xsqy.nc
                  rm -rf wrfchem_initial/${L_RUN_DIR}/wrfbiochemi_*
                  rm -rf wrfchem_initial/${L_RUN_DIR}/wrflowinp_*
#	    
                  export FC_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} 1 2>/dev/null)
                  export FC_DATE_END=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} 2 2>/dev/null)
                  while [[ ${FC_DATE} -le ${FC_DATE_END} ]]; do
                     export FC_YYYY=$(echo $FC_DATE | cut -c1-4)
                     export FC_MM=$(echo $FC_DATE | cut -c5-6)
                     export FC_DD=$(echo $FC_DATE | cut -c7-8)
                     export FC_HH=$(echo $FC_DATE | cut -c9-10)
                     export FC_FILE_DATE=d01_${FC_YYYY}-${FC_MM}-${FC_DD}_${FC_HH}:00:00
                     rm -rf wrfchem_initial/${L_RUN_DIR}/wrfchemi_${FC_FILE_DATE}
                     rm -rf wrfchem_initial/${L_RUN_DIR}/wrffirechemi_${FC_FILE_DATE}
                     rm -rf wrfchem_initial/${L_RUN_DIR}/wrfout_${FC_FILE_DATE}
                     export FC_DATE=$(${BUILD_DIR}/da_advance_time.exe ${FC_DATE} 1 2>/dev/null)
	          done
                  let MEM=${MEM}+1
               done
	    fi
#	    
# WRFCHEM_CYCLE_CR
	    if [[ -d wrfchem_cycle_cr ]]; then
               let MEM=1
               while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
                  export CMEM=e${MEM}
                  if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
                  if [[ ${MEM} -lt 10 ]]; then export CMEM=e00${MEM}; fi
                  export L_RUN_DIR=run_${CMEM}
                  rm -rf wrfchem_cycle_cr/index_rs.html
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/*_adj.o*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/*_wrf.o*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/adjust_chem_emiss*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/advance_time*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/aerosol*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/bulkdens*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/bulkradii*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/CAM_ABS_DATA
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/CAM_AEROPT_DATA
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/CAMtr_volume_mixing_ratio*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/capacity.asc
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/CCN_ACTIVATE.BIN
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/CLM_*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/coeff_*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/constants.asc*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/DATAE1*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/DATAJ1*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/ETAMPNEW_*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/GENPARM.TBL
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/grib2map.tbl
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/gribmap.txt
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/HLC.TBL
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/index*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/input*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/job*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/kernels*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/LANDUSE.TBL
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/masses.asc
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/MPTABLE.TBL
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/namelist*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/ozone*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/RRTM*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/rsl.error.*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/rsl.out.*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/SOILPARM.TBL
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/SUCCESS
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/termvels.asc
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/tr*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/URBPARM.TBL
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/VEGPARM.TBL
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrf.exe
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrf_tuv_xsqy.nc
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrfbiochemi_*
                  rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrflowinp_*
#	    
                  export FC_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} 1 2>/dev/null)
                  export FC_DATE_END=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} 2 2>/dev/null)
                  while [[ ${FC_DATE} -le ${FC_DATE_END} ]]; do
                     export FC_YYYY=$(echo $FC_DATE | cut -c1-4)
                     export FC_MM=$(echo $FC_DATE | cut -c5-6)
                     export FC_DD=$(echo $FC_DATE | cut -c7-8)
                     export FC_HH=$(echo $FC_DATE | cut -c9-10)
                     export FC_FILE_DATE=d01_${FC_YYYY}-${FC_MM}-${FC_DD}_${FC_HH}:00:00
                     rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrfchemi_${FC_FILE_DATE}
                     rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrffirechemi_${FC_FILE_DATE}
                     rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrfout_${FC_FILE_DATE}
                     export FC_DATE=$(${BUILD_DIR}/da_advance_time.exe ${FC_DATE} 1 2>/dev/null)
	          done
                  let MEM=${MEM}+1
               done
	    fi
	 fi
         export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
      done
#     du -sh ${TARGET_DIR}                                 ## 3.3 T with or without post-processing dirs
# CONTENTS:
#      Initial Cycle:         284G
#      Assimilation Cycles:   354G
      let DATE_YYYY=${DATE_YYYY}+${DATE_YYYY_INC}
   done
   
