public with sharing class JsonStringController {
     public String jsonString {get;set;}
    
     public JsonStringController (){
         // call the prepareString() method
         jsonString = prepareString();
     }
     public String prepareString(){
         // get the List of Contact
         List<Contact> contactList = ContactsService.getContactsList();
         // create json String and return
         return JSON.serializePretty(contactList);
         
     }   
}