#!/bin/ksh -aux
   cd ${RUN_DIR}/${DATE}/wrfchem_chem_icbc
#
# PERTURB CHEM ICBC
      export NL_SW_CORR_TM=false
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then export NL_SW_CORR_TM=true; fi
      export NL_SW_SEED=true
#
      cp ${METGRID_DIR}/met_em.d${CR_DOMAIN}.*:00:00.nc ./.
#      cp ${METGRID_DIR}/met_em.d${FR_DOMAIN}.*:00:00.nc ./.
      cp ${PERT_CHEM_INPUT_DIR}/work/perturb_chem_icbc_CORR_RT_MA.exe ./.
      cp ${PERT_CHEM_INPUT_DIR}/work/perturb_chem_icbc_CORR_RT_MA_MPI.exe ./.
      cp ${PERT_CHEM_INPUT_DIR}/work/mozbc.exe ./mozbc.exe
      cp ${PERT_CHEM_INPUT_DIR}/runICBC_parent_rt_CR.ksh ./.
      cp ${PERT_CHEM_INPUT_DIR}/runICBC_parent_rt_FR.ksh ./.
      cp ${PERT_CHEM_INPUT_DIR}/run_mozbc_rt_CR.csh ./.
      cp ${PERT_CHEM_INPUT_DIR}/run_mozbc_rt_FR.csh ./.
      cp ${PERT_CHEM_INPUT_DIR}/set00_${EXP_SPCS_MAP} ./set00
#
# SELECT MOZART DATA FILE
      export MOZBC_DATA=${NL_UPPER_DATA_FILE_NAME}
#
# CREATE INPUT FILES COARSE DOMAIN
      rm -rf mozbc.ic.inp
      cat << EOF > mozbc.ic.inp
&control
do_bc     = .false.
do_ic     = .true.
domain    = 1
dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
dir_moz   = '${MOZBC_DATA_DIR}'
fn_moz    = '${MOZBC_DATA}'
def_missing_var    = .true.
moz_var_suffix     = '${MOZBC_SUFFIX}'
met_file_prefix    = 'met_em'
met_file_suffix    = '.nc'
met_file_separator = '.'
EOF
      rm -rf mozbc.bc.inp
      cat << EOF > mozbc.bc.inp
&control
do_bc     = .true.
do_ic     = .false.
domain    = 1
dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
dir_moz   = '${MOZBC_DATA_DIR}'
fn_moz    = '${MOZBC_DATA}'
def_missing_var    = .true.
moz_var_suffix     = '${MOZBC_SUFFIX}'
met_file_prefix    = 'met_em'
met_file_suffix    = '.nc'
met_file_separator = '.'
EOF
#
      ./runICBC_parent_rt_CR.ksh
#
# CREATE INPUT FILES FINE DOMAIN
#      rm -rf mozbc.ic.inp
#      cat << EOF > mozbc.ic.inp
#&control
#do_bc     = .false.
#do_ic     = .true.
#domain    = 2
#dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
#dir_moz   = '${MOZBC_DATA_DIR}'
#fn_moz    = '${MOZBC_DATA}'
#def_missing_var    = .true.
#met_file_prefix    = 'met_em'
#met_file_suffix    = '.nc'
#met_file_separator = '.'
#EOF
#      rm -rf mozbc.bc.inp
#      cat << EOF > mozbc.bc.inp
#&control
#do_bc     = .true.
#do_ic     = .false.
#domain    = 2
#dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
#dir_moz   = '${MOZBC_DATA_DIR}'
#fn_moz    = '${MOZBC_DATA}'
#def_missing_var    = .true.
#met_file_prefix    = 'met_em'
#met_file_suffix    = '.nc'
#met_file_separator = '.'
#EOF
#
#      ./runICBC_parent_rt_FR.ksh
#
# GENERATE CHEMISTRY IC/BC ENSEMBLE MEMBERS
#
# CREATE NAMELIST
      export WRFINPEN=wrfinput_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00
      export WRFBDYEN=wrfbdy_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00
      export WRFINPUT_FLD_RW=wrfinput_d${CR_DOMAIN}
      export WRFINPUT_ERR_RW=wrfinput_d${CR_DOMAIN}_err
      export WRFBDY_FLD_RW=wrfbdy_d${CR_DOMAIN}
      mv ${WRFINPEN} ${WRFINPUT_FLD_RW}
      mv ${WRFBDYEN} ${WRFBDY_FLD_RW}
      rm -rf perturb_chem_icbc_corr_nml.nl
      cat << EOF > perturb_chem_icbc_corr_nml.nl
&perturb_chem_icbc_corr_nml
date=${MM}${DD}${HH},
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nchem_spcs=${NSPCS},
pert_path_old='${RUN_DIR}/${PAST_DATE}/wrfchem_chem_icbc',
pert_path_new='${RUN_DIR}/${DATE}/wrfchem_chem_icbc',
nnum_mem=${NUM_MEMBERS},
wrfinput_fld_new='${WRFINPUT_FLD_RW}',
wrfinput_err_new='${WRFINPUT_ERR_RW}',
wrfbdy_fld_new='${WRFBDY_FLD_RW}',
sprd_chem=${SPREAD_FAC},
corr_lngth_hz=${NL_HZ_CORR_LNGTH},
corr_lngth_vt=${NL_VT_CORR_LNGTH},
corr_lngth_tm=${NL_TM_CORR_LNGTH_IC},
corr_tm_delt=${CYCLE_PERIOD},
sw_corr_tm=${NL_SW_CORR_TM},
sw_seed=${NL_SW_SEED},
/
EOF
      rm -rf perturb_chem_icbc_spcs_nml.nl
      cat << EOF > perturb_chem_icbc_spcs_nml.nl
#
# These need to match the species in the respective input files
&perturb_chem_icbc_spcs_nml
ch_chem_spc=${NL_CHEM_ICBC_SPECIES}
/
EOF
#
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
         cp ${WRFINPUT_FLD_RW} ${WRFINPUT_FLD_RW}.${CMEM}   
#         cp ${WRFINPUT_FLD_RW} ${WRFINPUT_ERR_RW}.${CMEM}   
         cp ${WRFBDY_FLD_RW} ${WRFBDY_FLD_RW}.${CMEM}   
         let MEM=MEM+1
      done
      cp ${WRFINPUT_FLD_RW} ${WRFINPUT_FLD_RW}_mean
      cp ${WRFINPUT_FLD_RW} ${WRFINPUT_FLD_RW}_sprd
      cp ${WRFINPUT_FLD_RW} ${WRFINPUT_FLD_RW}_frac
#
      RANDOM=$$
      export JOBRND=${RANDOM}_cr_icbc_pert
#
# SERIAL VERSION
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} perturb_chem_icbc_CORR_RT_MA.exe SERIAL ${ACCOUNT}
#
# PARALLEL VERSION
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_icbc_CORR_RT_MA_MPI.exe PARALLEL ${ACCOUNT}
#
# PARALLEL ON HASWELL
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_has.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_icbc_CORR_RT_MA_MPI.exe PARALLEL ${ACCOUNT}
#
      qsub -Wblock=true job.ksh
#
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
         mv ${WRFINPUT_FLD_RW}.${CMEM} ${WRFINPEN}.${CMEM}
         mv ${WRFBDY_FLD_RW}.${CMEM} ${WRFBDYEN}.${CMEM}
         let MEM=MEM+1
      done
#
# COMBINE WRFCHEM WITH WRF CR PARENT FILES
      ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${CR_DOMAIN} ${WRFINPEN}
      ncks -A ${REAL_DIR}/${WRFINPEN} ${WRFINPEN}
      ncks -A ${REAL_DIR}/${WRFBDYEN} ${WRFBDYEN}
#
# COMBINE WRFCHEM WITH WRF FR DOMAIN PARENT FILES
#      export WRFINPEN=wrfinput_d${FR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00
#      ncks -A ${REAL_DIR}/${WRFINPEN} ${WRFINPEN}
#      ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${FR_DOMAIN} ${WRFINPEN}
#
# LOOP THROUGH ALL MEMBERS IN THE ENSEMBLE
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#
# COMBINE WRFCHEM WITH WRF CR DOMAIN
         export WRFINPEN=wrfinput_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00.${CMEM}
         export WRFBDYEN=wrfbdy_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00.${CMEM}
         ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${CR_DOMAIN} ${WRFINPEN}
         ncks -A ${WRFCHEM_MET_IC_DIR}/${WRFINPEN} ${WRFINPEN}
         ncks -A ${WRFCHEM_MET_BC_DIR}/${WRFBDYEN} ${WRFBDYEN}
#
# COMBINE WRFCHEM WITH WRF FR DOMAIN
#         export WRFINPEN=wrfinput_d${FR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00.${CMEM}
#         ncks -A ${WRFCHEM_MET_IC_DIR}/${WRFINPEN} ${WRFINPEN}
#         ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${FR_DOMAIN} ${WRFINPEN}
#
         let MEM=MEM+1
      done
#
# Clean directory
#      rm *_cr_icbc_pert* job,ksh met_em.d* mozbc* perturb_chem_*
#      rm runICBC_parent_* run_mozbc_rt_* set00* wrfbdy_d01 wrfinput_d01
#      rm wrfbdy_d01_${DATE} wrfinput_do1_${DATE} wrfinput_d01_frac
#      rm wrfinput_d01_mean wrfinput_d01_sprd pert_chem_icbc job.ksh
#      rm wrfbdy_d01_*_:00 wrfinput_d01_*_:00
