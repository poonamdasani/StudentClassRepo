public class OpportunitiesSelector extends fflib_SObjectSelector {
    
    List<String> selectFields = new List<String> {'Id', 'Manager__c', 'BillToContact__r.AccountId', 'StageName'};
    List<String> selectOpportunityFieldsWithAccount = new List<String> {'Account.Name', 'Sum(Amount)'};

    public OpportunitiesSelector()
	{
		super(false);
	}
	
	public OpportunitiesSelector(Boolean includeFieldSetFields)
	{
		super(includeFieldSetFields);
	}
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Opportunity.ID
        };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Opportunity.sObjectType;
    }
    
    public List<Opportunity> selectById(Set<ID> idSet) {
        String query = String.format(
            'SELECT {0} FROM {1} WHERE id IN :idSet', new List<String>{string.join(selectFields, ','), getSObjectName()});
        return (List<Opportunity>) database.query(query);
    }
    
    public List<AggregateResult> selectAggregateAccountByName()
    {
        String query = String.format('Select  {0} sum from {1} where Account.Name != \'\' Group By Account.Name limit 10', new List<String>{string.join(selectOpportunityFieldsWithAccount,','), getSObjectName()});
    	return (List<AggregateResult>) database.query(query);
    }
}