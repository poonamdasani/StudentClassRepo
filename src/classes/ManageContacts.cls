public class ManageContacts 
{
    public static void updateContactids(id mycontactid)
    {
        List<Account> contactids= new List <Account>();
        Contact accountid= [select Account.id from Contact where id =:mycontactid];
        list<Account> accObj= [select ContactIDs__c,(select id from contacts) from Account where id= : accountid.Account.id];
       	for(Account acc : accObj)
        {
            for(Contact con : acc.contacts)
            {
                if(acc.ContactIDs__c == NULL)
                       acc.ContactIDs__c = con.id;
                if(acc.ContactIDs__c != NULL)
                        acc.ContactIDs__c = acc.ContactIDs__c+', '+con.id;
            }
        contactids.add(acc);
        }
        try
        {
            update contactids;
        }
        catch(DMLException e)
        {
            system.debug('Dml Exception : '+ e.getStackTraceString());
        }
        catch(Exception e)
        {
            system.debug('Exception Occured: '+ e.getStackTraceString());
        }
    }
}