public class Loans extends fflib_SObjectDomain {
    
    public Loans(List<Loan__c> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Loans(sObjectList);     
        }
    }
    
    public Override void onAfterUpdate(Map<Id, SObject> oldLoanObject)
    {
        notifyUserForStatusChange((Map<Id, Loan__c>)oldLoanObject);
    }
    
    private void notifyUserForStatusChange(Map<Id, Loan__c> oldLoanObject)
    {
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        Map<Id, Loan__c> newLoanMap = new Map<Id, Loan__c>();
        for(Loan__c loan: (List<Loan__c>)Records)
        {
            newLoanMap.put(loan.Id, loan);
        }
        
        for(Loan__c loan : oldLoanObject.values())
        {
            if(loan.Status__c != newLoanMap.get(loan.Id).Status__c){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                string [] toaddress= New string[]{loan.Applicant_Email__c};
                email.setSubject('Loan Status Update');
                String body = 'Dear ' + loan.Applicant_Name__c + '<br> Your loan has been ' + loan.status__c;
                email.setHtmlBody(body );
                email.setToAddresses(toaddress);
                emailsToSend.add(email);
            }
        }
        Messaging.sendEmail(emailsToSend);
    }
}