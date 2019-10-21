#!/bin/csh
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download
#
# DART $Id: quickbuild.csh 13159 2019-05-03 19:05:37Z thoar@ucar.edu $
#
# This script compiles all executables in this directory.

\rm -f *.o *.mod Makefile

set MODEL = "WRF-Chem/DART RUN_FINN_FIRE"

@ n = 0

#----------------------------------------------------------------------
# Build all the single-threaded targets
#----------------------------------------------------------------------

foreach TARGET ( mkmf_* )

   set PROG = `echo $TARGET | sed -e 's#mkmf_##'`

   switch ( $TARGET )
   case mkmf_you_wanna_skip:
      breaksw
   default:
      @ n = $n + 1
      echo
      echo "---------------------------------------------------"
      echo "${MODEL} build number ${n} is ${PROG}" 
      \rm -f ${PROG}
      csh $TARGET || exit $n
      make        || exit $n
      breaksw
   endsw
end

\rm -f *.o *.mod input.nml*_default Makefile .cppdefs

echo
echo "Success: All ${MODEL} programs compiled."  
echo

exit 0

# <next few lines under version control, do not edit>
# $URL: https://svn-dares-dart.cgd.ucar.edu/DART/tags/wrf-chem.r13172/models/wrf_chem/run_scripts/RUN_FINN_FIRE/work/quickbuild.csh $
# $Revision: 13159 $
# $Date: 2019-05-03 13:05:37 -0600 (Fri, 03 May 2019) $

