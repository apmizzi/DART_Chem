#!/bin/ksh -aux
   cd ${RUN_DIR}/${DATE}/wrfchem_chem_icbc
#
# PERTURB CHEM ICBC
   export NL_SW_SEED=true
   export NL_SW_CORR_TM=true
   if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then export NL_SW_CORR_TM=false; fi
#
   cp ${METGRID_DIR}/met_em.d${CR_DOMAIN}.*.nc ./.
   cp ${PERT_CHEM_INPUT_DIR}/work/perturb_chem_icbc_CORR_RT_MA_MPI_PERT_TEST.exe ./.
   cp ${PERT_CHEM_INPUT_DIR}/work/mozbc.exe ./mozbc.exe
#
# SELECT MOZART DATA FILE
   export MOZBC_DATA=${NL_UPPER_DATA_FILE_NAME}
#
# CREATE INPUT FILES COARSE DOMAIN
   export L_PAST_DATE=${PAST_DATE}00   
   export L_PAST_YY=$(echo $L_PAST_DATE | cut -c1-4)
   export L_PAST_MM=$(echo $L_PAST_DATE | cut -c5-6)
   export L_PAST_DD=$(echo $L_PAST_DATE | cut -c7-8)
   export L_PAST_HH=$(echo $L_PAST_DATE | cut -c9-10)
   export L_PAST_MN=$(echo $L_PAST_DATE | cut -c11-12)
   export L_PAST_SS=$(echo $L_PAST_DATE | cut -c13-14)
   export L_PAST_SS=00
   export L_DATE=${DATE}00   
   export L_YY=$(echo $L_DATE | cut -c1-4)
   export L_MM=$(echo $L_DATE | cut -c5-6)
   export L_DD=$(echo $L_DATE | cut -c7-8)
   export L_HH=$(echo $L_DATE | cut -c9-10)
   export L_MN=$(echo $L_DATE | cut -c11-12)
   export L_SS=$(echo $L_DATE | cut -c13-14)
   export L_SS=00
#
   export WRFINPUT_FILE=wrfinput_d${CR_DOMAIN}
   export WRFBDY_FILE=wrfbdy_d${CR_DOMAIN}
   export WRFINPUT_FULL=wrfinput_d01_${L_YY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
   export WRFBDY_FULL=wrfbdy_d01_${L_YY}-${L_MM}-${L_DD}_${L_HH}:${L_MN}:${L_SS}
   export WRFINPUT_PAST_FULL=wrfinput_d${CR_DOMAIN}_${L_PAST_YY}-${L_PAST_MM}-${L_PAST_DD}_${L_PAST_HH}:00:00
   export WRFBDY_PAST_FULL=wrfbdy_d${CR_DOMAIN}_${L_PAST_YY}-${L_PAST_MM}-${L_PAST_DD}_${L_PAST_HH}:00:00
   export WRFINPEN=wrfinput_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
   export WRFBDYEN=wrfbdy_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
   cp ${REAL_DIR}/${WRFINPUT_FULL} ./
   cp ${REAL_DIR}/${WRFBDY_FULL} ./
   cp ${WRFINPUT_FULL} ${WRFINPUT_FILE}
   cp ${WRFBDY_FULL} ${WRFBDY_FILE}
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
spc_map =  'api -> 0.5*C10H16',
           'lim -> 0.5*C10H16',
           'hc3 -> C3H8',
           'olt -> C5H8',
           'ald -> CH3CHO',
           'ket -> CH3COCH3',
           'moh -> CH3OH',
            'o3 -> O3',
          'h2o2 -> H2O2',
           'ho2 -> ISOOH',
          'macr -> MACR',
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
           'pan -> PAN',
          'mpan -> MPAN',
           'nh3 -> NH3',
           'eoh -> C2H5OOH',
           'paa -> CH3COOOH',
        'orgpai -> 0.1*OC;0.414e9',
        'orgpaj -> 0.9*OC;0.414e9',
           'eci -> 0.1*BC;0.414e9',
           'ecj -> 0.9*BC;0.414e9',
         'so4ai -> 0.1*SULF;3.31e9',
         'so4aj -> 0.9*SULF;3.31e9',
         'no3ai -> 0.1*NITR;2.13e9',
         'no3aj -> 0.9*NITR;2.13e9',
          'seas -> SALT;2.e9',
         'soila -> DUST;1.171e9',
         'antha -> 0.041*OC;1.e9',
         'nh4ai -> 0.1*NH4;0.622e9',
         'nh4aj -> 0.9*NH4;0.622e9',
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
spc_map =  'api -> 0.5*C10H16',
           'lim -> 0.5*C10H16',
           'hc3 -> C3H8',
           'olt -> C5H8',
           'ald -> CH3CHO',
           'ket -> CH3COCH3',
           'moh -> CH3OH',
            'o3 -> O3',
          'h2o2 -> H2O2',
           'ho2 -> ISOOH',
          'macr -> MACR',
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
           'pan -> PAN',
          'mpan -> MPAN',
           'nh3 -> NH3',
           'eoh -> C2H5OOH',
           'paa -> CH3COOOH',
        'orgpai -> 0.1*OC;0.414e9',
        'orgpaj -> 0.9*OC;0.414e9',
           'eci -> 0.1*BC;0.414e9',
           'ecj -> 0.9*BC;0.414e9',
         'so4ai -> 0.1*SULF;3.31e9',
         'so4aj -> 0.9*SULF;3.31e9',
         'no3ai -> 0.1*NITR;2.13e9',
         'no3aj -> 0.9*NITR;2.13e9',
          'seas -> SALT;2.e9',
         'soila -> DUST;1.171e9',
         'antha -> 0.041*OC;1.e9',
         'nh4ai -> 0.1*NH4;0.622e9',
         'nh4aj -> 0.9*NH4;0.622e9',
/
EOF
#
   ./mozbc.exe < wrfchem.namelist.input > log_bc.txt  2>&1
#
# GENERATE CHEMISTRY IC/BC ENSEMBLE MEMBERS   
#
# CREATE NAMELIST
   cp ${WRFINPUT_FILE} ${WRFINPUT_FULL}
   cp ${WRFBDY_FILE} ${WRFBDY_FULL}
   rm -rf perturb_chem_icbc_corr_nml.nl
   cat << EOF > perturb_chem_icbc_corr_nml.nl
&perturb_chem_icbc_corr_nml
date=${L_MM}${L_DD}${L_HH},
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nchem_spcs=${NSPCS},
wrfinput_path_old='${RUN_DIR}/${PAST_DATE}/wrfchem_chem_icbc',
wrfinput_path_new='${RUN_DIR}/${DATE}/wrfchem_chem_icbc',
wrfbdy_path_old='${RUN_DIR}/${PAST_DATE}/wrfchem_chem_icbc',
wrfbdy_path_new='${RUN_DIR}/${DATE}/wrfchem_chem_icbc',
wrfinput_file_old='${WRFINPUT_PAST_FULL}',
wrfinput_file_new='${WRFINPUT_FILE}',
wrfbdy_file_old='${WRFBDY_PAST_FULL}',
wrfbdy_file_new='${WRFBDY_FILE}',
nnum_mems=${NUM_MEMBERS},
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
      cp ${WRFINPUT_FULL} ${WRFINPUT_FILE}.${CMEM}   
      cp ${WRFBDY_FULL} ${WRFBDY_FILE}.${CMEM}   
      let MEM=MEM+1
   done
#
   RANDOM=$$
   export JOBRND=${RANDOM}_cr_icbc_pert
#
# PARALLEL ON ${MODEL}
   ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_icbc_CORR_RT_MA_MPI_PERT_TEST.exe PARALLEL ${ACCOUNT} ${PERT_MODEL}
#
   qsub -Wblock=true job.ksh
   mv index.html index_pert.html
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
   mv wrfinput_d${CR_DOMAIN}.\${CMEM} ${WRFINPEN}.\${CMEM}
   mv wrfbdy_d${CR_DOMAIN}.\${CMEM} ${WRFBDYEN}.\${CMEM}
   let MEM=MEM+1
done
#
# COMBINE WRFCHEM WITH WRF CR PARENT FILES
ncks -A ${REAL_DIR}/${WRFINPEN} ${WRFINPEN}
ncks -A ${REAL_DIR}/${WRFBDYEN} ${WRFBDYEN}
#
# LOOP THROUGH ALL MEMBERS IN THE ENSEMBLE
let MEM=1
while [[ \${MEM} -le ${NUM_MEMBERS} ]]; do
   export CMEM=e\${MEM}
   if [[ \${MEM} -lt 100 ]]; then export CMEM=e0\${MEM}; fi
   if [[ \${MEM} -lt 10  ]]; then export CMEM=e00\${MEM}; fi
#
# COMBINE WRFCHEM WITH WRF CR DOMAIN
   export LWRFINPEN=wrfinput_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00.\${CMEM}
   export LWRFBDYEN=wrfbdy_d${CR_DOMAIN}_${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00.\${CMEM}
   ncks -A ${WRFCHEM_MET_IC_DIR}/\${LWRFINPEN} \${LWRFINPEN}
   ncks -A ${WRFCHEM_MET_BC_DIR}/\${LWRFBDYEN} \${LWRFBDYEN}
   let MEM=MEM+1
done
EOF
   TRANDOM=$$
   export JOBRND=${TRANDOM}_nco
   ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
   qsub -Wblock=true job.ksh
   mv index.html index_nco.html
#   
# Clean directory
#   rm *_cr_icbc_pert* job,ksh met_em.d* mozbc* perturb_chem_*
#   rm runICBC_parent_* run_mozbc_rt_* set00* wrfbdy_d01 wrfinput_d01
#   rm wrfbdy_d01_${DATE} wrfinput_do1_${DATE} wrfinput_d01_frac
#   rm wrfinput_d01_mean wrfinput_d01_sprd pert_chem_icbc job.ksh
#   rm wrfbdy_d01_*_:00 wrfinput_d01_*_:00
