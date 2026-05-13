#!/bin/ksh -aeux
#
   export YYYY_STR=2005
   export YYYY_END=2005
   export MMDDHH_STR=040203
   export MMDDHH_END=040300
#
   export DATA_PATH=/nobackupp28/amizzi/OUTPUT_DATA
   export CODE_PATH=/nobackupp28/amizzi/TRACER_I_POSTPROCESS
   export RUN_PATH=/nobackupp28/amizzi/OUTPUT_DATA/TRACER_I_POSTPROCESS
   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/WRFDAv4.3.2_dmpar/var/da
   export EXP_DIR_PRE=OUTPUT_
   export EXP_INPUT_DIR_PRE=INPUT_
   export EXP_DIR_POST=_NOAA_EMISADJ_30MEMS
#
# Compile post-processing code   
   export FILE=generate_statistics_da_diagnostics
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
         export F_YYYY=`echo ${L_DATE} |cut -c1-4`
         export F_MM=`echo ${L_DATE} | cut -c5-6`
         export F_DD=`echo ${L_DATE} | cut -c7-8`
         export F_HH=`echo ${L_DATE} | cut -c9-10`
         export F_MN=00
         export F_SS=00
#
         if [[ ${L_DATE} -ne ${DATE_INITIAL} ]]; then      
            export EMIS_ARC_DIR=${DATA_PATH}/${EXP_INPUT_DIR_PRE}${F_YYYY}${EXP_DIR_POST}/${L_DATE}/wrfchem_chem_emiss
            export DATA_DIR=${DATA_PATH}/${EXP_DIR_PRE}${F_YYYY}${EXP_DIR_POST}/${L_DATE}/dart_filter
            export STATS_DIR=${DATA_PATH}/${EXP_DIR_PRE}${F_YYYY}${EXP_DIR_POST}/da_diagnostics/${L_DATE}
            if [[ ! -e ${STATS_DIR} ]]; then
               mkdir -p ${STATS_DIR}
            fi
            export STRAT_FILE=TRACER_I_Stratifications_Data
            ln -sf ${DATA_PATH}/${STRAT_FILE} ${RUN_PATH}/.
#	   
            export F_ARC_PRIOR_CHEMI_FILE=wrfchemi_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}_parent
            export F_ARC_PRIOR_FIRE_FILE=wrffirechemi_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}_parent
	    export F_PRIOR_MN_FILE=preassim_mean.nc
	    export F_POST_MN_FILE=output_mean.nc
	    export F_PRIOR_SD_FILE=preassim_sd.nc
	    export F_POST_SD_FILE=output_sd.nc
	    export F_INFL_PRIOR_MN_FILE=preassim_postinf_mean.nc
	    export F_INFL_POST_MN_FILE=output_postinf_mean.nc
            export F_OUTPUT_FILE=da_diagnostics_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}
	    rm -rf ${F_OUTPUT_FILE}
            cat << EOF > ens_da_diagnostics.nl
&ens_da_diagnostics
date_traceri                    = ${L_DATE},
path_input                      = "${DATA_DIR}",
path_input_arc_emis             = "${EMIS_ARC_DIR}",
path_output                     = "${STATS_DIR}",
file_strats                     = "${STRAT_FILE}",
file_output                     = "${F_OUTPUT_FILE}",
file_input_arc_prior_chemi      = "${F_ARC_PRIOR_CHEMI_FILE}",
file_input_arc_prior_fire       = "${F_ARC_PRIOR_FIRE_FILE}",
file_input_prior_mn             = "${F_PRIOR_MN_FILE}",
file_input_post_mn              = "${F_POST_MN_FILE}",
file_input_prior_sd             = "${F_PRIOR_SD_FILE}",
file_input_post_sd              = "${F_POST_SD_FILE}",
file_input_infl_prior           = "${F_INFL_PRIOR_MN_FILE}",
file_input_infl_post            = "${F_INFL_POST_MN_FILE}",
nx                              = 440,
ny                              = 284,
nz                              = 50,
num_mems                        = 30,
nz_chemi                        = 20,
nz_fire                         = 1,
/
EOF
#
            TRANDOM=$$
	    export JOBRND=${TRANDOM}_stats
            export SINGLE_JOB_CLASS=devel
            export SINGLE_TIME_LIMIT=00:10:00
            export SINGLE_NODES=1
            export SINGLE_TASKS=1
            export SINGLE_MODEL=mil_ait
	    export ACCOUNT=s2933
	    export JOB_CONTROL_SCRIPTS_DIR=/nobackupp28/amizzi/TRUNK/DART_development/models/wrf_chem/job_control_scripts
#	    
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} ./${FILE}.exe SERIAL ${ACCOUNT} ${SINGLE_MODEL}
#            qsub -Wblock=true job.ksh
#            mv index_${JOBRND} index.output_C${L_DATE} 2>&1

            ./${FILE}.exe > index_${JOBRND}
            mv index_${JOBRND} index.da_diagnostics_${L_DATE} 2>&1
            rm -rf ${RUN_PATH}/${STRAT_FILE}
	 fi
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${INC} -f ccyymmddhh 2>/dev/null)
      done
      let L_YYYY=${L_YYYY}+1
   done
#   
