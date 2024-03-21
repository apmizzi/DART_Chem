! Copyright 2019 NCAR/ACOM
! 
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
! 
!     http://www.apache.org/licenses/LICENSE-2.0
! 
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
!
! DART $Id: consolidate_cmaq_files.f90 13171 2019-05-09 16:42:36Z thoar@ucar.edu $

! code to consolidate all cmaq input files into a single DART input file
! to remove variable ncks -x -v variable_name input.nc output.nc
! to rename a dimension ncrename -d old_dim,new_dim input.nc
!
program main
   use netcdf
   implicit none
!
! version controlled file description for error handling, do not edit
   character(len=*), parameter :: source   = 'consolidate_cmaq_files.f90'
   character(len=*), parameter :: revision = ''
   character(len=*), parameter :: revdate  = ''
   integer, parameter          :: DateStrLen = 19
!
   integer                                      :: ncol,nrow,nlay,ntim,nvar,idx,new_var
   integer                                      :: nlay_add,nlay_out,ntim_add,ntim_out
   integer                                      :: ncol_id,nrow_id,nlay_id,ntim_id,nvar_id
   integer                                      :: num_mems,num_2d_vars,num_3d_vars
   integer                                      :: unit,ivar,imem,iflg,idx_sav,start_mem
   integer                                      :: year,month,day,hour,minute,second,ddd
   integer                                      :: rc,f_id,time_id,length_id,times_id
   integer(kind=4),dimension(:,:,:),allocatable :: tflag
   integer(kind=4),dimension(:,:,:),allocatable :: tflag_out
   real,dimension(:,:,:,:),allocatable          :: cmaq_2d_data
   real,dimension(:,:,:,:),allocatable          :: cmaq_3d_data
   real,dimension(:,:,:,:),allocatable          :: data_out
   character(len=200)                           :: cmaq_old_path,cmaq_new_path
   character(len=200)                           :: cmaq_input_file,grid2d_file
   character(len=200)                           :: met2d_file,met3d_file
   character(len=200)                           :: file_grid2d,file_met2d,file_met3d
   character(len=200)                           :: file_cmaq,file_input,file_output
   character(len=200)                           :: cmem,fld,datestr
   character(len=200),dimension(:),allocatable  :: list_2d_vars,list_3d_vars
   character(len=10)                            :: ch_year,ch_month,ch_day,ch_hour, &
                                                   ch_minute,ch_second
   character(len=DateStrLen)                    :: Times
!
   namelist /cmaq_dimensions_nml/num_mems,num_2d_vars,num_3d_vars
!
   namelist /consolidate_cmaq_files_nml/cmaq_old_path,cmaq_new_path,cmaq_input_file, &
   grid2d_file,met2d_file,met3d_file,list_2d_vars,list_3d_vars
!
! Read namelist   
   unit=20
   open(unit=unit,file='cmaq_dimensions_nml',form='formatted', &
   status='old',action='read') 
   read(unit,cmaq_dimensions_nml)
   close(unit)
!
! Allocate arrays
   allocate(list_2d_vars(num_2d_vars))
   allocate(list_3d_vars(num_3d_vars))
!
! Read namelist
   unit=20
   open(unit=unit,file='consolidate_cmaq_files_nml',form='formatted', &
   status='old',action='read') 
   read(unit,consolidate_cmaq_files_nml)
   close(unit)
!
! Transfer 2d variables
!   do ivar=1,num_2d_vars
   do ivar=1,0
      print *, 'CMAQ variable ',trim(list_2d_vars(ivar))
      start_mem=1
      do imem=start_mem,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('e',i3)"),imem
!
         file_grid2d=trim(cmaq_old_path)//'/run_'//trim(cmem)//'/'//trim(grid2d_file)
         file_met2d=trim(cmaq_old_path)//'/run_'//trim(cmem)//'/'//trim(met2d_file)
         file_cmaq=trim(cmaq_new_path)//'/'//trim(cmaq_input_file)//'.'//trim(cmem)
!
         iflg=0         
         file_input=trim(file_met2d)
         if(trim(list_2d_vars(ivar)).eq.'LAT' .or. &
         trim(list_2d_vars(ivar)).eq.'LON' .or. &
         trim(list_2d_vars(ivar)).eq.'HT' .or. &
         trim(list_2d_vars(ivar)).eq.'LWMASK') then
            iflg=1
            file_input=trim(file_grid2d)
         endif
         print *, 'APM: use ',trim(file_input) 
!
! get dimensions for variable to be added to the cmaq chemistry output file
         call get_cmaq_dims(file_input,ncol,nrow,nlay,ntim,nvar,ncol_id, &
         nrow_id,nlay_id,ntim_id,nvar_id)
         ntim_add=ntim
         nlay_add=nlay
!
! get the variable to be added to the cmaq chemistry output file
         allocate(cmaq_2d_data(ncol,nrow,nlay,ntim))
         allocate(data_out(ncol,nrow,nlay,1))
         allocate(tflag(2,nvar,ntim))
         call get_cmaq_data(file_input,list_2d_vars(ivar),cmaq_2d_data,ncol,nrow,nlay,ntim,nvar,tflag)
!         
! get dimensions from the cmaq chemistry output file
         file_output=trim(file_cmaq)
         call get_cmaq_dims(file_output,ncol,nrow,nlay,ntim,nvar,ncol_id, &
         nrow_id,nlay_id,ntim_id,nvar_id)
         allocate(cmaq_3d_data(ncol,nrow,nlay,ntim))
         ntim_out=ntim
         nlay_out=nlay
!
! get the date/time information from the cmaq chemistry output file
         allocate(tflag_out(2,nvar,ntim))
         fld='O3'
         call get_cmaq_data(file_output,fld,cmaq_3d_data,ncol,nrow,nlay,ntim,nvar,tflag_out)
!
! find the corresponding date/time index in the variable to be added to the cmaq chemistry output file
         idx_sav=1
         if(iflg.eq.0) then
            do idx=1,ntim_add
               if(tflag(1,ivar,idx).eq.tflag_out(1,ivar,1) .and. &
               tflag(2,ivar,idx).eq.tflag_out(2,ivar,1)) then
                  iflg=1
                  idx_sav=idx
                  exit
               endif
            enddo
            if(iflg.eq.0) then
               print *, 'APM: cmaq output file time/date not found'
               stop
            endif
         endif
!         print *, 'APM: time check 1 ',tflag(1,ivar,idx_sav),tflag_out(1,ivar,1)
!         print *, 'APM: time check 2 ',tflag(2,ivar,idx_sav),tflag_out(2,ivar,1)
!
! transfer DATE/TIME data
         data_out(:,:,:,1)=cmaq_2d_data(:,:,:,idx_sav)
!
! write variable to the cmaq chemistry output file
         call put_cmaq_data(file_output,list_2d_vars(ivar),data_out,ncol,nrow,nlay_add,1)
!
!  copy attritutes
         call copy_cmaq_att(file_input,file_output,list_2d_vars(ivar))         
!
         deallocate(cmaq_2d_data)
         deallocate(cmaq_3d_data)
         deallocate(data_out)
         deallocate(tflag,tflag_out)
      enddo
   enddo
   deallocate(list_2d_vars)
!
! Transfer 3d variables
!   do ivar=1,num_3d_vars
   do ivar=1,0
      print *, 'CMAQ variable ',trim(list_3d_vars(ivar))
      start_mem=1
      do imem=start_mem,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('e',i3)"),imem
!
         file_met3d=trim(cmaq_old_path)//'/run_'//trim(cmem)//'/'//trim(met3d_file)
         file_cmaq=trim(cmaq_new_path)//'/'//trim(cmaq_input_file)//'.'//trim(cmem)
         file_input=trim(file_met3d)
!
! get dimensions for variable to be added to the cmaq chemistry output file
         call get_cmaq_dims(file_input,ncol,nrow,nlay,ntim,nvar,ncol_id, &
         nrow_id,nlay_id,ntim_id,nvar_id)
         ntim_add=ntim
         nlay_add=nlay
!
! get the variable to be added to the cmaq chemistry output file
         allocate(cmaq_3d_data(ncol,nrow,nlay,ntim))
         allocate(data_out(ncol,nrow,nlay,1))
         allocate(tflag(2,nvar,ntim))
         call get_cmaq_data(file_input,list_3d_vars(ivar),cmaq_3d_data,ncol,nrow,nlay,ntim,nvar,tflag)
! 
! get dimensions from the cmaq chemistry output file
         file_output=trim(file_cmaq)
         call get_cmaq_dims(file_output,ncol,nrow,nlay,ntim,nvar,ncol_id, &
         nrow_id,nlay_id,ntim_id,nvar_id)
         ntim_out=ntim
         nlay_out=nlay
!
! get the date/time information from the cmaq chemistry output file
         allocate(tflag_out(2,nvar,ntim))
         call get_cmaq_data(file_output,'CO',cmaq_3d_data,ncol,nrow,nlay,ntim,nvar,tflag_out)
!
! find the corresponding date/time index in the variable to be added to the cmaq chemistry output file
         iflg=0
         idx_sav=1
         if(iflg.eq.0) then
            do idx=1,ntim_add
               if(tflag(1,ivar,idx).eq.tflag_out(1,ivar,1) .and. &
               tflag(2,ivar,idx).eq.tflag_out(2,ivar,1)) then
                  iflg=1
                  idx_sav=idx
                  exit
               endif
            enddo
            if(iflg.eq.0) then
               print *, 'APM: cmaq output file time/date not found'
               stop
            endif
         endif
!         print *, 'APM: time check 1 ',tflag(1,ivar,idx_sav),tflag_out(1,ivar,1)
!         print *, 'APM: time check 2 ',tflag(2,ivar,idx_sav),tflag_out(2,ivar,1)
!
! transfer DATE/TIME data
         data_out(:,:,:,1)=cmaq_3d_data(:,:,:,idx_sav)
!
! write variable to the cmaq chemistry output file
         call put_cmaq_data(file_output,list_3d_vars(ivar),data_out,ncol,nrow,nlay_add,1)
!
!  copy attritutes
         call copy_cmaq_att(file_input,file_output,list_3d_vars(ivar))         
!
         deallocate(cmaq_3d_data)
         deallocate(data_out)
         deallocate(tflag,tflag_out)
      enddo
   enddo
   deallocate(list_3d_vars)
!
! Write WRF-like variables to file.
! Get the date/time information from the cmaq chemistry output file
   nvar=225
   ntim=1
   allocate(tflag_out(2,nvar,ntim))
   allocate(cmaq_3d_data(ncol,nrow,nlay,ntim))
   file_cmaq=trim(cmaq_new_path)//'/'//trim(cmaq_input_file)
   file_output=trim(file_cmaq)
   call get_cmaq_data(file_output,'CO',cmaq_3d_data,ncol,nrow,nlay,ntim,nvar,tflag_out)
   rc = nf90_close(f_id)
   year=tflag_out(1,1,1)/1000
   ddd=tflag_out(1,1,1)-year*1000
!
! Convert ddd to month and day
   month=8
   day=1
   hour=tflag_out(2,1,1)/10000
   minute=(tflag_out(2,1,1)-hour*10000)/100
   second=tflag_out(2,1,1)-hour*10000-minute*100
!
! Convert to character data
   write(ch_year,'(i4)') year
   write(ch_month,'(i2)') month
   if(month.le.10) write(ch_month,"('0',i1)") month
   write(ch_day,'(i2)') day
   if(day.le.10) write(ch_day,"('0',i1)") day
   write(ch_hour,'(i2)') hour
   if(hour.le.10) write(ch_hour,"('0',i1)") hour
   write(ch_minute,'(i2)') minute
   if(minute.le.10) write(ch_minute,"('0',i1)") minute
   write(ch_second,'(i2)') second
   if(second.le.10) write(ch_second,"('0',i1)") second
   datestr=trim(ch_year)//'-'//trim(ch_month)//'-'//trim(ch_day) &
   //'_'//trim(ch_hour)//':'//trim(ch_minute)//':'//trim(ch_second)
   Times=trim(datestr)
!
! Write character variable Times to each member 
   start_mem=1
   do imem=start_mem,num_mems
      if(imem.ge.0.and.imem.lt.10) write(cmem,"('e00',i1)"),imem
      if(imem.ge.10.and.imem.lt.100) write(cmem,"('e0',i2)"),imem
      if(imem.ge.100.and.imem.lt.1000) write(cmem,"('e',i3)"),imem
      file_cmaq=trim(cmaq_new_path)//'/'//trim(cmaq_input_file)//'.'//trim(cmem)
      print *, 'APM: Open file ',trim(file_cmaq)
      rc = nf90_open(trim(file_cmaq),nf90_write,f_id)
      call check_error(rc,'main nf90_open')
      rc = nf90_inq_dimid(f_id,"Time",time_id)
      call check_error(rc,'main nf90_inq_dim')
!
! change NETCDF file mode to 'define' for writing the variable
      new_var=1
      if(new_var.eq.1) then
         rc = nf90_redef(f_id)
         call check_error(rc,'main nf90_redef')
         rc = nf90_def_dim(f_id,"DateStrLen",DateStrLen,length_id)
         call check_error(rc,'main nf90_def_dim')
         rc = nf90_def_var(f_id,"Times",nf90_char,(/length_id, time_id/),times_id) 
         call check_error(rc,'main nf90_def_var')
         rc = nf90_enddef(f_id)
         call check_error(rc,'main nf90_enddef')
         rc = nf90_put_var(f_id, times_id,trim(Times))
         call check_error(rc,'main nf90_put_var')
      else 
         rc = nf90_inq_dimid(f_id,"DateStrLen",length_id)
         call check_error(rc,'main nf90_inq_dim')
         rc = nf90_inq_varid(f_id,"Times",times_id)
         call check_error(rc,'get_cmaq_data nf90_inq_varid var_name')    
         rc = nf90_put_var(f_id, times_id,trim(Times))
         call check_error(rc,'main nf90_put_var')
      endif   
      rc = nf90_close(f_id)
   enddo
   deallocate(tflag_out)
   deallocate(cmaq_3d_data)
end program main
!
subroutine get_cmaq_dims(file_name,ncol,nrow,nlay,ntim,nvar,ncol_id,nrow_id,nlay_id,ntim_id,nvar_id)
   use netcdf
   implicit none
   integer                               :: ncol,nrow,nlay,ntim,nvar
   integer                               :: ncol_id,nrow_id,nlay_id,ntim_id,nvar_id
   integer                               :: rc,f_id
   character(len=200)                    :: file_name
   character(len=200)                    :: dim_nam1,dim_nam2,dim_nam3,dim_nam4,dim_nam5
!
! open netcdf file
   print *, 'file ',trim(file_name)   
   rc = nf90_open(trim(file_name),nf90_share,f_id)
   call check_error(rc,'get_cmaq_dims nf90_open ')
!
! get dimension identifiers and lengths
   rc = nf90_inq_dimid(f_id,'COL',ncol_id)
   call check_error(rc,'get_cmaq_dims nf90_inq_dimid COL ')
   rc = nf90_inq_dimid(f_id,'ROW',nrow_id)
   call check_error(rc,'get_cmaq_dims nf90_inq_dimid ROW ')
   rc = nf90_inq_dimid(f_id,'LAY',nlay_id)
   call check_error(rc,'get_cmaq_dims nf90_inq_dimid LAY ')
   rc = nf90_inq_dimid(f_id,'TSTEP',ntim_id)
   call check_error(rc,'get_cmaq_dims nf90_inq_dimid TSTEP ')
   rc = nf90_inq_dimid(f_id,'VAR',nvar_id)
   call check_error(rc,'get_cmaq_dims nf90_inq_dimid VAR ')
!   
   rc=nf90_inquire_dimension(f_id,ncol_id,dim_nam1,ncol)
   call check_error(rc,'get_cmaq_dims nf90_inquire_dimension call 1 ')
   rc=nf90_inquire_dimension(f_id,nrow_id,dim_nam2,nrow)
   call check_error(rc,'get_cmaq_dims nf90_inquire_dimension call 2 ')
   rc=nf90_inquire_dimension(f_id,nlay_id,dim_nam3,nlay)
   call check_error(rc,'get_cmaq_dims nf90_inquire_dimension call 3 ')
   rc=nf90_inquire_dimension(f_id,ntim_id,dim_nam4,ntim)
   call check_error(rc,'get_cmaq_dims nf90_inquire_dimension call 4 ')
   rc=nf90_inquire_dimension(f_id,nvar_id,dim_nam5,nvar)
   call check_error(rc,'get_cmaq_dims nf90_inquire_dimension call 5 ')
   rc=nf90_close(f_id)
   return
end subroutine get_cmaq_dims
!
subroutine get_cmaq_data(file_name,var_name,data,ncol,nrow,nlay,ntim,nvar,tflag)
   use netcdf
   implicit none
   integer                                :: ncol,nrow,nlay,ntim,nvar
   integer                                :: ncol_id,nrow_id,nlay_id,ntim_id,nvar_id
   integer                                :: rc,f_id,var_id,tflag_id
   integer(kind=4),dimension(2,nvar,ntim) :: tflag
   real,dimension(ncol,nrow,nlay,ntim)    :: data
   character(len=200)                     :: file_name,var_name
   character(len=200)                     :: dim_nam1,dim_nam2,dim_nam3,dim_nam4,dim_nam5
!
! open netcdf file
   rc = nf90_open(trim(file_name),nf90_nowrite,f_id)
   call check_error(rc,'get_cmaq_data nf90_open ')
!
! get variable identifiers
   rc = nf90_inq_varid(f_id,trim(var_name),var_id)
   call check_error(rc,'get_cmaq_data nf90_inq_varid var_name')
   rc = nf90_inq_varid(f_id,"TFLAG",tflag_id)
   call check_error(rc,'get_cmaq_data nf90_inq_varid tflag')
!
! get data
   rc = nf90_get_var(f_id,var_id,data,start=(/1,1,1,1/))
   call check_error(rc,'get_cmaq_data nf90_get_var var_name')
   rc = nf90_get_var(f_id,tflag_id,tflag,start=(/1,1,1/))
   call check_error(rc,'get_cmaq_data nf90_get_var tflag')
   rc=nf90_close(f_id)
   return
end subroutine get_cmaq_data
!
subroutine put_cmaq_data(file_name,var_name,data,ncol,nrow,nlay,ntim)
   use netcdf
   implicit none
   integer                               :: ncol,nrow,nlay,ntim
   integer                               :: ncol_id,nrow_id,nlay_id,nlay2d_id,nlay3d_id,ntim_id,nvar_id
   integer                               :: dim_len1,dim_len2,dim_len3,dim_len4,dim_len5
   integer                               :: rc,rc_2d,f_id,v_id,v_dimid
   real,dimension(ncol,nrow,nlay,ntim)   :: data
   character(len=200)                    :: dim_nam1,dim_nam2,dim_nam3,dim_nam4,dim_nam5
   character(len=200)                    :: file_name,var_name
!
! open netcdf file
   rc = nf90_open(trim(file_name),nf90_write,f_id)
   call check_error(rc,'put_cmaq_data nf90_open')
!
! change NETCDF file mode to 'define' for writing the variable
   rc = nf90_redef(f_id)
   call check_error(rc,'put_cmaq_data nf90_redef')
!
! get dimension identifiers and lengths
   rc=nf90_inq_dimid(f_id,'COL',ncol_id)
   call check_error(rc,'put_cmaq_data nf90_inq_dimid COL')
   rc=nf90_inq_dimid(f_id,'ROW',nrow_id)
   call check_error(rc,'put_cmaq_data nf90_inq_dimid ROW')
   rc=nf90_inq_dimid(f_id,'LAY',nlay3d_id)
   call check_error(rc,'put_cmaq_data nf90_inq_dimid LAY')
   rc_2d=nf90_inq_dimid(f_id,'LAY_2D',nlay2d_id)
!   call check_error(rc_2d,'put_cmaq_data nf90_inq_dimid LAY_2D')
   rc=nf90_inq_dimid(f_id,'TSTEP',ntim_id)
   call check_error(rc,'put_cmaq_data nf90_inq_dimid TSTEP')
!
   rc=nf90_inquire_dimension(f_id,ncol_id,dim_nam1,dim_len1)
   rc=nf90_inquire_dimension(f_id,nrow_id,dim_nam2,dim_len2)
   rc=nf90_inquire_dimension(f_id,nlay3d_id,dim_nam3,dim_len3)
   rc=nf90_inquire_dimension(f_id,ntim_id,dim_nam4,dim_len4)
!
   if(rc_2d.ne.0) then
      rc=nf90_def_dim(f_id,'LAY_2D',1,nlay2d_id)
   endif
   rc=nf90_inquire_dimension(f_id,nlay2d_id,dim_nam5,dim_len5)
!  
   if(nlay.eq.1) then
      nlay_id=nlay2d_id
   else
      nlay_id=nlay3d_id
   endif
   rc=nf90_def_var(f_id,trim(var_name),nf90_float,(/ncol_id,nrow_id,nlay_id,ntim_id/),v_id)
   call check_error(rc,'put_cmaq_data nf90_def_var')
   rc=nf90_enddef(f_id)
   rc=nf90_put_var(f_id,v_id,data,start=(/1,1,1,1/),count=(/ncol,nrow,nlay,ntim/))
   call check_error(rc,'put_cmaq_data nf90_put_var')
   rc = nf90_close(f_id)
   return
end subroutine put_cmaq_data
!
subroutine copy_cmaq_att(file_in,file_out,var_name)         
   use netcdf
   implicit none
   character(len=200),parameter          :: attribute_1='long_name'
   character(len=200),parameter          :: attribute_2='units'
   character(len=200),parameter          :: attribute_3='var_desc'
!
   integer                               :: rc,fid_in,fid_out,varid_in,varid_out
   character(len=200)                    :: file_in,file_out,var_name
!
! open netcdf files
   rc = nf90_open(trim(file_in),nf90_write,fid_in)
   call check_error(rc,'copy_cmaq_att nf90_open in')
   rc = nf90_open(trim(file_out),nf90_write,fid_out)
   call check_error(rc,'copy_cmaq_att nf90_open out')
!
! change NETCDF file mode to 'define' for writing the variable
   rc = nf90_redef(fid_out)
   call check_error(rc,'copy_cmaq_att nf90_redef')
!
! get variable ids   
   rc = nf90_inq_varid(fid_in,trim(var_name),varid_in)
   call check_error(rc,'copy_cmaq_att nf90_inq_varid in')
   rc = nf90_inq_varid(fid_out,trim(var_name),varid_out)
   call check_error(rc,'copy_cmaq_att nf90_inq_varid out')
!
! copy attributes
   rc = nf90_copy_att(fid_in,varid_in,trim(attribute_1),fid_out,varid_out)   
   call check_error(rc,'copy_cmaq_att nf90_copy_att 1')
   rc = nf90_copy_att(fid_in,varid_in,trim(attribute_2),fid_out,varid_out)   
   call check_error(rc,'copy_cmaq_att nf90_copy_att 2')
   rc = nf90_copy_att(fid_in,varid_in,trim(attribute_3),fid_out,varid_out)   
   call check_error(rc,'copy_cmaq_att nf90_copy_att 3')
!
   rc = nf90_close(fid_in)
   rc = nf90_close(fid_out)
end subroutine copy_cmaq_att
!
subroutine check_error(rc,source)
   implicit none
   integer            :: rc
   character(len=*)   :: source
   if(rc.ne.0) then
      print *, 'APM:NETCDF ERROR: ',trim(source),' ',rc
      stop
   endif
end subroutine check_error
