public class StudentsSelector extends fflib_SObjectSelector 
{
List<String> selectFields = new List<String> {'Id', 'Class__c '};

    public StudentsSelector()
	{
		super(false);
	}
	
	public StudentsSelector(Boolean includeFieldSetFields)
	{
		super(includeFieldSetFields);
	}
    
    public List<Schema.SObjectField> getSObjectFieldList() 
    {
        return new List<Schema.SObjectField> {
            Student__c.ID
        };
    }
    
    public Schema.SObjectType getSObjectType() 
    {
        return Student__c.sObjectType;
    }
    
    public Integer getFemaleStudentCount(Set<ID> idSet) 
    {
        String sex = 'Female';
        String query = String.format(
            'SELECT Count(Id) FROM {0} WHERE Class__c IN :idSet AND Sex__c = :sex', new List<String>{getSObjectName()});
        return (Integer) database.countQuery(query);
    }
    
}