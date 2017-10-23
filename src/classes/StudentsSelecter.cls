public class StudentsSelecter extends fflib_SObjectSelector 
{
	List<String> selectFields = new List<String> {'Id', 'Class__c '};

    public StudentsSelecter()
	{
		super(false);
	}
	
	public StudentsSelecter(Boolean includeFieldSetFields)
	{
		super(includeFieldSetFields);
	}
    
    public List<Schema.SObjectField> getSObjectFieldList() 
    {
        return new List<Schema.SObjectField> 
        {
            Student__c.ID
        };
    }
    
    public Schema.SObjectType getSObjectType() 
    {
        return Student__c.sObjectType;
    }
    
    public List<Student__c> selectByClass(Set<ID> idSet) 
    {
        String sex = 'Female';
        String query = String.format(
            'SELECT {0} FROM {1} WHERE Class__c IN :idSet AND Sex__c = :sex', new List<String>{string.join(selectFields, ','), getSObjectName()});
        return (List<Student__c>) database.query(query);
    }
    
}