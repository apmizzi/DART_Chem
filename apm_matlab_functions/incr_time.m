%
function [yyyy,mn,dy,hh,mm,ss]=incr_time(year, ...
month,day,hour,minute,second);
   days_per_month=[31,28,31,30,31,30,31,31,30,31,30,31];
%
% Check for negative time / date
   if(second<0)
      minute=minute-1;
      second=60+second;
   end
   if(minute<0)
      hour=hour-1;
      minute=60-minute;
   end
   if(hour<0)
      day=day-1;
      hour=60-hour;
   end
   if(day<=0)
      if(imon==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),400)==0)))
         days_mon=days_per_month(month)+1;
      else
         days_mon=days_per_month(month);
      end
      month=month-1;
      day=day_mon-day;
   end
   if(month<=0)
     month=12;
     year=year-1;
   end
%
% Check if time / date too large

   if(second>59) 
      if(second>119)
         fprintf('APM: Error seconds too large %d \n',int64(second))
         return
      end
      second=second-60;
      minute=minute+1;
   end
   if(minute>59)
     if(minute>119)
         fprintf('APM: Error minutes too large %d \n',int64(minute))
         return
      end
      minute=minute-60;
      hour=hour+1;
   end
   if(hour>23)
      if(hour>47)
         fprintf('APM: Error hours too large %d \n',int64(hour))
         return
      end
      hour=hour-24;
      day=day+1;
   end
   days_mon=days_per_month(month);
   if(int64(month)==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
   100)~=0) || (mod(int64(year),400)==0)))
      days_mon=days_mon+1;
   end
   if(day>days_mon)
      if(day>(days_mon+days_mon))
         fprintf('APM: Error days too large %d \n',day)
         return
      end
      day=day-days_mon;
      month=month+1;
   end
   if(month>12)
      if(month>24)
         fprintf('APM: Error month too large %d \n',month)
         return
      end
     month=month-12;
     year=year+1;
   end
   yyyy=year;
   mn=month;
   dy=day;
   hh=hour;
   mm=minute;
   ss=second;
end
