public class ProductSelector extends fflib_SObjectSelector 
{  
    List<String> selectFields = new List<String>{'Name','Price__c', 'Stock__c'};
        
    public List<Schema.SObjectField> getSObjectFieldList() 
    {
        return new List<Schema.SObjectField> 
        {
            Product__c.Id,
			Product__c.Name
         };
    }

    public ProductSelector()
	{
		super(false);
	}
	
	public ProductSelector(Boolean includeFieldSetFields)
	{
		super(includeFieldSetFields);
	}
    
    public Schema.SObjectType getSObjectType() 
    {
        return Product__c.sObjectType;
    }

    public List<Product__c> selectByProductId(Set<ID> idSet) 
    {
    	
    	List<Product__c> products = new List<Product__c>();
		if(idSet != null && idSet.size() > 0) {
        		String query = String.format(
            		'SELECT {0} FROM {1} WHERE Id IN :idSet', new List<String>{string.join(selectFields, ','), getSObjectName()});
        		return (List<Product__c>) database.query(query);
		}
		return products;
    }

}