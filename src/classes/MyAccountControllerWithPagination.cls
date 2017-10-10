public with sharing class MyAccountControllerWithPagination
{
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    
    public String selectedBillingCity { get; set; }
    public String selectedBillingState { get; set; }
    public String selectedBillingCountry { get; set; }
    private boolean flag=false;
    
    // Apex Standard Set Controller
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null)
            {
                // intialize new Apex Standard Set Controller
                setCon = new ApexPages.StandardSetController(AccountsService.getAccountRecordsWithFilter(selectedBillingCity,selectedBillingState,selectedBillingCountry));
                // set the page size
                setCon.setPageSize(size);
                // get the number of Record
                noOfRecords = setCon.getResultSize();
                flag = false;
            }
            return setCon;
        }
        set;
    }
    // get the list of the accounts
    public List<Account> getAccounts(){
        // return list of account Object
        return (List<Account>)setCon.getRecords();
    }
    
    // filter the accounts Object List
    public void search()
    {
        setCon = null;
        getAccounts();
        setCon.setPageNumber(1);
        
    }
    
    public pageReference refresh() {
        setCon = null;
        getAccounts();
        setCon.setPageNumber(1);
        return null;
    }
    
    public void first() {
        setCon.first();
    }
    
    public void last() {
        setCon.last();
    }
    
    public void previous() {
        setCon.previous();
    }
    
    public void next() {
        setCon.next();
    }
    
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    
    public Boolean hasPrevious {
        get {
              return setCon.getHasPrevious();
        }
        set;
    }
}