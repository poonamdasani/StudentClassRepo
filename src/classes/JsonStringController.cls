public with sharing class JsonStringController 
{
     public String jsonString {get;set;}
    
     public JsonStringController ()
     {
         jsonString = prepareString();
     }
     
     public String prepareString()
     {
         List<Contact> contactList = ContactsService.getContactsList();
         return JSON.serializePretty(contactList);
         
     }   
}