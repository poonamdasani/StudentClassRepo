@isTest
private class PurchaseOrderControllerTest {

	static PurchaseOrderController ctrl = new PurchaseOrderController(
            new ApexPages.StandardController(new PurchaseOrder__c()));
    
    @isTest static void testCancel_CancelProcessAndReturn()
    {
        PageReference ref = Page.Purchase_Order;
        ref.getParameters().put('retURL', '/');
        Test.setCurrentPage(ref);
        Test.startTest();
        ctrl.cancel();
        Test.stopTest();
    }    
    
    @isTest static void testAddItemToCart() 
    {
        Product__c prodct = setProductValue();
       
        PageReference ref = setPageRefrence(prodct);
        Test.setCurrentPage(ref);
        
        Test.startTest();
        	ctrl.addItem();
        Test.stopTest();
        
        System.assertEquals(0, ctrl.addProductList.size());
        System.assertEquals(1, ctrl.selectProductList.size());
    }
    
    @isTest static void testRemoveItem()
    {
        Product__c prodct = setProductValue();
        
        PageReference ref = setPageRefrence(prodct);
        Test.setCurrentPage(ref);
        
        Test.startTest();
        	ctrl.removeItem();
        Test.stopTest();
        
        System.assertEquals(1, ctrl.addProductList.size());
        System.assertEquals(0, ctrl.selectProductList.size());
    }
    
    @isTest static void testPurchase()
    {
        Contact c = new Contact();
        c.LastName = 'test1';
        insert c;
        Date d = Date.today();
        PurchaseOrder__c purchaseOrder = new PurchaseOrder__c();
        purchaseOrder.Contact__c = c.Id;
        purchaseOrder.Purchase_Date__c = d;
        purchaseOrder.Total_Amount__c = 30;
        insert purchaseOrder;
        ctrl.purchaseOrder = purchaseOrder;
        
        Product__c prodct = setProductValue();
        
        PurchaseOrderService.SelectProduct p = new PurchaseOrderService.SelectProduct();
        PurchaseOrderLineItem__c lineItem = new PurchaseOrderLineItem__c();
        lineItem.Product__c = prodct.Id;
        lineItem.PurchaseOrder__c = purchaseOrder.Id;
        lineItem.Quantity__c = 30;
        insert lineItem;
        p.selectedProduct = lineItem;
        p.price = 10;
        ctrl.selectProductList.add(p);
        
		Test.startTest();
        ctrl.purchase();
		Test.stopTest(); 
        
    }
    
    
    private static Product__c setProductValue()
    {
    		Product__c prodct = new Product__c();
        prodct.Name = 'Test';
        prodct.Price__c = 20;
        prodct.Stock__c = 10;
        insert prodct;
        return product;
    }
    
    private static PageReference setPageRefrence(Product__c product)
    {
    		PageReference ref = Page.Purchase_Order;
        ref.getParameters().put('selectproductId', prodct.Id);
        ref.getParameters().put(prodct.Name, String.valueOf(prodct.Stock__c));
        return ref;
    }
}