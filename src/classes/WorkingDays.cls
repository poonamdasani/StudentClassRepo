public with sharing class WorkingDays
{
    /**
    method which take 2 dates as argument and return number of working days between two days excluding both days(Saturday and Sunday is nonworking)
    */
    
    public static Integer countworkingDays(Date initialDate, Date finalDate)
    {
        if(initialDate > finalDate)
        {
            return null;
        }
        Integer workDays = 0;
        Date WeekDay = initialDate.toStartofWeek();
        
        for(Date tempDate=initialDate ; tempDate < finalDate ; tempDate=tempDate.addDays(1))
        {
            Integer week = (math.mod(WeekDay.daysBetween(tempDate),7));
            if( week != 0 && week !=6)
            {
                workDays++;
            }
        }
        return workDays;
    } 
}