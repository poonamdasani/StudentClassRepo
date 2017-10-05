/*
When insert/update any student’s in class then  update MyCount Accordingly
*/
trigger UpdateMyCount  on Student__c (after Insert, after update) {
    List<Class__c> classList = [SELECT ID, My_Count__c  FROM Class__c WHERE ID IN(SELECT Class__c FROM Student__c WHERE ID IN :Trigger.newMap.keySet())];
    for(Class__c c : classList){
        if(c.My_Count__c  == null){
            c.My_Count__c  = 1;
        }
        else{
            c.My_Count__c  = c.My_Count__c  + 1;   
        }
    }
    update classList;
    
}