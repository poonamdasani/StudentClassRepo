/*
When this field changed and value is “Reset” now then delete all associated  products(opp. Lines) with related Opportunity.
*/
trigger DeleteOpportunityLineItem on Opportunity (after Update) {
    List<Opportunity> OppList = [select id,Custom_Status__c,(select id from OpportunityLineItems) from opportunity where id in :trigger.newMap.keySet()];
    List<OpportunityLineItem> oppLineItemList = new List<OpportunityLineItem>();
    for(Opportunity opp : OppList ){
        if(opp.Custom_Status__c == 'Reset'){
            oppLineItemList.addAll(opp.OpportunityLineItems);
        }
    }
    delete oppLineItemList;  
}