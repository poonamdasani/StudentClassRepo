/*
When insert/update any student’s in class then  update MyCount Accordingly
*/
trigger UpdateMyCount  on Student__c (after Insert, after update) {
    
    List<Class__c> classList = [select id, My_Count__c  from class__c where id IN(select class__c from student__c where id IN :Trigger.newMap.keySet())];
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