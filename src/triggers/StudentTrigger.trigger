trigger StudentTrigger on Student__c (before insert, after insert, after update) {
	fflib_SObjectDomain.triggerHandler(Students.class);
}