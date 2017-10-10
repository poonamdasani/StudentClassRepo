public class ContactsService {
 public static List<Contact> getContactsList()
    {
        return (new ContactsSelector(true).selectContacts());
    }
}