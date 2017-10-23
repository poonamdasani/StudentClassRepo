//Class to update Manager__c field. Manager__c field is a lookup of Account.
	
public class ManagerController 
{
    public void populateManager(Opportunity opp)
    { 
              if(opp.BillToContact__c != NULL && opp.Manager__c == NULL)
                {
                       try
                       {
                          opp.Manager__c= opp.AccountId;
                          update opp;
                       }
                       catch(Exception e)
                       {
                           system.debug('exception occured : '+ e.getMessage());
                       }
                }
        }
    }