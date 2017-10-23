public class OpportunitiesSelector extends fflib_SObjectSelector 
{
    
    List<String> selectFields = new List<String> {'Id', 'Manager__c', 'BillToContact__r.AccountId', 'StageName'};

    public OpportunitiesSelector()
	{
		super(false);
	}
	
	public OpportunitiesSelector(Boolean includeFieldSetFields)
	{
		super(includeFieldSetFields);
	}
    
    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField> 
        {
            Opportunity.ID
        };
    }
    
    public Schema.SObjectType getSObjectType() 
    {
        return Opportunity.sObjectType;
    }
    
    public List<Opportunity> selectById(Set<ID> idSet) 
    {
        String query = String.format(
            'SELECT {0} FROM {1} WHERE id IN :idSet', new List<String>{string.join(selectFields, ','), getSObjectName()});
        return (List<Opportunity>) database.query(query);
    }
}