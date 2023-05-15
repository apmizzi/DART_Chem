#!/bin/ksh -aux
#
# Assign DART version
   export DART_VER=DART_chem_upgrade
   export DART_DIR=/projects/mizzi/TRUNK/${DART_VER}

# Go to /SCRATCH
   cd /scratch/summit/mizzi
   rm -rf /scratch/summit/mizzi/TEST_IDL
   mkdir -p /scratch/summit/mizzi/TEST_IDL
   cd TEST_IDL
#
# Copy executable
   export FILE=create_ecmwf_file.pro
   rm -rf ${FILE}
   cp ${DART_DIR}/models/wrf_chem/run_scripts/RUN_ECCAM/${FILE} ./.
#
# Create run script
   rm -rf idl_*.err
   rm -rf idl_*.out
   rm -rf job.ksh
   touch job.ksh
   RANDOM=$$
   export JOBRND=${RANDOM}_idl_eccam
   cat << EOFF > job.ksh
#!/bin/ksh -aeux
#SBATCH --account ucb93_summit2
#SBATCH --job-name ${JOBRND}
#SBATCH --qos normal
#SBATCH --time 00:20:00
#SBATCH --output ${JOBRND}.log
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --partition shas
. /etc/profile.d/lmod.sh
module load idl
#
idl << EOF
.compile create_ecmwf_file.pro
create_ecmwf_file
EOF
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOFF
   sbatch -W job.ksh 
