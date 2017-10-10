public class ContactsSelector extends fflib_SObjectSelector {
    
    List<String> selectFields = new List<String> {'Id', 'Account.ID', 'Account.ContactIDs__c', 'Name'};
    
    public ContactsSelector()
	{
		super(false);
	}
	
	public ContactsSelector(Boolean includeFieldSetFields)
	{
		super(includeFieldSetFields);
	}

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Contact.Account.ID,
            Contact.Id
           	//Contact.Account.ContactIDs__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }

    public List<Contact> selectContacts() {
        String query = String.format(
            'SELECT {0} FROM {1} LIMIT 5', new List<String>{string.join(selectFields, ','), getSObjectName()});
        return (List<Contact>) database.query(query);
    }
    
    public List<Contact> selectById(Set<ID> idSet) {
        String query = String.format(
            'SELECT {0} FROM {1} WHERE id IN :idSet', new List<String>{string.join(selectFields, ','), getSObjectName()});
        return (List<Contact>) database.query(query);
    }
    
    public List<Contact> selectByAccountId(Set<ID> idSet) {
        String query = String.format(
            'SELECT {0} FROM {1} WHERE AccountId IN :idSet', new List<String>{string.join(selectFields, ','), getSObjectName()});
        return (List<Contact>) database.query(query);
    }
    
}