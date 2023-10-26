#!/usr/bin/env python
from ecmwfapi import ECMWFDataServer
server = ECMWFDataServer()
server.retrieve({
    "origin"   : "ecmwf",
    "levtype"  : "sfc",
    "number"   : "1",
    "expver"   : "prod",
    "dataset"  : "tigge",
    "step"     : "0/6/12/18",
    "area"     : "70/-130/30/-60",
    "grid"     : "2/2",
    "param"    : "167",
    "time"     : "00/12",
    "date"     : "2014-11-01",
    "type"     : "pf",
    "class"    : "ti", 
    "target"   : "tigge_2014-11-01_0012.grib"
})

