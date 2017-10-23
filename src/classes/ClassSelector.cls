public class ClassSelecter extends fflib_SObjectSelector 
{
    List<String> selectFields = new List<String> {'Id', 'Number_of_Students__c', 'Max_Size__c ', 'My_Count__c', 'Class_Teacher__c', 'Board__c', 'Detailed_Description__c', 'Fee__c'};

    public ClassSelector()
    {
        super(false);
    }
    
    public ClassSelector(Boolean includeFieldSetFields)
    {
        super(includeFieldSetFields);
    }
    
    public List<Schema.SObjectField> getSObjectFieldList() 
    {
        return new List<Schema.SObjectField> 
        {
            Class__c.ID
        };
    }
    
    public Schema.SObjectType getSObjectType() 
    {
        return Class__c.sObjectType;
    }
    
    public List<Class__c> selectClassDetails() 
    {
        String query = String.format(
            'SELECT {0} FROM {1} LIMIT 100', new List<String>{string.join(selectFields, ','), getSObjectName()});
        return (List<Class__c>) database.query(query);
    }
    
    public List<Class__c> selectById(Set<ID> idSet) 
    {
        String query = String.format(
            'SELECT {0} FROM {1} WHERE Id IN :idSet', new List<String>{string.join(selectFields, ','), getSObjectName()});
        return (List<Class__c>) database.query(query);
    }

}