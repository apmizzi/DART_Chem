#!/bin/ksh -aux
echo off
. /usr/share/Modules/init/ksh
module remove netcdf/4.4.1.1_mpt
echo on
#
cd /nobackupp28/amizzi/OUTPUT_DATA/OUTPUT_2005_NOAA_EMISADJ_30MEMS/2005040203/dart_filter
rm *.ncks.tmp
export FILE_DATE=2005-04-02-03:00:00
export LL_FILE_DATE=2005-04-02-03:00:00
export CR_DOMAIN=01
export DART_MEM_STR=13
export NUM_MEMBERS=30
export WRFCHEMI_DARTVARS="E_CO,E_NO,E_NO2,E_SO2"
export WRFFIRECHEMI_DARTVARS="ebu_in_co,ebu_in_no,ebu_in_no2,ebu_in_so2"
#
let MEM=${DART_MEM_STR}
while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
   export CMEM=e${MEM}
   export KMEM=${MEM}
   if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
   if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
   if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
#
# Copy the adjusted emissions fields from the wrfinput files to the emissions input files
   ncks -O -x -v ${WRFCHEMI_DARTVARS} wrfinput_d${CR_DOMAIN}_${CMEM} wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM}
   ncks -O -x -v ${WRFFIRECHEMI_DARTVARS} wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM} wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM}
   ncks -A -C -v ${WRFCHEMI_DARTVARS} wrfinput_d${CR_DOMAIN}_${CMEM} wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
   ncks -A -C -v ${WRFFIRECHEMI_DARTVARS} wrfinput_d${CR_DOMAIN}_${CMEM} wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
   ncrename -O -d chemi_zdim_stag,emissions_zdim wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
   ncrename -O -d fire_zdim_stag,emissions_zdim_stag wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
   rm -rf wrfinput_d${CR_DOMAIN}_${CMEM}
   let MEM=${MEM}+1
done
module load  netcdf/4.4.1.1_mpt
exit
