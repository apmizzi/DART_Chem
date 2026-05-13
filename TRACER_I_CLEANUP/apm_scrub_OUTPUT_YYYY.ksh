#!/bin/ksh -aux
   export NUM_MEMBERS=30
   export WRFDA_VER=WRFDAv4.3.2_dmpar
   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/${WRFDA_VER}/var/build
   export NUM_EXPS=20
   export OUTPUT_DIR_PATH=/nobackupp28/amizzi/OUTPUT_DATA
#
   export EXP_OUTPUT_DIR[1]=${OUTPUT_DIR_PATH}/OUTPUT_2005_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[2]=${OUTPUT_DIR_PATH}/OUTPUT_2006_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[3]=${OUTPUT_DIR_PATH}/OUTPUT_2007_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[4]=${OUTPUT_DIR_PATH}/OUTPUT_2008_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[5]=${OUTPUT_DIR_PATH}/OUTPUT_2009_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[6]=${OUTPUT_DIR_PATH}/OUTPUT_2010_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[7]=${OUTPUT_DIR_PATH}/OUTPUT_2011_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[8]=${OUTPUT_DIR_PATH}/OUTPUT_2012_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[9]=${OUTPUT_DIR_PATH}/OUTPUT_2013_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[10]=${OUTPUT_DIR_PATH}/OUTPUT_2014_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[11]=${OUTPUT_DIR_PATH}/OUTPUT_2015_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[12]=${OUTPUT_DIR_PATH}/OUTPUT_2016_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[13]=${OUTPUT_DIR_PATH}/OUTPUT_2017_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[14]=${OUTPUT_DIR_PATH}/OUTPUT_2018_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[15]=${OUTPUT_DIR_PATH}/OUTPUT_2019_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[16]=${OUTPUT_DIR_PATH}/OUTPUT_2020_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[17]=${OUTPUT_DIR_PATH}/OUTPUT_2021_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[18]=${OUTPUT_DIR_PATH}/OUTPUT_2022_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[19]=${OUTPUT_DIR_PATH}/OUTPUT_2023_NOAA_EMISADJ_30MEMS
#
   export DATE_YYYY_INC=1
   export DATE_DIR_INC=3
   export DATE_YYYY_STR=2005
   export DATE_YYYY_END=2005
   export DATE_YYYY=${DATE_YYYY_STR}
   export MMDDHH_STR=040200
   export MMDDHH_END=040318
   export MMDDHH=${MMDDHH_STR}
#
   let ICNT=0
   while [[ ${DATE_YYYY} -le ${DATE_YYYY_END} ]]; do
      let ICNT=${ICNT}+1
      cd ${EXP_OUTPUT_DIR[${ICNT}]}
      export DATE_DIR_STR=${DATE_YYYY}${MMDDHH_STR}
      export DATE_DIR_END=${DATE_YYYY}${MMDDHH_END}
      export DATE_DIR=${DATE_DIR_STR} 
      echo "APM delete ${EXP_OUTPUT_DIR[${ICNT}]}"	
      while [[ ${DATE_DIR} -le ${DATE_DIR_END} ]]; do
         cd ${DATE_DIR}
# UPDATE_BC	  
	 rm -rf update_bc
# DART_FILTER	 
         rm -rf dart_filter/*_inf.o*
         rm -rf dart_filter/*_nco*
         rm -rf dart_filter/*_filter*
         rm -rf dart_filter/advance_time
         rm -rf dart_filter/control_impact_runtime.table
         rm -rf dart_filter/dart_log.*
         rm -rf dart_filter/emissions_scaling
         rm -rf dart_filter/filter*
         rm -rf dart_filter/index_*
         rm -rf dart_filter/input_rs*
         rm -rf dart_filter/input_list*.*
         rm -rf dart_filter/input.nml*
         rm -rf dart_filter/obs_seq.out
         rm -rf dart_filter/output_list*
         rm -rf dart_filter/post_emis_inflation*
         rm -rf dart_filter/job*
         rm -rf dart_filter/sampling_error_correction_table*
         rm -rf dart_filter/SUCCESS
         rm -rf dart_filter/ubvals_b40*
         rm -rf dart_filter/wrfchemi_*_da_prior.e*
         rm -rf dart_filter/wrfchemi_*_filt.e*
         rm -rf dart_filter/wrffirechemi_*_da_prior.e*
         rm -rf dart_filter/wrffirechemi_*_filt.e*
         rm -rf dart_filter/wrfinput_d01
         rm -rf dart_filter/wrfout_*_filt.e*
# WRFCHEM_INITIAL
	 if [[ -d wrfchem_iniital ]]; then
            let MEM=0
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
               rm -rf wrfchem_initial/${L_RUN_DIR}/index_*
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
               let MEM=${MEM}+1
            done
	 fi
# WRFCHEM_CYCLE_CR
	 if [[ -d wrfchem_cycle_cr ]]; then
            let MEM=0
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
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/index_*
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
               let MEM=${MEM}+1
            done
	 fi
         export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
      done
      let DATE_YYYY=${DATE_YYYY}+${DATE_YYYY_INC}
   done
   exit
   
