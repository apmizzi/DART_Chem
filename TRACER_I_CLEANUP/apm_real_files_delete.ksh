#!/bin/ksh -aux
   export NUM_MEMBERS=30
   export WRFDA_VER=WRFDAv4.3.2_dmpar
   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/${WRFDA_VER}/var/build
   export NUM_EXPS=20
   export OUTPUT_DIR_PATH=/nobackupp28/amizzi/OUTPUT_DATA
   export INOUT_SW=1
   export EXP_INPUT_DIR[1]=${OUTPUT_DIR_PATH}/INPUT_2005_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[2]=${OUTPUT_DIR_PATH}/INPUT_2006_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[3]=${OUTPUT_DIR_PATH}/INPUT_2007_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[4]=${OUTPUT_DIR_PATH}/INPUT_2008_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[5]=${OUTPUT_DIR_PATH}/INPUT_2009_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[6]=${OUTPUT_DIR_PATH}/INPUT_2010_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[7]=${OUTPUT_DIR_PATH}/INPUT_2011_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[8]=${OUTPUT_DIR_PATH}/INPUT_2012_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[9]=${OUTPUT_DIR_PATH}/INPUT_2013_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[10]=${OUTPUT_DIR_PATH}/INPUT_2014_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[11]=${OUTPUT_DIR_PATH}/INPUT_2015_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[12]=${OUTPUT_DIR_PATH}/INPUT_2016_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[13]=${OUTPUT_DIR_PATH}/INPUT_2017_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[14]=${OUTPUT_DIR_PATH}/INPUT_2018_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[15]=${OUTPUT_DIR_PATH}/INPUT_2019_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[16]=${OUTPUT_DIR_PATH}/INPUT_2020_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[17]=${OUTPUT_DIR_PATH}/INPUT_2021_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[18]=${OUTPUT_DIR_PATH}/INPUT_2022_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[19]=${OUTPUT_DIR_PATH}/INPUT_2023_NOAA_EMISADJ_30MEMS
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
   export DATE_YYYY_END=2023
   export DATE_YYYY=${DATE_YYYY_STR}
   export MMDDHH_STR=040200
   export MMDDHH_END=040318
   export MMDDHH=${MMDDHH_STR}
#
# If DATE_YYYY_STR does not equal 2005, ICNT needs to be adjusted to the correct index   
   let ICNT=${DATE_YYYY_STR}-2005
#
   while [[ ${DATE_YYYY} -le ${DATE_YYYY_END} ]]; do
      let ICNT=${ICNT}+1
#
# INPUT_DIR file deletion
      if [[ INOUT_SW -eq 0 ]]; then      
         cd ${EXP_INPUT_DIR[${ICNT}]}
         export DATE_DIR_STR=${DATE_YYYY}${MMDDHH_STR}
         export DATE_DIR_END=${DATE_YYYY}${MMDDHH_END}
         export DATE_DIR=${DATE_DIR_STR}
         echo "APM delete ${EXP_INPUT_DIR[${ICNT}]}"
         while [[ ${DATE_DIR} -le ${DATE_DIR_END} ]]; do
            cd ${EXP_INPUT_DIR[${ICNT}]}/${DATE_DIR}
            echo "   APM delete ${DATE_DIR}"
#
# Delete these directories
#            mkdir OLD_DIRS	    
	    rm -rf  airnow_co_obs 
	    rm -rf  airnow_no2_obs 
	    rm -rf  airnow_so2_obs 
	    rm -rf  airnow_o3_obs 
	    rm -rf  gome2a_no2_trop_col_obs 
	    rm -rf  metgrid 
	    rm -rf  mls_hno3_profile_obs 
	    rm -rf  mls_o3_profile_obs 
	    rm -rf  mopitt_co_profile_obs 
	    rm -rf  omi_no2_domino_trop_col_obs 
	    rm -rf  omi_o3_profile_obs 
	    rm -rf  omi_so2_pbl_col_obs 
	    rm -rf  prepbufr_met_obs 
	    rm -rf  sciam_no2_trop_col_obs 
	    rm -rf  tes_co_profile_obs 
	    rm -rf  tes_o3_profile_obs 
	    rm -rf  ungrib 
	    rm -rf  wrfchem_bio 
	    rm -rf  wrfchem_chemi 
	    rm -rf  wrfchem_fire 
            export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
         done
      fi
#
# OUTPUT_DIR file deletion
      if [[ INOUT_SW -eq 1 ]]; then      
         export DATE_DIR_STR=${DATE_YYYY}${MMDDHH_STR}
         export DATE_DIR_END=${DATE_YYYY}${MMDDHH_END}
         export DATE_DIR=${DATE_DIR_STR} 
         echo "APM delete ${EXP_OUTPUT_DIR[${ICNT}]}"	
         while [[ ${DATE_DIR} -le ${DATE_DIR_END} ]]; do
            cd ${EXP_OUTPUT_DIR[${ICNT}]}/${DATE_DIR} 
            echo "   APM delete ${DATE_DIR}"
#
# Delete these files
            let MEM=1
            while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
               export CMEM=e${MEM}
               if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
               if [[ ${MEM} -lt 10 ]]; then export CMEM=e00${MEM}; fi
               export L_RUN_DIR=run_${CMEM}
#
# wrfchem_initial	       
               rm -rf wrfchem_initial/${L_RUN_DIR}/wrfbdy_d01
               rm -rf wrfchem_initial/${L_RUN_DIR}/wrfinput_d01
               rm -rf wrfchem_initial/${L_RUN_DIR}/wrflowinp_d01
               rm -rf wrfchem_initial/${L_RUN_DIR}/input.nml
               rm -rf wrfchem_initial/${L_RUN_DIR}/namelist.input
               rm -rf wrfchem_initial/${L_RUN_DIR}/*_wrf.o*
               rm -rf wrfchem_initial/${L_RUN_DIR}/aerosol.*
               rm -rf wrfchem_initial/${L_RUN_DIR}/aerosol_*
               rm -rf wrfchem_initial/${L_RUN_DIR}/bulk*
               rm -rf wrfchem_initial/${L_RUN_DIR}/CAM*
               rm -rf wrfchem_initial/${L_RUN_DIR}/capacity*
               rm -rf wrfchem_initial/${L_RUN_DIR}/CNN_*
               rm -rf wrfchem_initial/${L_RUN_DIR}/CLM_*
               rm -rf wrfchem_initial/${L_RUN_DIR}/coef_*
               rm -rf wrfchem_initial/${L_RUN_DIR}/constants.*
               rm -rf wrfchem_initial/${L_RUN_DIR}/DATAE1
               rm -rf wrfchem_initial/${L_RUN_DIR}/DATAJ1
               rm -rf wrfchem_initial/${L_RUN_DIR}/ETAMPNEW_*
               rm -rf wrfchem_initial/${L_RUN_DIR}/GENPARM.TBL
               rm -rf wrfchem_initial/${L_RUN_DIR}/grib2map.*
               rm -rf wrfchem_initial/${L_RUN_DIR}/gribmap.*
               rm -rf wrfchem_initial/${L_RUN_DIR}/HLC.TBL
               rm -rf wrfchem_initial/${L_RUN_DIR}/index.html
               rm -rf wrfchem_initial/${L_RUN_DIR}/job.ksh
               rm -rf wrfchem_initial/${L_RUN_DIR}/kernels*
               rm -rf wrfchem_initial/${L_RUN_DIR}/LANDUSE.TBL
               rm -rf wrfchem_initial/${L_RUN_DIR}/masses.asc
               rm -rf wrfchem_initial/${L_RUN_DIR}/MPTABLE.TBL
               rm -rf wrfchem_initial/${L_RUN_DIR}/ozone*
               rm -rf wrfchem_initial/${L_RUN_DIR}/RRTM*
               rm -rf wrfchem_initial/${L_RUN_DIR}/rsl.error.*
               rm -rf wrfchem_initial/${L_RUN_DIR}/rsl.out.*
               rm -rf wrfchem_initial/${L_RUN_DIR}/SOILPARM.TBL
               rm -rf wrfchem_initial/${L_RUN_DIR}/SUCCESS
               rm -rf wrfchem_initial/${L_RUN_DIR}/termvels.*
               rm -rf wrfchem_initial/${L_RUN_DIR}/tr*
               rm -rf wrfchem_initial/${L_RUN_DIR}/URBPARM.TBL
               rm -rf wrfchem_initial/${L_RUN_DIR}/VEGPARM.TBL
               rm -rf wrfchem_initial/${L_RUN_DIR}/wrf.exe
               rm -rf wrfchem_initial/${L_RUN_DIR}/wrf_tuv_xsqy.*
               rm -rf wrfchem_initial/${L_RUN_DIR}/CCN_ACTIVATE*
               rm -rf wrfchem_initial/${L_RUN_DIR}/coeff_*
               rm -rf wrfchem_initial/${L_RUN_DIR}/namelist.output
#
# wrfchem_cycle_cr
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrfbdy_d01
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrfinput_d01
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrflowinp_d01
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/input.nml
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/namelist.input
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/*_adj.o*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/adjust_*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/advance_time
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/index_adjust_chem_emiss
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/index_adjust_emiss_log
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/jobx.ksh
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/*_wrf.o*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/aerosol.*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/aerosol_*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/bulk*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/CAM*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/capacity*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/CNN_*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/CLM_*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/coef_*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/constants.*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/DATAE1
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/DATAJ1
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/ETAMPNEW_*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/GENPARM.TBL
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/grib2map.*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/gribmap.*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/HLC.TBL
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/index.html
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/job.ksh
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/kernels*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/LANDUSE.TBL
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/masses.asc
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/MPTABLE.TBL
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/ozone*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/RRTM*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/rsl.error.*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/rsl.out.*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/SOILPARM.TBL
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/SUCCESS
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/termvels.*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/tr*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/URBPARM.TBL
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/VEGPARM.TBL
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrf.exe
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/wrf_tuv_xsqy.*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/CCN_ACTIVATE*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/coeff_*
               rm -rf wrfchem_cycle_cr/${L_RUN_DIR}/namelist.output
	       let MEM=${MEM}+1
	    done
#
# dart_filter
            rm -rf dart_filter/input.nml
            rm -rf dart_filter/obs_seq.out
            rm -rf dart_filter/emissions_scaling
            rm -rf dart_filter/input_list.txt
            rm -rf dart_filter/*_filter.o*
            rm -rf dart_filter/*_inf.o*
            rm -rf dart_filter/*_nco_*.o*
            rm -rf dart_filter/advance_time
            rm -rf dart_filter/control_impact*
            rm -rf dart_filter/dart_log.*
            rm -rf dart_filter/filter*
            rm -rf dart_filter/index*
            rm -rf dart_filter/job.ksh
            rm -rf dart_filter/jobx.ksh
            rm -rf dart_filter/output_list.txt
            rm -rf dart_filter/post_emis_*
            rm -rf dart_filter/sampling_error_*
            rm -rf dart_filter/SUCCESS
            rm -rf dart_filter/ubvals_b40.*
            rm -rf dart_filter/wrfchemi_d01_*_old
            rm -rf dart_filter/wrfchemi_d01_*sprd_post*
            rm -rf dart_filter/wrffirechemi_d01_*_old
            rm -rf dart_filter/wrffirechemi_d01_*sprd_post*
            rm -rf dart_filter/wrfinput_d01
#
# update_bc
            rm -rf update_bc/da_update_bc.*
            rm -rf update_bc/fort.*
            rm -rf update_bc/index*
            rm -rf update_bc/parame*
            rm -rf update_bc/wrfbdy_d01
            rm -rf update_bc/wrfbdy_d01_*prior.*
            rm -rf update_bc/wrfbdy_d01_input
            rm -rf update_bc/wrfbdy_d01_outpu
            rm -rf update_bc/real_output
            rm -rf update_bc/wrfvar_output
            export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
         done
      fi
      let DATE_YYYY=${DATE_YYYY}+${DATE_YYYY_INC}
   done
   echo "APM: End of files delete script "
exit
   
