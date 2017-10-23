public class AccountsService {
    
    // Unit of Work
    private static fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new List<SObjectType> { Account.SObjectType  }
    );
    
    public static List<Account> get100AccountRecords(String selectedBillingCity, String selectedBillingState, String selectedBillingCountry)
    {
        List<Account> accountsList = new AccountsSelector(true).selectByAccountWithFilters(selectedBillingCity, selectedBillingState, selectedBillingCountry);
        return accountsList;
    }
    
    public static List<Account> getAccountRecordsWithFilter(String selectedBillingCity, String selectedBillingState, String selectedBillingCountry)
    {
        List<Account> accountsList = new AccountsSelector(true).selectAccountWithFilter(selectedBillingCity, selectedBillingState, selectedBillingCountry);
        return accountsList;
    }
    
    public static void manageContactIDs(id mycontactid)
    {
        
        List<Account> accountsList = new List <Account>();
        List<Contact> contactList = new ContactsSelector(true).selectById(new Set<Id> {mycontactid});
        if(contactList.size()!=0)
        {
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
    
    public static List<String> getFieldList(String SOQLquery, List<String> fieldsList)
    {
        String query = SOQLquery.toUpperCase();
        String subString = query.substringBetween('SELECT ',' FROM'); 
        List<String> fieldsNameList = subString.split(',');
        fieldsList = new List<String>();
        for(String columnName : fieldsNameList){
            columnName = columnName.trim();
            if(columnName.contains('.')){
                columnName = columnName.substringAfter('.');
            }
            fieldsList.add(columnName);
        }
        return fieldsList;
    }
    
    public static List<Account> execute(String SOQLQuery)
    {
        return (new AccountsSelector(true).executeQuery(SOQLQuery));
    }
    
    public static String sort(String SOQLquery, Boolean flag, String column)
    {
        String sortingQuery;
        SOQLquery= SOQLquery.toUpperCase();
        if(flag== false)
        {
            if(SOQLquery.contains('LIMIT'))
            {
                sortingQuery= SOQLquery.substringBefore('LIMIT') + ' order by ' + column + ' ASC LIMIT' + SOQLquery.substringAfter('LIMIT');
            }
            else{
                sortingQuery= SOQLquery + ' order by ' + column + ' ASC NULLS LAST ';
            }
            flag= true;
        }
        else{
            if(SOQLquery.contains('LIMIT'))
            {
                sortingQuery= SOQLquery.substringBefore('LIMIT') + ' order by ' + column + ' DESC LIMIT' + SOQLquery.substringAfter('LIMIT');
            }
            else{
                sortingQuery= SOQLquery + ' order by ' + column + ' DESC';
            }
            flag= false;
        }
        return sortingQuery;
    }
    
}