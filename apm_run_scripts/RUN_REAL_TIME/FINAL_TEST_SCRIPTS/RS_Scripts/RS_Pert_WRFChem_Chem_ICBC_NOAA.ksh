#!/bin/ksh -aux
   cd ${RUN_DIR}/${DATE}/wrfchem_chem_icbc
#
# PERTURB CHEM ICBC
   export NL_SW_CORR_TM=false
   if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then export NL_SW_CORR_TM=true; fi
   export NL_SW_SEED=true
#
   cp ${METGRID_DIR}/met_em.d${CR_DOMAIN}.*.nc ./.
#   cp ${METGRID_DIR}/met_em.d${FR_DOMAIN}.*.nc ./.
   cp ${PERT_CHEM_INPUT_DIR}/work/perturb_chem_icbc_CORR_RT_MA_MPI.exe ./.
   cp ${AISH_PERT_CHEM_INPUT_DIR}/work/mozbc.exe ./mozbc.exe
#
# SELECT MOZART DATA FILE
   export MOZBC_DATA=${NL_UPPER_DATA_FILE_NAME}
#
# CREATE INPUT FILES COARSE DOMAIN
   export L_DATE=${DATE}00   
   export L_YY=$(echo $L_DATE | cut -c1-4)
   export L_MM=$(echo $L_DATE | cut -c5-6)
   export L_DD=$(echo $L_DATE | cut -c7-8)
   export L_HH=$(echo $L_DATE | cut -c9-10)
   export L_MN=$(echo $L_DATE | cut -c11-12)
   export L_SS=$(echo $L_DATE | cut -c13-14)
   export L_SS=00
#   if [[ ${L_HH} -ge 00 && ${L_HH} -lt 03 ]]; then export L_HH=00; fi
#   if [[ ${L_HH} -ge 03 && ${L_HH} -lt 06 ]]; then export L_HH=03; fi
#   if [[ ${L_HH} -ge 12 && ${L_HH} -lt 18 ]]; then export L_HH=12; fi
#   if [[ ${L_HH} -ge 18 && ${L_HH} -lt 24 ]]; then export L_HH=18; fi
#
   export WRFINP_CR=wrfinput_d01_${L_YY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
   export WRFBDY_CR=wrfbdy_d01_${L_YY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
   cp ${REAL_DIR}/${WRFINP_CR} ./
   cp ${REAL_DIR}/${WRFBDY_CR} ./
   mv ${WRFINP_CR} wrfinput_d01
   mv ${WRFBDY_CR} wrfbdy_d01
#
# CREATE ICs   
   rm -rf wrfchem.namelist.input
   cat << EOF > wrfchem.namelist.input
&control
do_bc     = .false.
do_ic     = .true.
domain    = ${MAX_DOMAINS}
dir_wrf   = './'
dir_moz   = '${MOZBC_DATA_DIR}/${YYYY}/${MM}'
fn_moz    = '${MOZBC_DATA}'
bdy_cond_file_prefix='wrfbdy'
init_cond_file_prefix='wrfinput'
def_missing_var    = .true.
met_file_prefix    = 'met_em'
met_file_suffix    = '.nc'
met_file_separator = '.'
moz_var_suffix     = '${MOZBC_SUFFIX}'
spc_map =  'o3 -> O3',
           'h2o2 -> H2O2',
           'no -> NO',
           'no2 -> NO2',
           'n2o5 -> N2O5',
           'hno3 -> HNO3',
           'so2 -> SO2',
           'co -> CO',
           'eth -> C2H6',
           'ete -> C2H4',
           'iso -> C5H8',
           'hcho -> CH2O',
           'macr -> MACR',
           'pan -> PAN',
           'mpan -> MPAN',
           'nh3 -> NH3',
           'moh -> CH3OH',
           'paa -> CH3COOOH',
           'eoh -> C2H5OOH',
/
EOF
#
   ./mozbc.exe < wrfchem.namelist.input > log_ic.txt 2>&1
#
# CREATE BCs
   rm -rf wrfchem.namelist.input
   cat << EOF > wrfchem.namelist.input
&control
do_bc     = .true.
do_ic     = .false.
domain    = ${MAX_DOMAINS}
dir_wrf   = './'
dir_moz   = '${MOZBC_DATA_DIR}/${YYYY}/${MM}'
fn_moz    = '${MOZBC_DATA}'
bdy_cond_file_prefix='wrfbdy'
init_cond_file_prefix='wrfinput'
def_missing_var    = .true.
met_file_prefix    = 'met_em'
met_file_suffix    = '.nc'
met_file_separator = '.'
moz_var_suffix     = '${MOZBC_SUFFIX}'
spc_map =  'o3 -> O3',
           'h2o2 -> H2O2',
           'no -> NO',
           'no2 -> NO2',
           'n2o5 -> N2O5',
           'hno3 -> HNO3',
           'so2 -> SO2',
           'co -> CO',
           'eth -> C2H6',
           'ete -> C2H4',
           'iso -> C5H8',
           'hcho -> CH2O',
           'macr -> MACR',
           'pan -> PAN',
           'mpan -> MPAN',
           'nh3 -> NH3',
           'moh -> CH3OH',
           'paa -> CH3COOOH',
           'eoh -> C2H5OOH',
/
EOF
#
   ./mozbc.exe < wrfchem.namelist.input > log_bc.txt  2>&1
#
# CREATE INPUT FILES FINE DOMAIN (APM this is the old code version)
# Use the CR code as a templaste for the new FR code   
#   rm -rf mozbc.ic.inp
#   cat << EOF > mozbc.ic.inp
#&control
#do_bc     = .false.
#do_ic     = .true.
#domain    = 2
#dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
#dir_moz   = '${MOZBC_DATA_DIR}/${YYYY}'
#fn_moz    = '${MOZBC_DATA}'
#def_missing_var    = .true.
#met_file_prefix    = 'met_em'
#met_file_suffix    = '.nc'
#met_file_separator = '.'
#EOF
#   rm -rf mozbc.bc.inp
#   cat << EOF > mozbc.bc.inp
#&control
#do_bc     = .true.
#do_ic     = .false.
#domain    = 2
#dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
#dir_moz   = '${MOZBC_DATA_DIR}/${YYYY}'
#fn_moz    = '${MOZBC_DATA}'
#def_missing_var    = .true.
#met_file_prefix    = 'met_em'
#met_file_suffix    = '.nc'
#met_file_separator = '.'
#EOF
#
#   ./runICBC_parent_rt_FR.ksh
#
# GENERATE CHEMISTRY IC/BC ENSEMBLE MEMBERS   
   mv wrfinput_d01 ${WRFINP_CR}
   mv wrfbdy_d01 ${WRFBDY_CR}
#
# CREATE NAMELIST
   export WRFINPEN=wrfinput_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
   export WRFBDYEN=wrfbdy_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
   export WRFINPUT_FLD_RW=wrfinput_d${CR_DOMAIN}
   export WRFINPUT_ERR_RW=wrfinput_d${CR_DOMAIN}_err
   export WRFBDY_FLD_RW=wrfbdy_d${CR_DOMAIN}
   mv ${WRFINPEN} ${WRFINPUT_FLD_RW}
   mv ${WRFBDYEN} ${WRFBDY_FLD_RW}
   rm -rf perturb_chem_icbc_corr_nml.nl
   cat << EOF > perturb_chem_icbc_corr_nml.nl
&perturb_chem_icbc_corr_nml
date=${L_MM}${L_DD}${L_HH},
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nchem_spcs=${NSPCS},
pert_path_old='${RUN_DIR}/${PAST_DATE}/wrfchem_chem_icbc',
pert_path_new='${RUN_DIR}/${DATE}/wrfchem_chem_icbc',
nnum_mems=${NUM_MEMBERS},
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
      cp ${WRFINPUT_FLD_RW} ${WRFINPUT_ERR_RW}.${CMEM}   
      cp ${WRFBDY_FLD_RW} ${WRFBDY_FLD_RW}.${CMEM}   
      let MEM=MEM+1
   done
#
   RANDOM=$$
   export JOBRND=${RANDOM}_cr_icbc_pert
#
# PARALLEL ON ${MODEL}
   ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_icbc_CORR_RT_MA_MPI.exe PARALLEL ${ACCOUNT} ${PERT_MODEL}
#
   qsub -Wblock=true job.ksh
#
# Recenter the perturbed ensemble
   rm jobx.ksh
   touch jobx.ksh
   chmod +x jobx.ksh
   cat<<EOF > jobx.ksh
#!/bin/ksh -aux
ncea -O -n ${NUM_MEMBERS},3,1 wrfinput_d${CR_DOMAIN}.e001 ens_mean_inp
ncea -O -n ${NUM_MEMBERS},3,1 wrfbdy_d${CR_DOMAIN}.e001 ens_mean_bdy
ncdiff -O ens_mean_inp wrfinput_d01 mean_diff_inp
ncdiff -O ens_mean_bdy wrfbdy_d01 mean_diff_bdy
let MEM=1
while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
   export CMEM=e\${MEM}
   if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
   if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
   ncdiff -O wrfinput_d${CR_DOMAIN}.\${CMEM} mean_diff_inp wrfinput_d${CR_DOMAIN}.\${CMEM}
   ncdiff -O wrfbdy_d${CR_DOMAIN}.\${CMEM} mean_diff_bdy wrfbdy_d${CR_DOMAIN}.\${CMEM}
   let MEM=MEM+1
done
ncea -O -n ${NUM_MEMBERS},3,1 wrfinput_d${CR_DOMAIN}.e001 new_mean_inp
ncea -O -n ${NUM_MEMBERS},3,1 wrfbdy_d${CR_DOMAIN}.e001 new_mean_bdy
#
let MEM=1
while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
export CMEM=e\${MEM}
   if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
   if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
   mv ${WRFINPUT_FLD_RW}.\${CMEM} ${WRFINPEN}.\${CMEM}
   mv ${WRFBDY_FLD_RW}.\${CMEM} ${WRFBDYEN}.\${CMEM}
   let MEM=MEM+1
done
#
# COMBINE WRFCHEM WITH WRF CR PARENT FILES
#ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${CR_DOMAIN} ${WRFINPEN}
ncks -A ${REAL_DIR}/${WRFINPEN} ${WRFINPEN}
ncks -A ${REAL_DIR}/${WRFBDYEN} ${WRFBDYEN}
#
# COMBINE WRFCHEM WITH WRF FR DOMAIN PARENT FILES
#export WRFINPEN=wrfinput_d${FR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00
#ncks -A ${REAL_DIR}/${WRFINPEN} ${WRFINPEN}
#ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${FR_DOMAIN} ${WRFINPEN}
#
# LOOP THROUGH ALL MEMBERS IN THE ENSEMBLE
let MEM=1
while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
   export CMEM=e\${MEM}
   if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
   if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
#
# COMBINE WRFCHEM WITH WRF CR DOMAIN
   export WRFINPEN=wrfinput_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00.\${CMEM}
   export WRFBDYEN=wrfbdy_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00.\${CMEM}
#   ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${CR_DOMAIN} ${WRFINPEN}
   ncks -A ${WRFCHEM_MET_IC_DIR}/\${WRFINPEN} \${WRFINPEN}
   ncks -A ${WRFCHEM_MET_BC_DIR}/\${WRFBDYEN} \${WRFBDYEN}
#
# COMBINE WRFCHEM WITH WRF FR DOMAIN
#   export WRFINPEN=wrfinput_d${FR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00.\${CMEM}
#   ncks -A ${WRFCHEM_MET_IC_DIR}/\${WRFINPEN} \${WRFINPEN}
#   ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${FR_DOMAIN} \${WRFINPEN}
#
   let MEM=MEM+1
done
EOF
   TRANDOM=$$
   export JOBRND=${TRANDOM}_nco
   ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
   qsub -Wblock=true job.ksh
#  rm ens_mean_inp mean_diff_inp
#  rm ens_mean_bdy mean_diff_bdy
#
#
# Clean directory
#   rm *_cr_icbc_pert* job,ksh met_em.d* mozbc* perturb_chem_*
#   rm runICBC_parent_* run_mozbc_rt_* set00* wrfbdy_d01 wrfinput_d01
#   rm wrfbdy_d01_${DATE} wrfinput_do1_${DATE} wrfinput_d01_frac
#   rm wrfinput_d01_mean wrfinput_d01_sprd pert_chem_icbc job.ksh
#   rm wrfbdy_d01_*_:00 wrfinput_d01_*_:00
