/*
In Opportunity, If the stage is changed from another value  to CLOSED_WON or CLOSED_LOST, populates the Close Date field with Today().
*/
trigger UpdateClosedDate on Opportunity (before update) {
  
    for(Opportunity opp: Trigger.new){
        if((trigger.oldMap.get(opp.ID).StageName != 'CLOSED WON' || trigger.oldMap.get(opp.ID).StageName != 'CLOSED LOST') && (opp.StageName == 'CLOSED WON' || opp.StageName == 'CLOSED LOST')){
            opp.closeDate = System.today();
        }     
    }
}