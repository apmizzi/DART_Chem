%
function [year,month,day,hour,minute,second]=invert_time_1995(jult)
   days_mon=[31 28 31 30 31 30 31 31 30 31 30 31]; 
   ref_year=1995;
   ref_month=1;
   ref_day=1;
   ref_hour=0;
   ref_minute=0;
   ref_second=0;
   secs_year=365.*24.*60.*60.;
   secs_leap_year=366.*24.*60.*60.;
%
   if(leapyear(ref_year))
      secs_gone=secs_leap_year;
   else
      secs_gone=secs_year;
   end
   year=ref_year;
   while (jult>secs_gone)
      jult=jult-secs_gone;
      year=year+1.;
      if(leapyear(year))
         secs_gone=secs_leap_year;
      else
         secs_gone=secs_year;
      end
   end
   yeart=year;
   for imon=1:12
      if(imon==2 & leapyear(year))
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
   montht=month;
   day=idivide(int64(jult),int64(24*60*60))+1;
   dayt=day;
   jult=int64(jult)-int64(day-1)*int64(24.*60.*60.);
   hour=idivide(int64(jult),int64(60*60));
   hourt=hour;
   jult=int64(jult)-int64(hour)*int64(60.*60.);
   minute=idivide(int64(jult),int64(60));
   minutet=minute;
   second=jult-minute*60.;
   secondt=second;

   year=yeart;
   month=montht;
   day=dayt;
   hour=hourt;
   minute=minutet;
   second=secondt;

end
