/* Query Editor for Generic Object*/
public class newQueryComponentClass
{
	Public String SOQLquery{get;set;}
	Public Integer noOfRecords{get; set;}
	Public Integer size{get;set;}
	Public Boolean flag{get; set;} 
	Public String column{get;set;}
	
	public List<sObject> recordList
	{
	    get
	    {
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
	
	public List<String> fieldsList
	{
        get
        {
            if(SOQLQuery!=null)
            {
                try
                {
	                String query = SOQLquery.toUpperCase();
	                String subString = query.substringBetween('SELECT ',' FROM'); 
	                List<String> fieldsNameList = subString.split(',');
	                fieldsList = new List<String>();
	                for(String columnName : fieldsNameList)
	                {
	                    columnName = columnName.trim();
	                    if(columnName.contains('.'))
	                    {
	                        columnName = columnName.substringAfter('.');
	                    }
	                    fieldsList.add(columnName);
	                }
	            } catch(Exception e)
	            {
	                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Wrong Query Entered. '+e.getMessage()));
	                return null;
	             }
	         }
          		return fieldsList;
        }
        set;
	} 
	
	public void execute()
	{
	    if(con == null && SOQLquery !=null)
        {
            try
            {
               con= new ApexPages.StandardSetController(Database.query(SOQLquery)); 
               flag=false;
            }
            catch(Exception e)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Wrong Query Entered. '+e.getMessage()));
                  
            }
        }
	}
	
	public pageReference sort()
	{
	    String sortingQuery;
	    SOQLquery= SOQLquery.toUpperCase();
	    if(flag== false)
        {
        		sortingQuery = getQueryString(SOQLquery, ' ASC');
            flag= true;
        	 }
	     else
	     {
	          sortingQuery = getQueryString(SOQLquery, ' DESC');
	          flag= false;
	     }
        con = new ApexPages.StandardSetController(Database.query(sortingQuery));
        con.setPageSize(size);
        return null;
	}
	
	public String getQueryString(String SOQLquery, String sortType)
	{
		String sortingQuery;
		if(SOQLquery.contains('LIMIT'))
            {
                sortingQuery= SOQLquery.substringBefore('LIMIT') + ' order by ' + column + sortType + ' LIMIT' + SOQLquery.substringAfter('LIMIT');
            }
            else
            {
                sortingQuery= SOQLquery + ' order by ' + column + sortType +' NULLS LAST ';
            }
         return sortingQuery;
	}
	
	public ApexPages.StandardSetController con
	{
	    get
	    {
	        return con;
	    }
	    set;   
	}
	public Boolean hasNext 
	{
	        get 
	        {
	            if(con != null)
	                return con.getHasNext();
	            else
	                return false;
	        }
	        set;
	}
	    
    public Boolean hasPrevious 
    {
        get 
        {
            if(con != null)
                return con.getHasPrevious();
            else
                return false;
        }
        set;
    }
  
    public Integer pageNumber 
    {
        get 
        {
            if(con != null)
                return con.getPageNumber();
            else
                return 0;
        }
        set;
    }
  
    public void first() 
    {
        con.first();
    }
  
    public void last() 
    {
        con.last();
    }
  
    public void previous() 
    {
        con.previous();
    }
  
    public void next() 
    {
        con.next();
    }
    
    public pageReference refresh() 
    {
        con = null;
        execute();
        con.setPageNumber(1);
        return null;
    }
}