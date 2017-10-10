public class AccountsSelector extends fflib_SObjectSelector {
    
    List<String> selectFields = new List<String>{'Name', 'BillingCity', 'BillingState', 'BillingCountry'};

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Account.Name,
            Account.Description,
            Account.AnnualRevenue,
            Account.Id};
    }

    public AccountsSelector()
	{
		super(false);
	}
	
	public AccountsSelector(Boolean includeFieldSetFields)
	{
		super(includeFieldSetFields);
	}
    
    
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }

    public List<Account> selectById(Set<ID> idSet) {
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
        // set the limit in query
        queryString = queryString + ' Limit 100';
        return (List<Account>) Database.query(queryString);
    }
    
    private String createQuery(String selectedBillingCity, String selectedBillingState, String selectedBillingCountry)
    {
        boolean flag = false;
        String queryString = String.format('SELECT {0} FROM {1}' ,new List<String>{string.join(selectFields, ','), getSObjectName()} );
        if(selectedBillingCity != ''){
            String city = '%' + selectedBillingCity + '%';
            // append the where clause in query
            queryString = queryString + ' where BillingCity like :city '  ;
            flag = true;
        }
        
        if(selectedBillingState != '' ){
            String state = '%' + selectedBillingState + '%';
            if(flag){
                // append the another condition using and clause in query
                queryString = queryString + ' and BillingState like :state ';
            }
            else{
                // append the where clause in query
                queryString = queryString + ' where BillingState like :state ';
                flag = true;
            }
            
        }
        
        if(selectedBillingCountry != ''){
            String country = '%' + selectedBillingCountry + '%';
            if(flag){
                // append the another condition using and clause in query
                queryString = queryString + ' and BillingCountry like :country';
            }
            else{
                // append the where clause in query
                queryString = queryString + ' where BillingCountry like :country';
                flag = true;
            }
            
        }
        flag = false;
        return queryString;
    }
}