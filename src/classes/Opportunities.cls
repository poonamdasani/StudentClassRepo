public class Opportunities extends fflib_SObjectDomain 
{
    
    public Opportunities(List<Opportunity> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable 
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) 
        {
            return new Opportunities(sObjectList);
        }
    }
    
    public Override void onAfterUpdate(Map<Id, SObject> existingRecords)
    {
        deleteOpporunityLines((Map<Id, Opportunity>) existingRecords);
    }
    
    public Override void onBeforeUpdate(Map<Id, SObject> existingRecords)
    {
        checkBillStatus();
        checkStageChangedStatus((Map<Id, Opportunity>)existingRecords);
    }
    
    public static List<Opportunity> getOpportunityManager(String opportunityId)
    {
        Set<Id> idSet = new Set<Id>();
        idSet.add(opportunityId);
        return (new OpportunitiesSelector(true).selectById(idSet));
    }
    
    public static List<SelectOption> getSelectedContact(List<Opportunity> oppList)
    {
        Set<Id> idSet = new Set<Id>();
        for(Opportunity opp : oppList)
        {
            idSet.add(opp.Manager__c);
        }
        List<Contact> contactList=(new ContactsSelector(true).selectByAccountId(idSet));
        List<SelectOption> contactSelected = new List<SelectOption>();
        for(Contact c :contactList)
        {
            contactSelected.add(new SelectOption(c.id,c.name));
        }
        return contactSelected;
    }
    
    private void deleteOpporunityLines(Map<Id, Opportunity> oldOpportunityMap)
    {
        Set<Id> opportunityId = new Set<Id>();
        for(Opportunity opp: (List<Opportunity>)Records)
        {
          if(opp.Custom_Status__c != oldOpportunityMap.get(opp.Id).Custom_Status__c && opp.Custom_Status__c =='Reset')
          {
              opportunityId.add(opp.Id);
          }
        }
        
        
        List<OpportunityLineItem> opportunityLineItemList = (new OpportunityLineItemsSelector(true).selectByOpportunityId(opportunityId));
        delete opportunityLineItemList;
    }
    
    private void checkStageChangedStatus(Map<Id, Opportunity> oldOpportunityMap)
    {
        Set<Id> opportunityId = new Set<Id>();
        for(Opportunity opportunities: (List<Opportunity>)Records)
        {
          opportunityId.add(opportunities.StageName);
        }
        if(oldOpportunityMap != null)
        {
            for(Opportunity opportunities: oldOpportunityMap.values())
            {
              opportunityId.add(opportunities.StageName);
            }
        }
        
        Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>(new OpportunitiesSelector(true).selectById(opportunityId));
        for(Opportunity opportunities: (List<Opportunity>)Records)
        {
          if(oldOpportunityMap != null)
          {
              if((oldOpportunityMap.get(opportunities.id).StageName != 'CLOSED WON' || oldOpportunityMap.get(opportunities.id).StageName != 'CLOSED LOST') && (opportunities.StageName == 'CLOSED WON' || opportunities.StageName == 'CLOSED LOST') )
              {
          		opportunityMap.get(oldOpportunityMap.get(opportunities.Id).StageName).CloseDate  = System.Today();
              }
          }
        }
    }
    
    private void checkBillStatus()
    {
        Set<id> oppIdSet = new Set<Id>();
        for(Opportunity opp : (List<Opportunity>) Records)
        {
            oppIdSet.add(opp.Id); 
        }
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>(new OpportunitiesSelector(true).selectById(oppIdSet));
        for(Opportunity opp : (List<Opportunity>) Records){
        if(opp.BillToContact__c != NULL)
                {
                   if(opp.Manager__c == NULL)
                   {
                       opp.Manager__c= oppMap.get(opp.Id).BillToContact__r.AccountId;
                   }
                }
        }
    }

}