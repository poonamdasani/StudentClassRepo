trigger OpportunityTrigger on Opportunity (before update, after update) 
{
	fflib_SObjectDomain.triggerHandler(Opportunities.class);
}