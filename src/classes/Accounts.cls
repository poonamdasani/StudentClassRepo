public class Accounts extends fflib_SObjectDomain 
{
    public Accounts(List<Account> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable 
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) 
        {
            return new Accounts(sObjectList);
        }
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