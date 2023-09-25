#!/bin/ksh -aux
#
# Run temporal interpolation for missing background files
# RUN_UNGRIB, RUN_METGRID, and RUN_REAL must all be false for the interpolation and for cycling
# Currently set up for 6 hr forecasts. It can handle up to 24 hr forecasts
export RUN_INTERPOLATE=false
#
# for 2014072212 and 2014072218
# export BACK_DATE=2014072206
# export FORW_DATE=2014072300
# BACK_WT=.3333
# BACK_WT=.6667
#
# for 20142900
# export BACK_DATE=2014072818
# export FORW_DATE=2014072906
# BACK_WT=.5000
#
# for 20142912
# export BACK_DATE=2014072906
# export FORW_DATE=2014072918
# BACK_WT=.5000
#
