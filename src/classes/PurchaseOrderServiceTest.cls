@isTest
private class PurchaseOrderServiceTest 
{
    @isTest
    static void selectProductClass()
    {
        PurchaseOrderService.SelectProduct s = new PurchaseOrderService.SelectProduct();
    }
    
    
    
    @isTest
    static void addRemoveItems()
    {
        Product__c prod = new Product__c();
        prod.price__c = 123;
        insert prod;
        
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
        Product__c prod = new Product__c();
        prod.price__c = 123;
        insert prod;
        
        PurchaseOrderService.SelectProduct sp = PurchaseOrderService.addItems(1, prod);
        System.assertEquals(sp.price, prod.price__c);
        
        List<PurchaseOrderService.SelectProduct> spList = new List<PurchaseOrderService.SelectProduct>();
        spList.add(sp);
        
        
        
        
    }
}