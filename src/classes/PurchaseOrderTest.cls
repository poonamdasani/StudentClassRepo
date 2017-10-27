@isTest
private class PurchaseOrderTest {
    @isTest
    public static void testInsertPurchaseList() {
        PurchaseOrder__c purOrder = new PurchaseOrder__c(Total_Amount__c = 60);
        String purchaseOrderId = PurchaseOrder.insertPurchaseOrder(purOrder);
        
        List<PurchaseOrder__c> p = [SELECT id FROM PurchaseOrder__c Where Id =: purchaseOrderId];
        system.AssertEquals(p.size(),1);
        system.AssertNotEquals(p[0].id, null);
        system.assertEquals(purOrder.Total_Amount__c, p[0].Total_Amount__c, 'Values Does not Match');
    }
}