global Class MyContactsWebService{

    webService static List<Contact> getContacts() {
        List<Contact> contact = [select id, Name from Contact];
        return contact;
    }
}