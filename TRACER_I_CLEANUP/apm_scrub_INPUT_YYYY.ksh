#!/bin/ksh -aux
   export NUM_MEMBERS=30
   export WRFDA_VER=WRFDAv4.3.2_dmpar
   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/${WRFDA_VER}/var/build
   export NUM_EXPS=20
   export OUTPUT_DIR_PATH=/nobackupp28/amizzi/OUTPUT_DATA
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
   export DATE_YYYY_INC=1
   export DATE_DIR_INC=3
   export DATE_YYYY_STR=2005
   export DATE_YYYY_END=2023
   export DATE_YYYY=${DATE_YYYY_STR}
   export MMDDHH_STR=040200
   export MMDDHH_END=040318
   export MMDDHH=${MMDDHH_STR}
#
# If DATE_YYYY_STR does not equal 2005, ICNT needs to be adjusted to the correct index (ARR_INDEX-1)
   let ICNT=0
   while [[ ${DATE_YYYY} -le ${DATE_YYYY_END} ]]; do
      let ICNT=${ICNT}+1
#
# INPUT_DIR file deletion
      cd ${EXP_INPUT_DIR[${ICNT}]}
      export DATE_DIR_STR=${DATE_YYYY}${MMDDHH_STR}
      export DATE_DIR_END=${DATE_YYYY}${MMDDHH_END}
      export DATE_DIR=${DATE_DIR_STR}
      echo "APM delete ${EXP_INPUT_DIR[${ICNT}]}"
      while [[ ${DATE_DIR} -le ${DATE_DIR_END} ]]; do
         cd ${EXP_INPUT_DIR[${ICNT}]}/${DATE_DIR}
         echo "   APM delete ${DATE_DIR}"
         rm -rf airnow_co_obs
         rm -rf airnow_no2_obs
         rm -rf airnow_o3_obs
         rm -rf airnow_so2_obs
         rm -rf gome2a_no2_trop_col_obs
         rm -rf metgrid
         rm -rf mls_hno3_profile_obs
         rm -rf mls_o3_profile_obs
         rm -rf mopitt_co_profile_obs
         rm -rf omi_no2_domino_trop_col_obs
         rm -rf omi_o3_profile_obs
         rm -rf omi_so2_pbl_col_obs
         rm -rf prepbufr_met_obs
         rm -rf real
         rm -rf sciam_no2_trop_col_obs
         rm -rf tes_co_profile_obs
         rm -rf tes_o3_profile_obs
         rm -rf urgrib
         rm -rf wrfchem_bio
         rm -rf wrfchem_chemi
         rm -rf wrfchem_fire
         rm -rf wrfchem_me_bc
         rm -rf wrfchem_me_ic
         rm -rf NOAA/combine
         rm -rf NOAA/index_create_NOAA*
         rm -rf NOAA/preprocess/*_nco.o*
         rm -rf NOAA/preprocess/*_prep_o*
         rm -rf NOAA/preprocess/dart_log*
         rm -rf NOAA/preprocess/index_*
         rm -rf NOAA/preprocess/input.nml
         rm -rf NOAA/preprocess/job*
         rm -rf NOAA/preprocess/obs_seq.old
         rm -rf NOAA/preprocess/SUCCESS
         rm -rf NOAA/preprocess/wrf*
         rm -rf wrfchem_chem_emiss/*_cr_emiss_pert.o*
         rm -rf wrfchem_chem_emiss/adjust_chem_emiss*
         rm -rf wrfchem_chem_emiss/index_*
         rm -rf wrfchem_chem_emiss/job*
         rm -rf wrfchem_chem_emiss/perturb_*
         rm -rf wrfchem_chem_emiss/SUCCESS
         rm -rf wrfchem_chem_emiss/wrfinput_d01_template
         rm -rf wrfchem_chem_icbc/*_nco.o*
         rm -rf wrfchem_chem_icbc/*_cr_icbc_pert.o*
         rm -rf wrfchem_chem_icbc/*_mozbc_bc.o*
         rm -rf wrfchem_chem_icbc/*_mozbc_ic.o*
         rm -rf wrfchem_chem_icbc/index_*
         rm -rf wrfchem_chem_icbc/job*
         rm -rf wrfchem_chem_icbc/met_em.d01.*
         rm -rf wrfchem_chem_icbc/mozbc.exe
         rm -rf wrfchem_chem_icbc/perturb_chem_icbc*
         rm -rf wrfchem_chem_icbc/SUCCESS
         rm -rf wrfchem_chem_icbc/wrfbdy_d01
         rm -rf wrfchem_chem_icbc/wrfchem.namelist.input
         rm -rf wrfchem_chem_icbc/wrfinput_d01
         export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
      done
      let DATE_YYYY=${DATE_YYYY}+${DATE_YYYY_INC}
   done
   echo "APM: End of files delete script "
exit
   
