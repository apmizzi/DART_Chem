%
function [jult_out]=jult_adjust_ref(jult_in,ref_year,ref_month,ref_day,ref_hour,ref_minute,ref_second)
   days_per_mon=[31 28 31 30 31 30 31 31 30 31 30 31]; 
   secs_year=365.*24.*60.*60.;
   secs_leap_year=366.*24.*60.*60.;
%
% NOTE: hours run 0 - 23
   if(ref_hour>23)
      'APM: ERROR - hour must be less than or equal to 23'
      return
   end
%
% Increase jult_in by the number of seconds that passed in the reference year
   sum=0.;
   for imon=1:ref_month-1
      if(imon==2 & leapyear(ref_year))
         sum=sum+(days_per_month(imon)+1)*24.*60.*60.;
      else
         sum=sum+days_per_month(imon)*24.*60.*60.;
      end
   end
   for iday=1:ref_day-1
     sum+sum+24.*60.*60;
   end
   sum=sum+ref_hour*60.*60.;
   sum=sum+ref_minute*60.;
   sum=sum+ref_second;
%
   jult_out=jult_in+sum;
end
