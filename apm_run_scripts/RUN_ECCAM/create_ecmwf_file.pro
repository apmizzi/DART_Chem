;==============================================================================
;- Program to update the netcdf files so that it can be read by mozbc
;==============================================================================

pro create_ecmwf_file

 gas_vars = ['ch4_c','hno3','pan','no','c2h6','c3h8','no2','so2','co','hcho','go3']
 gas_name = ['Methane (chemistry)', 'Nitric acid','Peroxyacetyl nitrate','Nitrogen monoxide', $
             'Ethane','Propane','Nitrogen dioxide','Sulphur dioxide','Carbon monoxide',       $
             'Formaldehyde','GEMS Ozone']
 aer_vars = ['aermr01','aermr02','aermr03','aermr04','aermr05','aermr06','aermr07','aermr08', $
             'aermr09','aermr10','aermr11','aermr18']
 aer_name = ['Sea Salt Aerosol (0.03 - 0.5 um) Mixing Ratio', 'Sea Salt Aerosol (0.5 - 5 um) Mixing Ratio', $
             'Sea Salt Aerosol (5 - 20 um) Mixing Ratio', 'Dust Aerosol (0.03 - 0.55 um) Mixing Ratio',     $
             'Dust Aerosol (0.55 - 0.9 um) Mixing Ratio', 'Dust Aerosol (0.9 - 20 um) Mixing Ratio',        $
             'Hydrophilic Organic Matter Aerosol Mixing Ratio', 'Hydrophobic Organic Matter Aerosol Mixing Ratio', $
             'Hydrophilic Black Carbon Aerosol Mixing Ratio', 'Hydrophobic Black Carbon Aerosol Mixing Ratio', $
             'Sulphate Aerosol Mixing Ratio', 'Ammonium aerosol mass mixing ratio']
 lvl_fname = '/scratch/summit/mizzi/ECCAM_DATA/hybrid_coord_L137.nc'
      year = '2020'
    months = ['02']
     ndays = [3]
 id = ncdf_open(lvl_fname, /nowrite)
  ncdf_varget, id, 'hyai', hyai
  ncdf_varget, id, 'hybi', hybi
  ncdf_varget, id, 'hyam', hyam
  ncdf_varget, id, 'hybm', hybm
 ncdf_close, id

 for mn = 0, n_elements(months)-1 do begin
 for dd = 1, ndays[mn] do begin
  if dd lt 10 then day = strcompress('0'+string(dd), /remove_all) $
              else day = strcompress(string(dd), /remove_all)
  print, year+'-'+months[mn]+'-'+day  
 gas_fname = '/scratch/summit/mizzi/ECCAM_DATA/output_gases_fc_'+year+'-'+months[mn]+'-'+day+'.nc'
 aer_fname = '/scratch/summit/mizzi/ECCAM_DATA/output_aerosols_fc_'+year+'-'+months[mn]+'-'+day+'.nc' 
 prs_fname = '/scratch/summit/mizzi/ECCAM_DATA/pres_fc_'+year+'-'+months[mn]+'-'+day+'.nc'

;==============================================================================
 id = ncdf_open(prs_fname, /nowrite)
  ncdf_varget, id, 'lnsp', lnsp
  ncdf_attget, id, 'lnsp', 'scale_factor', sfactor
  ncdf_attget, id, 'lnsp', 'add_offset', offset
  ncdf_attget, id, 'lnsp', 'missing_value', missing_value
 ncdf_close, id
 psurf = float(exp(lnsp * sfactor + offset))
 kz = where(lnsp eq missing_value)
 if kz[0] gt -1 then psurf[kz] = 0.
 
 gas_id = ncdf_open(gas_fname, /nowrite)
  ncdf_varget, gas_id, 'longitude', lon
  ncdf_varget, gas_id, 'latitude', lat
  ncdf_varget, gas_id, 'level', lev
  ncdf_varget, gas_id, 'time', time 
 aer_id = ncdf_open(aer_fname, /nowrite)

 outfile = 'moz0000_'+year+months[mn]+day+'.nc'
 out_id = ncdf_create(outfile, /clobber)
  xdim = ncdf_dimdef(out_id, 'lon', n_elements(lon))
  ydim = ncdf_dimdef(out_id, 'lat', n_elements(lat))
  zdim = ncdf_dimdef(out_id, 'lev', n_elements(lev))
  ldim = ncdf_dimdef(out_id, 'levi', n_elements(lev)+1)
  tdim = ncdf_dimdef(out_id, 'time', /unlimited)
 
  lon_id = ncdf_vardef(out_id, 'lon', [xdim], /float)
  lat_id = ncdf_vardef(out_id, 'lat', [ydim], /float)
  lev_id = ncdf_vardef(out_id, 'lev', [zdim], /short)
  tim_id = ncdf_vardef(out_id, 'time', [tdim], /long)
  hai_id = ncdf_vardef(out_id, 'hyai', [ldim], /double)
   ncdf_attput, id, hai_id, 'long_name', 'hybrid A coefficient at layer interfaces'
   ncdf_attput, id, hai_id, 'units', 'Pa'
  hbi_id = ncdf_vardef(out_id, 'hybi', [ldim], /double)
   ncdf_attput, id, hbi_id, 'long_name', 'hybrid B coefficient at layer interfaces'
   ncdf_attput, id, hbi_id, 'units', '1'
  ham_id = ncdf_vardef(out_id, 'hyam', [zdim], /double)
   ncdf_attput, id, ham_id, 'long_name', 'hybrid A coefficient at layer midpoints'
   ncdf_attput, id, ham_id, 'units', 'Pa'  
  hbm_id = ncdf_vardef(out_id, 'hybm', [zdim], /double)
   ncdf_attput, id, hbm_id, 'long_name', 'hybrid B coefficient at layer midpoints'
   ncdf_attput, id, hbm_id, 'units', '1'

   ncdf_attput, out_id,  tim_id, 'units', 'hours since 1900-01-01 00:00:00.0'
   ncdf_attput, out_id,  tim_id, 'long_name', 'time'
   ncdf_attput, out_id,  tim_id, 'calendar', 'gregorian'

  prs_id = ncdf_vardef(out_id, 'psurf', [xdim, ydim, tdim], /float)
   ncdf_attput, out_id, prs_id, 'long_name', 'surface pressure'
   ncdf_attput, out_id, prs_id, 'units', 'Pa'

   for g = 0, n_elements(gas_vars)-1 do begin
    var_id = ncdf_vardef(out_id, gas_vars[g],  [xdim, ydim, zdim, tdim], /float)
    ncdf_attput, out_id, var_id, 'long_name', gas_name[g]
    ncdf_attput, out_id, var_id, 'units', 'kg kg**-1'
   endfor
   for a = 0, n_elements(aer_vars)-1 do begin
    var_id = ncdf_vardef(out_id, aer_vars[a], [xdim, ydim, zdim, tdim], /float)
    ncdf_attput, out_id, var_id, 'long_name', aer_name[a]
    ncdf_attput, out_id, var_id, 'units', 'kg kg**-1'
   endfor

 ; print, time
   ncdf_control, out_id, /endef
    ncdf_varput, out_id, lon_id, lon
    ncdf_varput, out_id, lat_id, lat
    ncdf_varput, out_id, lev_id, lev
    ncdf_varput, out_id, 'time', time
    ncdf_varput, out_id, prs_id, psurf
    for g = 0, n_elements(gas_vars)-1 do begin
     ncdf_varget, gas_id, gas_vars[g], data
      ncdf_attget, gas_id, gas_vars[g], 'scale_factor', sfactor
      ncdf_attget, gas_id, gas_vars[g], 'add_offset', offset
      ncdf_attget, gas_id, gas_vars[g], 'missing_value', missing_value
      kz = where(data eq missing_value)
      if kz[0] gt -1 then data[kz] = 0.  
      fnl_data = data * sfactor + offset
; Remove negative values
      kz = where(fnl_data lt 0.)
      if kz[0] gt -1 then fnl_data[kz] = 0.
     ncdf_varput, out_id, gas_vars[g], fnl_data 
    endfor 
    for g = 0, n_elements(aer_vars)-1 do begin
     ncdf_varget, aer_id, aer_vars[g], data
      ncdf_attget, aer_id, aer_vars[g], 'scale_factor', sfactor
      ncdf_attget, aer_id, aer_vars[g], 'add_offset', offset
      ncdf_attget, aer_id, aer_vars[g], 'missing_value', missing_value
      kz = where(data eq missing_value)
      if kz[0] gt -1 then data[kz] = 0.
      fnl_data = data * sfactor + offset
; Remove negative values
      kz = where(fnl_data lt 0.)
      if kz[0] gt -1 then data[kz] = 0.
     ncdf_varput, out_id, aer_vars[g], fnl_data
    endfor 
    ncdf_varput, out_id, hai_id, hyai
    ncdf_varput, out_id, hbi_id, hybi
    ncdf_varput, out_id, ham_id, hyam
    ncdf_varput, out_id, hbm_id, hybm 
   ncdf_control, out_id, /redef

 ncdf_close, gas_id
 ncdf_close, aer_id
 ncdf_close, out_id  

 endfor
 endfor
;==============================================================================
end  
