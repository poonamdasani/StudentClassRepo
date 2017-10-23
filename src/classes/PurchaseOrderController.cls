public with sharing class PurchaseOrderController 
{
   
    public PurchaseOrderController(ApexPages.StandardController stdController) 
    {
        purchaseOrder = new PurchaseOrder__c();
        selectProductList = new List<PurchaseOrderService.SelectProduct>();
        addProductList = ([SELECT Name,Price__c,Stock__c FROM Product__c] );
        isRender = true;
    }
    
    public PurchaseOrder__c purchaseOrder{get; set;}
    public List<Product__c> addProductList;
    public List<PurchaseOrderService.SelectProduct> selectProductList;
    public String pid;
    public boolean isRender{set;get;}
    public boolean isViewProducts{set;get;}
    
    public PageReference cancel()
    {
        return new PageReference('/a0F/o');
    }
    
    public void addItem()
    {
        pid=ApexPages.currentPage().getParameters().get('selectproductId');
        Product__c p = PurchaseOrderService.getProduct(pid);
        Decimal quantity = Decimal.valueOf(ApexPages.currentPage().getParameters().get(p.Name));
        selectproductlist.add(PurchaseOrderService.addItems(quantity, p));
        addProductList = PurchaseOrderService.removeItem(addProductList, pid);                                         
    }
    
    public void removeItem()
    { 
        pid=ApexPages.currentPage().getParameters().get('selectedproductId');
        PurchaseOrderLineItem__c pi=new PurchaseOrderLineItem__c();
        Product__c p=(PurchaseOrderService.getProduct(pid)); 
        addproductlist.add(p);
        selectProductList = PurchaseOrderService.removeItem(selectProductList, pid);
    }
    
    Public List<Product__c>  getAddProductList()
    {
        return addProductList; 
    }
    
    Public List<PurchaseOrderService.SelectProduct>  getSelectProductList()
    {
        return selectProductList; 
    }
    
    public String getPId()
    {
        return pid;
    } 
    
    public boolean getIsRender()
    {
        return isRender;
    } 
    
    public boolean getIsViewProducts()
    {
        return (addproductlist!=null);
    } 
    
    public PageReference purchase()
    {
        try
        {
        		PurchaseOrderService.purchase(selectProductList, purchaseOrder);
        }
        catch(System.DMLException e)
        {   
            Apexpages.addMessages(e);
            return null;
        }
        PageReference purchaseOrderPage = new ApexPages.StandardController(purchaseOrder).view();
        purchaseOrderPage.setRedirect(true);
        return purchaseOrderPage;
    }
}