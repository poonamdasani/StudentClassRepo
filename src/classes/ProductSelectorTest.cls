@isTest
private class ProductSelectorTest {
    
    @isTest 
    public static void testSelectByProductId ()
    {
        List<Product__c> productList = new List<Product__c>();
        Product__c product = new Product__c(Name = 'test1');
		productList.add(product);   
		product = new Product__c(Name = 'test2');
       	productList.add(product); 
        insert productList;
        Set<Id> idSet = new Set<Id>();
        idSet.add(productList.get(0).Id);
        idSet.add(productList.get(1).Id);
        Test.startTest();
        List<Product__c> p = new ProductSelector(true).selectByProductId(idSet);
        Test.stopTest();
        system.AssertEquals(2,p.size());
        system.AssertNotEquals(null, p[0].id, 'Id is null');
        system.AssertNotEquals('', p[0].id, 'Id is blank');
        system.assertEquals(productList.get(0).Name, p[0].Name, 'Values Does not Match');
        
    }

}