public class PurchaseOrderService {
    
    // Unit of Work
    private static fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new List<SObjectType> { PurchaseOrder__c.SObjectType  }
    );
    
    public class SelectProduct
    {
        public PurchaseOrderLineItem__c selectedProduct {get; set;}
        public Double price {get; set;}
    }
    
    public static SelectProduct addItems(Decimal quantity, Product__c p)
    {
        PurchaseOrderLineItem__c pi=new PurchaseOrderLineItem__c();
        //set the values
        pi.product__c=p.Id;
        pi.quantity__c= quantity;
        SelectProduct sp = new SelectProduct();
        sp.selectedProduct = pi;
        sp.price = p.price__c;
        
        return sp;
    }
    
    public Static List<SelectProduct> removeItem(List<SelectProduct> selectProductList, String pid)
    {
        for(integer i=0;i<selectproductlist.size();i++){
            id p1=selectproductlist.get(i).selectedProduct.product__c;
            if((p1)==(pid)){
                selectproductlist.remove(i);
            }                          
        } 
        return selectProductList;
    }
    
    public Static List<Product__c> removeItem(List<Product__c> productList, String pid)
    {
        for(integer i=0;i<productList.size();i++){
            Product__c p1=productList.get(i);
            if((p1.id)==(pid)){
                productList.remove(i);
            }                          
        }  
        return productList;
    }
    
    public static void purchase(List<SelectProduct> selectProductList, PurchaseOrder__c purchase)
    {
        Double amount = 0;
        String purchaseOrderId = '';
        // calculate the total amount
        for(SelectProduct sp :selectproductlist){
            amount = amount +(sp.selectedProduct.quantity__c * sp.price);
        }
        purchase.Total_Amount__c = amount;
        try{
            // insert new purchase Order in the database 
            purchaseOrderId = PurchaseOrder.insertPurchaseOrder(purchase);
        } catch(System.DMLException e){   
            throw new DMLException(e);
        }
        List<PurchaseOrderLineItem__c> purchaseList = new List<PurchaseOrderLineItem__c>();
        for(PurchaseOrderService.SelectProduct sp :selectproductlist){
            sp.selectedProduct.purchaseOrder__c = purchaseOrderId;
            purchaseList.add(sp.selectedProduct);
        }
        try{
            // insert new Purchase Order Line Items in the database
            PurchaseOrderLineItem.insertPurchaseList(purchaseList);
        } catch(System.DMLException e){   
            throw new DMLException(e);
        }
        
    }
    
    public static Product__c getProduct(String pid)
    {
        Set<Id> idSet = new Set<Id>();
        idSet.add(pid);
        List<Product__c> productList = new List<Product__c>();
        productList = new ProductSelector(true).selectByProductId(idSet);
        if(productList != null){
            return productList.get(0);
        }
        return null;
    }
}