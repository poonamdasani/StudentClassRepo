public with sharing class OpportunityBillToContactController{
    public List<Opportunity> opp = new List<Opportunity>();
    public String selectedValue{get; set;}
    
    public List<SelectOption> getContactList(){
        String id = ApexPages.CurrentPage().getParameters().get('id');
        if(id == null)
        {
            return null;
        }
        List<SelectOption> contactSelected = new List<SelectOption>();
        opp = Opportunities.getOpportunityManager(id);
        if(opp.get(0) != null)
        {
            contactSelected = Opportunities.getSelectedContact(opp);
        }
        return contactSelected;
    }
    
    public PageReference save(){
        if(opp.size() > 0){
            opp.get(0).BillToContact__c = selectedValue;
            update opp;
        }
        return pageRedirect();
    }
    
    public PageReference cancel(){
        return pageRedirect();
    }
    
    public PageReference clear(){
        if(opp.size() > 0){
            opp.get(0).BillToContact__c = null;
            update opp;
            
        }
        return pageRedirect();
    }
    
    public string selectedAsset {get;set;}

    public PageReference pageRedirect() 
    {
        // Your code here
    
        PageReference redirect = new PageReference('/'+opp.get(0).id); 
    
        // pass the selected asset ID to the new page
        redirect.getParameters().put('id',selectedAsset); 
        redirect.setRedirect(true); 
    
        return redirect;
    }
    
}