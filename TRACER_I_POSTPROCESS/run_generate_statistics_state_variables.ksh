#!/bin/ksh -aeux
#
   export YYYY_STR=2005
   export YYYY_END=2005
   export MMDDHH_STR=040200
   export MMDDHH_END=040300
#
   export DATA_PATH=/nobackupp28/amizzi/OUTPUT_DATA
   export CODE_PATH=/nobackupp28/amizzi/TRUNK/DART_development/TRACER_I_POSTPROCESS
   export RUN_PATH=/nobackupp28/amizzi/OUTPUT_DATA/TRACER_I_POSTPROCESS
   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/WRFDAv4.3.2_dmpar/var/da
   export EXP_DIR_PRE=OUTPUT_
   export EXP_DIR_POST=_NOAA_EMISADJ_30MEMS
#
# Compile post-processing code   
   export FILE=generate_statistics_state_variables
   cd ${RUN_PATH}
   rm -rf ${FILE}.f90 ${FILE}.exe
   cp ${CODE_PATH}/${FILE}.f90 ./.
#
   export LIBS='-L${NETCDF}/lib -lnetcdff -lnetcdf'
   export INCS='-I${NETCDF}/include'
   ifort ${FILE}.f90 -o ${FILE}.exe ${LIBS} ${INCS}
   if [[ ! -e ${FILE}.exe ]]; then
      echo "APM: ${FILE} compile error "
      exit
   fi
#  
   export INC=3   
   let L_YYYY=${YYYY_STR}
   while [[ ${L_YYYY} -le ${YYYY_END} ]]; do
      export DATE_INITIAL=${L_YYYY}040200
      export DATE_STR=${L_YYYY}${MMDDHH_STR}
      export DATE_END=${L_YYYY}${MMDDHH_END}
      let L_DATE=${DATE_STR}
      while [[ ${L_DATE} -le ${DATE_END} ]]; do
         export YYYY=`echo ${L_DATE} |cut -c1-4`
         export MM=`echo ${L_DATE} | cut -c5-6`
         export DD=`echo ${L_DATE} | cut -c7-8`
         export HH=`echo ${L_DATE} | cut -c9-10`
         export MN=00
         export SS=00
#
# TCR2
         export TCR2_DIR=/nobackupp27/nex/datapool/TRACER-1/TRACER1_OBS/tcr2_data
         export TCR2_CHEM_FILE=${TCR2_DIR}/${YYYY}/${MM}/h0001.nc
         export TCR2_MET_PRE=${TCR2_DIR}/${YYYY}/${MM}/met/${YYYY}${MM}_
         export TCR2_MET_SUF=.gt3.nc
#
# CAMCHEM
         export CAMCHEM_DIR=/nobackupp27/nex/datapool/TRACER-1/TRACER1_OBS/CAM-CHEM
         export CAMCHEM_PRE=/Subsetted_f.e22.FCnudged.f09_f09_mg17.slh.2000.lght15_ct2025.finn.mosaic_cams6.002.cam.h4.
         export CAMCHEM_FILE=${CAMCHEM_DIR}/${YYYY}/${MM}/${DD}${CAMCHEM_PRE}${YYYY}-${MM}-${DD}-00000.nc
	 if [[ ${YYYY} -gt 2014 ]]; then
            export CAMCHEM_FILE=${CAMCHEM_DIR}/${YYYY}/${MM}/${DD}${CAMCHEM_PRE}${YYYY}-${MM}-${DD}-10800.nc
         fi
#
# WRFCMAQ
         export WRFCMAQ_DIR=/nobackupp27/nex/datapool/TRACER-1/TRACER1_OBS/WRF_CMAQ_reanalysis
         export WRFCMAQ_GRIDCRO2D=${WRFCMAQ_DIR}/GRIDCRO2D.nc
         export WRFCMAQ_GRIDDOT2D=${WRFCMAQ_DIR}/GRIDDOT2D.nc
         export WRFCMAQ_METCRO2D=${WRFCMAQ_DIR}/${YYYY}/${MM}/${DD}/METCRO2D_${YYYY}${MM}${DD}.nc
         export WRFCMAQ_METCRO3D=${WRFCMAQ_DIR}/${YYYY}/${MM}/${DD}/METCRO3D_${YYYY}${MM}${DD}.nc
         export WRFCMAQ_METDOT3D=${WRFCMAQ_DIR}/${YYYY}/${MM}/${DD}/METDOT3D_${YYYY}${MM}${DD}.nc
         export WRFCMAQ_CHEMCRO2D=${WRFCMAQ_DIR}/${YYYY}/${MM}/Subsetted_COMBINE_ACONC_v532_intel_NOAA_fire_${YYYY}${MM}.nc
#
         if [[ ${L_DATE} -eq ${DATE_INITIAL} ]]; then      
            export DATA_DIR=${DATA_PATH}/${EXP_DIR_PRE}${YYYY}${EXP_DIR_POST}/${L_DATE}/wrfchem_initial
         else
	    export DATA_DIR=${DATA_PATH}/${EXP_DIR_PRE}${YYYY}${EXP_DIR_POST}/${L_DATE}/wrfchem_cycle_cr
         fi
#
         export STATS_DIR=${DATA_PATH}/${EXP_DIR_PRE}${YYYY}${EXP_DIR_POST}/ensemble_stats/${L_DATE}
         if [[ ! -e ${STATS_DIR} ]]; then
            mkdir -p ${STATS_DIR}
         fi
         export STRAT_FILE=TRACER_I_Stratifications_Data
         ln -sf ${DATA_PATH}/${STRAT_FILE} ${RUN_PATH}/.
#
         export F_DATE=${L_DATE}
         export F_DATE_END=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${INC} -f ccyymmddhh 2>/dev/null)
         while [[ ${F_DATE} -le ${F_DATE_END} ]]; do
            export F_YYYY=`echo ${F_DATE} |cut -c1-4`
            export F_MM=`echo ${F_DATE} | cut -c5-6`
            export F_DD=`echo ${F_DATE} | cut -c7-8`
            export F_HH=`echo ${F_DATE} | cut -c9-10`
            export F_MN=00
            export F_SS=00
	    export F_WRFOUT_FILE=wrfout_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}
	    export F_WRFCHEMI_FILE=wrfchemi_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}
	    export F_WRFFIRE_FILE=wrffirechemi_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}
            export F_OUTPUT_FILE=ens_stats_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}
            cat << EOF > ens_postprocess.nl
&ens_postprocess 
path_input           = "${DATA_DIR}",
path_output          = "${STATS_DIR}",
wrfout_input         = "${F_WRFOUT_FILE}",
wrfchemi_input       = "${F_WRFCHEMI_FILE}",
wrffirechemi_input   = "${F_WRFFIRE_FILE}",
file_output          = "${F_OUTPUT_FILE}",
nx                   = 440,
ny                   = 284,
nz                   = 50,
nz_chemi             = 20,
nz_fire              = 1,
num_met_flds         = 4,
num_chem_flds        = 4,
num_chemi_flds       = 3,
num_fire_flds        = 3,
num_mems             = 30
date_wrfchem         = ${F_DATE}
tcr2_met_pre         = "${TCR2_MET_PRE}",
tcr2_met_suf         = "${TCR2_MET_SUF}",
tcr2_chem_file       = "${TCR2_CHEM_FILE}",
camchem_file         = "${CAMCHEM_FILE}",
wrfcmaq_gridcro2d    = "${WRFCMAQ_GRIDCRO2D}",
wrfcmaq_griddot2d    = "${WRFCMAQ_GRIDDOT2D}",
wrfcmaq_metcro2d     = "${WRFCMAQ_METCRO2D}",
wrfcmaq_metcro3d     = "${WRFCMAQ_METCRO3D}",
wrfcmaq_metdot3d     = "${WRFCMAQ_METDOT3D}",
wrfcmaq_chemcro2d    = "${WRFCMAQ_CHEMCRO2D}",
/
EOF
#
            cat << EOF > ens_varlist.nl
&ens_varlist
met_flds         = "T","U","V","Q",
chem_flds        = "co","o3","no2","so2",
chemi_flds       = "E_CO","E_NO2","E_SO2",
firechemi_flds   = "ebu_co","ebu_no2","ebu_so2",
/
EOF
#
            TRANDOM=$$
	    export JOBRND=${TRANDOM}_stats
            export SINGLE_JOB_CLASS=normal
            export SINGLE_TIME_LIMIT=00:10:00
            export SINGLE_NODES=1
            export SINGLE_TASKS=1
            export SINGLE_MODEL=mil_ait
	    export ACCOUNT=s2933
	    export JOB_CONTROL_SCRIPTS_DIR=/nobackupp28/amizzi/TRUNK/DART_development/models/wrf_chem/job_control_scripts
#	    
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} ./${FILE}.exe SERIAL ${ACCOUNT} ${SINGLE_MODEL}
#            qsub -Wblock=true job.ksh
#
            ./${FILE}.exe > index_${JOBRND}
            mv index_${JOBRND} index.state_variables_C${L_DATE}_F${F_DATE} 2>&1
#
            export F_DATE=$(${BUILD_DIR}/da_advance_time.exe ${F_DATE} ${INC} -f ccyymmddhh 2>/dev/null)
         done
	 rm ${RUN_PATH}/${STRAT_FILE} 
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${INC} -f ccyymmddhh 2>/dev/null)
      done
      let L_YYYY=${L_YYYY}+1
   done
#   
