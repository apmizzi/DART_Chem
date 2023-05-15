#!/bin/ksh -aux
#
# Assign variables
   export DATE_DIR=2020020200
   export DATE_FCST=2020-02-02_00:00:00
   export DOMAIN=01
#
   export PROJECTS_DIR=/projects/mizzi
   export SCRATCH_DIR=/scratch/summit/mizzi

   export TEST_IDL_DIR=${SCRATCH_DIR}/TEST_IDL
   export TEST_CASE_DIR=${SCRATCH_DIR}/real_ECMWF_CAM_TEST/${DATE_DIR}
   export METGRID_DIR=${TEST_CASE_DIR}/metgrid
   export REAL_DIR=${TEST_CASE_DIR}/real
#
# Assign DART version, DART_DIR, and MOZBC_DIR
   export DART_VER=DART_chem_upgrade
   export DART_DIR=${PROJECTS_DIR}/TRUNK/${DART_VER}
   export MOZBC_DIR=${PROJECTS_DIR}/TRUNK/${DART_VER}/models/wrf_chem/run_scripts/RUN_ECCAM/WRF-CHEM_CAM_Converter/mozbcFct
#
# Go to TEST_MOZBC
   export TEST_MOZBC_DIR=${SCRATCH_DIR}/TEST_MOZBC
   cd ${SCRATCH_DIR}
   rm -rf ${TEST_MOZBC_DIR}
   mkdir -p ${TEST_MOZBC_DIR}
   cd ${TEST_MOZBC_DIR}
#
# Copy executable
   export FILE=mozbc
   rm -rf ${FILE}
   cp ${MOZBC_DIR}/${FILE} ./.
#
# Copy met_em files
   export FILE=met_em.d${DOMAIN}.2020-02-02_00:00:00.nc
   cp ${METGRID_DIR}/${FILE} ./.
   export FILE=met_em.d${DOMAIN}.2020-02-02_03:00:00.nc
   cp ${METGRID_DIR}/${FILE} ./.
   export FILE=met_em.d${DOMAIN}.2020-02-02_06:00:00.nc
   cp ${METGRID_DIR}/${FILE} ./.
   export FILE=met_em.d${DOMAIN}.2020-02-02_09:00:00.nc
   cp ${METGRID_DIR}/${FILE} ./.
   export FILE=met_em.d${DOMAIN}.2020-02-02_12:00:00.nc
   cp ${METGRID_DIR}/${FILE} ./.
#
# Copy WRF-Chem IC and BC Files as templates
   export WRFCHEM_IC=wrfinput_d${DOMAIN}_${DATE_FCST}
   export WRFCHEM_BC=wrfbdy_d${DOMAIN}_${DATE_FCST}
   cp ${REAL_DIR}/${WRFCHEM_IC} ./wrfinput_d${DOMAIN}
   cp ${REAL_DIR}/${WRFCHEM_BC} ./wrfbdy_d${DOMAIN}
#
# Copy pre-preocessed ECMWF CAM files 
   export FILE=moz0000_20200201.nc
   cp ${TEST_IDL_DIR}/${FILE} ./
   export FILE=moz0000_20200202.nc
   cp ${TEST_IDL_DIR}/${FILE} ./
   export FILE=moz0000_20200203.nc
   cp ${TEST_IDL_DIR}/${FILE} ./
#
# Create mozbc input namelist
   export FILE=mozbc_inp
   rm -rf ${FILE}
   cat << EOF > ${FILE}
&control
do_bc              = .true.
do_ic              = .true.
domain             = 1
dir_wrf            = '${TEST_MOZBC_DIR}/'
dir_moz            = '${TEST_MOZBC_DIR}/'
fn_moz             = moz0000_20200202.nc 
moz_var_suffix     = ' '
def_missing_var    =.true.
met_file_prefix    = 'met_em'
met_file_suffix    = '.nc'
met_file_separator = '.'
src_model          = 'ECMWF' 
src_ps_name        = 'psurf'
spc_map            = 'co -> 28*co', 
                     'o3 -> 48*go3',
                     'no -> 30*no',
                     'no2 -> 46*no2', 
                     'hno3 -> 63*hno3', 
                     'ch4 -> 16*ch4_c', 
                     'hcho -> 30*hcho', 
                     'c2h6 -> 30*c2h6', 
                     'pan -> 121*pan', 
                     'so2 -> 64*so2', 
                     'c3h8 -> 44*c3h8',
/ 
EOF
#
# Create run script
   rm -rf mozbc_*.err
   rm -rf mozbc_*.out
   rm -rf job.ksh
   touch job.ksh
   RANDOM=$$
   export JOBRND=${RANDOM}_mozbc
   cat << EOF > job.ksh
#!/bin/ksh -aeux
#SBATCH --account ucb93_summit2
#SBATCH --job-name ${JOBRND}
#SBATCH --qos normal
#SBATCH --time 00:20:00
#SBATCH --output ${JOBRND}.log
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --partition shas
./mozbc < mozbc_inp >mozbc_out
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOF
   sbatch -W job.ksh
