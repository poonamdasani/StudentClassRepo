/* Query Editor for Account Object*/
public class AccountsController{
    Public String SOQLquery{get;set;}
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    Public Boolean flag{get; set;} //to decided the ASC or DSC order of records
    Public String column{get;set;}
    public List<Account> recordList{
        get{
            if(con != null && recordList == null)
            {
                size= 5;
                con.setPageSize(size);
                noOfRecords = con.getResultSize();
                return con.getRecords();
            }
            else
            {
                noOfRecords =0;
                size=1;
                return null;
            }
        }
        set;
    }
    
    public List<String> fieldsList{
        get{
            if(SOQLQuery!=null){
                try{
                    fieldsList = AccountsService.getFieldList(SOQLQuery, fieldsList);
                } catch(Exception e){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Wrong Query Entered. '+e.getMessage()));
                    return null;
                }
            }
            return fieldsList;
        }
        set;
    } 
    
    public void execute(){
        if(con == null && SOQLquery !=null)
        {
            try{
                List<Account> accountsList = new List<Account>();
                accountsList = AccountsService.execute(SOQLQuery);
                con= new ApexPages.StandardSetController(accountsList); 
                flag=false;
                
            }
            catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Wrong Query Entered. '+e.getMessage()));
                
            }
        }
    }
    
    public pageReference sort(){
        String sortingQuery;
        sortingQuery = AccountsService.sort(SOQLQuery, flag, column);
        List<Account> accountsList = new List<Account>();
        accountsList = AccountsService.execute(sortingQuery);
        con = new ApexPages.StandardSetController(accountsList);
        con.setPageSize(size);
        return null;
    }
    public ApexPages.StandardSetController con{
        get{
            return con;
        }
        set;   
    }
    public Boolean hasNext {
        get {
            if(con != null)
                return con.getHasNext();
            else
                return false;
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            if(con != null)
                return con.getHasPrevious();
            else
                return false;
        }
        set;
    }
    
    public Integer pageNumber {
        get {
            if(con != null)
                return con.getPageNumber();
            else
                return 0;
        }
        set;
    }
    
    public void first() {
        con.first();
    }
    
    public void last() {
        con.last();
    }
    
    public void previous() {
        con.previous();
    }
    
    public void next() {
        con.next();
    }
    public pageReference refresh() {
        con = null;
        execute();
        con.setPageNumber(1);
        return null;
    }
}