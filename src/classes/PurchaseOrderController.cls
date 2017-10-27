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
        PageReference returnPage = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));  
        return returnPage;
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
    
    Public List<Product__c>  getaddproductlist()
    {
        Return addproductlist; 
    }
    
    Public List<PurchaseOrderService.SelectProduct>  getselectproductlist()
    {
        Return selectproductlist; 
    }
    
    public String getpid()
    {
        return pid;
    } 
    
    public boolean getisRender()
    {
        return isRender;
    } 
    
    public boolean getisViewProducts()
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
        PageReference acctPage = new ApexPages.StandardController(purchaseOrder).view();
        acctPage.setRedirect(true);
        return acctPage;
    }
}