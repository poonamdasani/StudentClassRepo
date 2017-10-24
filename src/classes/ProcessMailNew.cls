global class ProcessMailNew implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String s = '';
        for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf(tAttachment.body);
            s = attachment.Body.toString();
        }
        List<Contact > contactList = new List<Contact > ();
        Dom.Document docx = new Dom.Document();
        docx.load(s);
        dom.XmlNode xroot = docx.getrootelement() ;
        dom.XmlNode [] xrec = xroot.getchildelements() ; //Get all Record Elements
        for(Dom.XMLNode child : xrec){
            Contact contact = new Contact();
            for (dom.XmlNode awr : child.getchildren() ) {
                if (awr.getname() == 'Fname') {
                    contact.FirstName= awr.gettext();
                }
                if (awr.getname() == 'Lname') {
                    contact.LastName= awr.gettext();
                }
                if (awr.getname() == 'AssistantPhone') {
                    contact.AssistantName= awr.gettext();
                }
                if (awr.getname() == 'Email') {
                    contact.Email= awr.gettext();
                }
                if (awr.getname() == 'Experience') {
                    contact.Experience__c= Integer.valueOf(awr.gettext());
                }
                if (awr.getname() == 'Languages') {
                    contact.Languages__c= awr.gettext();
                }
                
            }
            contactList.add(contact);
            
        }
        insert contactList;
        result.success = true;
        return result;
    }
}