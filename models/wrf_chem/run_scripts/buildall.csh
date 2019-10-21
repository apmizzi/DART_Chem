#!/bin/csh
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download
#
# DART $Id: buildall.csh 13159 2019-05-03 19:05:37Z thoar@ucar.edu $

set SNAME = $0
set clobber

set startdir=`pwd`

foreach project ( RUN_CHINA_EPA RUN_CLOSEST_MEMBER RUN_EMISS_INV \
                  RUN_FINN_FIRE RUN_LOCALIZE_OBS_SEQ RUN_MEGAN_BIO \
                  RUN_PERT_CHEM/EMISS_PERT RUN_PERT_CHEM/ICBC_PERT \
                  RUN_TIME_INTERP RUN_WES_COLDENS )

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

# <next few lines under version control, do not edit>
# $URL: https://svn-dares-dart.cgd.ucar.edu/DART/tags/wrf-chem.r13172/models/wrf_chem/run_scripts/buildall.csh $
# $Revision: 13159 $
# $Date: 2019-05-03 13:05:37 -0600 (Fri, 03 May 2019) $

