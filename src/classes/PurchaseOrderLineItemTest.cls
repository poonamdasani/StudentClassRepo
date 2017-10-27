@isTest
private class PurchaseOrderLineItemTest {
    
    @isTest
    public static void TestInsertPurchaseList() {
        Contact c = new Contact();
        c.LastName = 'test1';
        insert c;
        Date d = Date.today();
        PurchaseOrder__c purchaseOrder = new PurchaseOrder__c();
        purchaseOrder.Contact__c = c.Id;
        purchaseOrder.Purchase_Date__c = d;
        purchaseOrder.Total_Amount__c = 30;
        insert purchaseOrder;
        Product__c prodct = new Product__c();
        prodct.Name = 'Test';
        prodct.Price__c = 20;
        prodct.Stock__c = 10;
        insert prodct;
        PurchaseOrderLineItem__c purOrderItem = new PurchaseOrderLineItem__c(Quantity__c = 60, PurchaseOrder__c = purchaseOrder.Id,Product__c = prodct.Id);
        PurchaseOrderLineItem__c purOrderItem1 = new PurchaseOrderLineItem__c(Quantity__c = 80, PurchaseOrder__c = purchaseOrder.Id,Product__c = prodct.Id);
        List<PurchaseOrderLineItem__c> purOrderList = new List<PurchaseOrderLineItem__c>();
        purOrderList.add(purOrderItem);
		purOrderList.add(purOrderItem1);
		PurchaseOrderLineItem.insertPurchaseList(purOrderList);
        
        List<PurchaseOrderLineItem__c> p = [SELECT id,Total_Price__c  FROM PurchaseOrderLineItem__c Where Id =: purOrderList.get(0).Id];
        system.AssertEquals(p.size(),1);
        system.AssertNotEquals(p[0].id, null);
        system.assertEquals(purOrderItem.Id, p[0].Id, 'Values Does not Match');
    }
}