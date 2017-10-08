trigger OpportunityTrigger on Opportunity (before update) {
	fflib_SObjectDomain.triggerHandler(Opportunities.class);
}