trigger LoanTrigger on Loan__c (after update) {
    fflib_SObjectDomain.triggerHandler(Loans.class);
}