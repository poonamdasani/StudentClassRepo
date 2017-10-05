/*
Not allow delete to class if there are more then one Female students
*/

trigger RestrictClassDeletion on Class__c (before delete) {
    // take class list from query
    List<class__c> classList = [select id,(select sex__c from students__r where sex__c='female' )from Class__c where id in :trigger.oldMap.keySet()];
    for(class__c c : classList){
        Integer count = c.students__r.size();
        if(count > 1){
            //add error in the record
            trigger.oldMap.get(c.id).addError('Class cannot be delete if female student present more than one');
        }
    }  
    
    
}