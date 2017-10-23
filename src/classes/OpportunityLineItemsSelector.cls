public class OpportunityLineItemsSelector extends fflib_SObjectSelector
{
    List<String> selectFields = new List<String> {'Id', 'OpportunityId'};
    
    public OpportunityLineItemsSelector()
	{
		super(false);
	}
	
	public OpportunityLineItemsSelector(Boolean includeFieldSetFields)
	{
		super(includeFieldSetFields);
	}

    public List<Schema.SObjectField> getSObjectFieldList() 
    {
        return new List<Schema.SObjectField> {
            OpportunityLineItem.Id,
                OpportunityLineItem.Opportunity.Id
        };
    }

    public Schema.SObjectType getSObjectType() 
    {
        return OpportunityLineItem.sObjectType;
    }

    public List<OpportunityLineItem> selectByOpportunityId(Set<ID> idSet) 
    {
        String query = String.format(
            'SELECT {0} FROM {1} WHERE opportunityId IN :idSet', new List<String>{string.join(selectFields, ','), getSObjectName()});
        return (List<OpportunityLineItem>) database.query(query);
    }
}