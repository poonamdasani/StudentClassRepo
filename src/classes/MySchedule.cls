global class MySchedule implements Schedulable 
{
    global void execute(SchedulableContext SC) 
    {
        Reminder r= new Reminder();
    }
    
    public class Reminder 
    {
        public Reminder()
        {
            List<Opportunity> opportunityList= new List<Opportunity>([SELECT LastModifiedDate, Owner.Email FROM Opportunity where LastModifiedDate < LAST_N_DAYS:30]);
            
            for(Opportunity opp : opportunityList)
            {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                string[] toaddress= New string[]{opp.Owner.Email};
                    email.setSubject('Opportunity to be Modified');
                email.setPlainTextBody('Your Opportunity not modified for 30 days');
                email.setToAddresses(toaddress);
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
            }
        }
    }
}