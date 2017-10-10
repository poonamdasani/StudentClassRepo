//Class to update Manager__c field. Manager__c field is a lookup of Account.
	
public class ManagerController {
    public void populateManager(Opportunity o)
    { 
              if(o.BillToContact__c != NULL)
                {
                   if(o.Manager__c == NULL)
                   {
                       try{
                           o.Manager__c= o.AccountId;
                          update o;
                       }
                       catch(Exception e){
                           system.debug('exception occured : '+ e.getMessage());
                       }
                   }
                }
        }
    }