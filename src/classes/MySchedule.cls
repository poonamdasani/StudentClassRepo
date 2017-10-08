global class MySchedule implements Schedulable {
   global void execute(SchedulableContext SC) {
      Reminder r= new Reminder();
   }




// class to mail opportunity owner

	public class Reminder {

    		public Reminder()
    			{
        
       		 List<Opportunity> o= new List<Opportunity>([select LastModifiedDate, Owner.Email from Opportunity where LastModifiedDate 					< : system.Date.today() LIMIT 2]);
       
        		for(Opportunity i : o)
        			{
           
           		 	 Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                                   	 string[] toaddress= New string[]{i.Owner.Email};
                                   	 email.setSubject('Opportunity to be Modified');
                                   	 email.setPlainTextBody('Your Opportunity not modified for 30 days');
                                  	  email.setToAddresses(toaddress);
                                   	 Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
        			}
    			}
			}
    }