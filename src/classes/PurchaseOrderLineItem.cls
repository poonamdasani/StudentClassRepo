public class PurchaseOrderLineItem extends fflib_SObjectDomain 
{
    public PurchaseOrderLineItem(List<PurchaseOrderLineItem__c> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable 
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList)
        {
            return new PurchaseOrderLineItem(sObjectList);
        }
    }
    
    public static void insertPurchaseList(List<PurchaseOrderLineItem__c> purchaseList)
    {
        insert purchaseList;
    }

}