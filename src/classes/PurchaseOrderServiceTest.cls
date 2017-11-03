@isTest
private class PurchaseOrderServiceTest 
{
    
    @isTest
    static void addRemoveItems()
    {
        Product__c prod = setProduct();
        
        PurchaseOrderService.SelectProduct sp = PurchaseOrderService.addItems(1, prod);
        System.assertEquals(sp.price, prod.price__c);
        
        List<PurchaseOrderService.SelectProduct> spList = new List<PurchaseOrderService.SelectProduct>();
        spList.add(sp);
        spList = PurchaseOrderService.removeItem(spList, prod.id);
        System.assertEquals(0, spList.size());
        
        List<Product__c> pList = new List<Product__c>();
        pList.add(prod);
        pList = PurchaseOrderService.removeItem(pList, prod.id);
        System.assertEquals(0, pList.size());
        
        Product__c queryprod = PurchaseOrderService.getProduct(prod.id);
        System.assertEquals(queryprod.id, prod.id);
    }
    
    
    @isTest
    static void purchase()
    {
        Product__c prod = setProduct();
        
        PurchaseOrderService.SelectProduct sp = PurchaseOrderService.addItems(1, prod);
        System.assertEquals(sp.price, prod.price__c);
        
        List<PurchaseOrderService.SelectProduct> spList = new List<PurchaseOrderService.SelectProduct>();
        spList.add(sp);  
        
        Contact c = new Contact();
        c.LastName = 'test1';
        insert c;
        Date d = Date.today();
        PurchaseOrder__c purchaseOrder = new PurchaseOrder__c();
        purchaseOrder.Contact__c = c.Id;
        purchaseOrder.Purchase_Date__c = d;
        purchaseOrder.Total_Amount__c = 30;
        insert purchaseOrder;
        
        PurchaseOrderService.purchase(spList, purchaseOrder);
        
        List<PurchaseOrderLineItem__c> purchaseOrderLineItemList = new List<PurchaseOrderLineItem>();
        purchaseOrderLineItemList = [SELECT Product FROM PurchaseOrderLineItem__c];
        System.assertEquals(purchaseOrderLineItemList.get(0).purchaseOrder.Id,  purchaseOrder.Id);
    }
    
    private static Product__c setProduct()
    {
    		Product__c prod = new Product__c();
        prod.price__c = 123;
        insert prod;
    }
}