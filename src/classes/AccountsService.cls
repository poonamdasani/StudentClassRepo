public class AccountsService {
    
    // Unit of Work
    private static fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new List<SObjectType> { Account.SObjectType  }
    );
    
    public static void manageContactIDs(id mycontactid)
    {
        
         List<Account> accountsList = new List <Account>();
        List<Contact> contactList = new ContactsSelector(true).selectById(new Set<Id> {mycontactid});
         //system.debug('account id = '+ contactList);
         if(contactList.size()==0)
         {
             return ;
         }
         if(contactList[0].Account.ContactIDs__c == null)
         {
        	contactList = new ContactsSelector(true).selectByAccountId(new Set<Id> {contactList[0].Account.Id});
         	Account acc = contactList[0].Account;
             acc.ContactIDs__c = '';
            for(Contact contact : contactList)
            {
                acc.ContactIDs__c += contact.ID + ',';
            }
             acc.ContactIDs__c = acc.ContactIDs__c.subString(0,acc.ContactIDs__c.length() - 1);
         	uow.registerDirty(acc);
         }
        else {
            Account acc = contactList[0].Account;
            if(!acc.ContactIDs__c.contains(contactList[0].ID))
            {
                acc.ContactIDs__c += ',' + contactList[0].ID;
            }
            uow.registerDirty(acc);
        }
        try
        {
            Accounts.onUpdateAccount(uow);
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