public class PurchaseOrder extends fflib_SObjectDomain 
{
    public PurchaseOrder(List<PurchaseOrder__c> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable 
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) 
        {
            return new PurchaseOrder(sObjectList);
        }
    }
    
    public static String insertPurchaseOrder(PurchaseOrder__c purchaseOrder)
    {
        Database.SaveResult sr = null;
        sr = Database.insert(purchaseOrder);
        return sr.getId();
    }

}