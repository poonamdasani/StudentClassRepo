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
        List<Product__c> p1 = new ProductSelector(true).selectByProductId(null);
        List<Product__c> p2 = new ProductSelector(true).selectByProductId('');
        Test.stopTest();
        system.AssertEquals(2,p.size());
        system.assertEquals(productList.get(0).Name, p[0].Name, 'Values Does not Match');
        system.AssertNotEquals(0, p1.size(), 'emplty list returned');
        system.AssertNotEquals(0, p2.size(), 'emplty list returned');
        
    }

}