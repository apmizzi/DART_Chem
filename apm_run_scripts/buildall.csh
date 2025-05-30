#!/bin/csh
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download

set SNAME = $0
set clobber

set startdir=`pwd`

foreach project ( RUN_FINN_FIRE RUN_MEGAN_BIO RUN_PERT_CHEM/ICBC_PERT \
                  RUN_PERT_CHEM/EMISS_PERT RUN_EMISS_INV RUN_WES_COLDENS \
                  RUN_BIAS_CORR RUN_TIME_INTERP )

   echo
   echo "==================================================="
   echo "Building $project support."
   echo "==================================================="
   echo

   set dir = $project
   set FAILURE = 0

   switch ("$dir")

      default:
         cd $dir/work
         echo "building in `pwd`"
         ./quickbuild.csh || set FAILURE = 1
      breaksw
         
   endsw

   if ( $FAILURE != 0 ) then
      echo
      echo "ERROR unsuccessful build in $dir"
      echo "ERROR unsuccessful build in $dir"
      echo "ERROR unsuccessful build in $dir"
      echo
      exit -1
   endif

   cd $startdir
end

exit 0

