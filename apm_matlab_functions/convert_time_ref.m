%
function [jult]=convert_time_ref(year,month,day,hour,minute,second,ref_year)
   days_per_mon=[31 28 31 30 31 30 31 31 30 31 30 31]; 
   secs_year=365.*24.*60.*60.;
   secs_leap_year=366.*24.*60.*60.;
   jult=0;
   ref_month=1;
   ref_day=1;
   ref_hour=0;
   ref_minute=0;
   ref_second=0;
%
% NOTE: hours run 0 - 23
   if(hour>23)
      fprintf('APM: ERROR - hour must be less than or equal to 23 \n')
      return
   end
   if(ref_year>year)
      fprintf('APM: ERROR - year must greater than or equal to %d \n',ref_year)
      return
   end
%
   for iyear=ref_year:year-1
      if(leapyear(iyear))
         jult=jult+secs_leap_year;
      else
         jult=jult+secs_year;
      end
   end
   for imon=1:month-1
      if(imon==2 & leapyear(year))
         jult=jult+(days_per_mon(imon)+1)*24.*60.*60.;
      else
         jult=jult+days_per_mon(imon)*24.*60.*60.;
      end
   end
   jult=jult+(day-1)*24.*60.*60.;
   jult=jult+hour*60.*60.+minute*60.+second;
end
