/*
Not allow delete to class if there are more then one Female students
*/

trigger RestrictClassDeletion on Class__c (before delete) {
    List<class__c> classList = [SELECT ID,(SELECT Sex__c FROM Students__r WHERE Sex__c='Female' )FROM Class__c WHERE ID IN :trigger.oldMap.keySet()];
    for(Class__c c : classList){
        Integer count = c.Students__r.size();
        if(count > 1){
            trigger.oldMap.get(c.id).addError('Class cannot be delete if female student present more than one');
        }
    }  
     
}