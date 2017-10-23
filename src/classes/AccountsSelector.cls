public class AccountsSelector extends fflib_SObjectSelector 
{
    
    List<String> selectFields = new List<String>{'Name', 'BillingCity', 'BillingState', 'BillingCountry'};
        
    public List<Schema.SObjectField> getSObjectFieldList() 
    {
        return new List<Schema.SObjectField> {
            Account.Name,
            Account.Description,
            Account.AnnualRevenue,
            Account.Id
        };
    }
    
    public AccountsSelector()
    {
        super(false);
    }
    
    public AccountsSelector(Boolean includeFieldSetFields)
    {
        super(includeFieldSetFields);
    }
    
    
    public Schema.SObjectType getSObjectType() 
    {
        return Account.sObjectType;
    }
    
    public List<Account> selectById(Set<ID> idSet) 
    {
        return (List<Account>) selectSObjectsById(idSet);
    }
    
    public List<Account> selectAccountWithFilter(String selectedBillingCity, String selectedBillingState, String selectedBillingCountry)
    {
        String queryString = createQuery(selectedBillingCity,selectedBillingState,selectedBillingCountry);
        return (List<Account>) Database.query(queryString);
    }
    
    public List<Account> selectByAccountWithFilters(String selectedBillingCity, String selectedBillingState, String selectedBillingCountry)
    {
        String queryString = createQuery(selectedBillingCity,selectedBillingState,selectedBillingCountry);
        queryString = queryString + ' Limit 100';
        return (List<Account>) Database.query(queryString);
    }
    
    public List<Account> executeQuery(String SOQLQuery)
    {
        return (List<Account>) Database.query(SOQLQuery); 
    }
    
    private String createQuery(String selectedBillingCity, String selectedBillingState, String selectedBillingCountry)
    {
        boolean flag = false;
        String queryString = String.format('SELECT {0} FROM {1}' ,new List<String>{string.join(selectFields, ','), getSObjectName()} );
        if(selectedBillingCity != '')
        {
            String city = '%' + selectedBillingCity + '%';
            queryString = queryString + ' where BillingCity like :city '  ;
            flag = true;
        }
        
        if(selectedBillingState != '' )
        {
            String state = '%' + selectedBillingState + '%';
            if(flag)
            {
                queryString = queryString + ' and BillingState like :state ';
            }
            else
            {
                queryString = queryString + ' where BillingState like :state ';
                flag = true;
            }
        }
        
        if(selectedBillingCountry != '')
        {
            String country = '%' + selectedBillingCountry + '%';
            if(flag)
            {
                queryString = queryString + ' and BillingCountry like :country';
            }
            else
            {
                queryString = queryString + ' where BillingCountry like :country';
                flag = true;
            }
        }
        flag = false;
        return queryString;
    }  
}