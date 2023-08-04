function [year,month,day,hour,minute,second]=invert_time_1995(jult)
   days_mon=[31 28 31 30 31 30 31 31 30 31 30 31];
%
% calculate year, month, day, hour, minute, and seconds from
% number of second from the reference date/time
   ref_year=1995;
   ref_month=1;
   ref_day=1;
   ref_hour=0;
   ref_minute=0;
   ref_second=0;
   secs_year=365.*24.*60.*60.;
   secs_leap_year=366.*24.*60.*60.;
%
   if((mod(int64(ref_year),4)==0 & mod(int64(ref_year), ...
   100)~=0) || (mod(int64(ref_year),400)==0))
      secs_gone=secs_leap_year;
   else
      secs_gone=secs_year;
   end
   year=ref_year;
   while (jult>secs_gone)
      jult=jult-secs_gone;
      year=year+1.;
      if((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),400)==0))
         secs_gone=secs_leap_year;
      else
         secs_gone=secs_year;
      end
   end
   for imon=1:12
      if(imon==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),400)==0)))
         secs_gone=(days_mon(imon)+1)*24.*60.*60.;
      else
         secs_gone=days_mon(imon)*24.*60.*60.;
      end
      if(jult>=secs_gone) 
	 jult=jult-secs_gone;
      else
	 month=imon;
         break
      end
   end
   day=floor(jult/24./60./60.)+1;
   jult=jult-(day-1)*24.*60.*60.;
   hour=floor(jult/60./60.);
   jult=jult-hour*60.*60.;
   minute=floor(jult/60.);
   second=jult-minute*60.;
end
%
