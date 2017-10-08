public class Opportunities extends fflib_SObjectDomain {
    
    public Opportunities(List<Opportunity> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Opportunities(sObjectList);
        }
    }
    
    public Override void onBeforeUpdate(Map<Id, SObject> existingRecords)
    {
        Set<id> oppIdSet = new Set<Id>();
        for(Opportunity opp : (List<Opportunity>) Records){
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