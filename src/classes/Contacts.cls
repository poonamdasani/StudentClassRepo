public class Contacts extends fflib_SObjectDomain {
    
    public Contacts(List<Contact> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Contacts(sObjectList);
        }
    }
    
    public Override void onBeforeUpdate(Map<Id, SObject> exixtingRecords)
    {
     	checkSubject();   
    }
    
    public Override void onBeforeInsert()
    {
        checkSubject();
    }
    
    private void checkSubject(){
        for(Contact contact: (List<Contact>)Records)
        {
            if(contact.Subjects__c.contains('Hindi'))
            {
                contact.addError('Teacher should not be teaching Hindi');
            }
        }
    }
}