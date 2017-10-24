public class Accounts extends fflib_SObjectDomain 
{
    
    private static fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new List<SObjectType> { Account.SObjectType  }
    );
    
    public Accounts(List<Account> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable 
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }
    
    public Override void onAfterUpdate(Map<Id,SObject> existingRecords)
    {
        Set<ID> accountIDs = new Set<ID>();
        Map<Id, Account> newAccountMap = new Map<Id, Account>();
        for(Account acc: (List<Account>)Records)
        {
            newAccountMap.put(acc.Id, acc);
        }
        for(Account account : ((Map<Id, Account>)existingRecords).values()){
            if(account.Account__c != newAccountMap.get(account.id).Account__c){
                accountIDs.add(account.Account__c);
                accountIDs.add(newAccountMap.get(account.id).Account__c);
            }
        }
        
        updateChildCount(accountIDs);
    }
    
    public Override void onAfterInsert() 
    {
        Set<ID> accountIDs = new Set<ID>();
        Map<Id, Account> newAccountMap = new Map<Id, Account>();
        for(Account acc: (List<Account>)Records)
        {
            newAccountMap.put(acc.Id, acc);
        }
        for(Account account : newAccountMap.values()){
            accountIDs.add(account.Account__c);
        }
        updateChildCount(accountIDs);
    }
    
    public Override void onBeforeDelete() 
    {
        Set<ID> accountIDs = new Set<ID>();
        Map<Id, Account> newAccountMap = new Map<Id, Account>();
        for(Account acc: (List<Account>)Records)
        {
            newAccountMap.put(acc.Id, acc);
        }
        for(Account account : newAccountMap.values()){
            accountIDs.add(account.Account__c);
        }
        updateChildCount(accountIDs);
    }
    
    public Override void onAfterUndelete () 
    {
        Set<ID> accountIDs = new Set<ID>();
        Map<Id, Account> newAccountMap = new Map<Id, Account>();
        for(Account acc: (List<Account>)Records)
        {
            newAccountMap.put(acc.Id, acc);
        }
        for(Account account : newAccountMap.values()){
            accountIDs.add(account.Account__c);
        }
        updateChildCount(accountIDs);
    }
    
    private static void updateChildCount(Set<ID> accountIDs)
    {
        List<Account> accountList = [Select a.Id, (Select Id From Accounts__r) from Account a where a.Id IN : accountIDs];
        for(Account account : accountList)
            account.childCount__c = account.Accounts__r.size();
        uow.registerDirty(accountList);
       	uow.commitWork(); 
    }
    
    public static void onUpdateAccount(fflib_SObjectUnitOfWork uow)
    {
        uow.commitWork();
    }
    
    public override void onbeforeUpdate(Map<Id,SObject> existingRecords)
    {
        updateAnnualRevenue(existingRecords);    
    }
    
    private void updateAnnualRevenue(Map<Id,SObject> existingRecords)
    {
        for(Account acc: (List<Account>)Records)
        {
            Account oldVal = (Account)existingRecords.get(acc.Id);
            String s = oldVal.Description; 
            acc.AnnualRevenue = acc.Description.getLevenshteinDistance(s);
        }    
    } 
}