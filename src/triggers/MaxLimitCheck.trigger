/*
Not allow insert student if class already reached MaxLimit.
*/
trigger MaxLimitCheck  on Student__c (before Insert) {
    Map<id,Integer> classIDMap = new Map<id,Integer>();
    for(Student__c s : trigger.new){
        classIDMap.put(s.class__c,(Integer)s.class__r.Number_of_Students__c );
        
    }
    
    Map<id,Class__c> classMap = new Map<id,class__c>([Select Number_of_Students__c ,Max_Size__c ,(select id from students__r)  from Class__c where id in :classIDMap.keySet() ]);
    
    for(Student__c s : trigger.new){
        if(classIDMap.get(s.class__c) == (Integer)classMap.get(s.class__c).Max_Size__c ){
            s.addError('Class Reached Max Student Limit');
        }
        else{
            Integer i = (Integer)classIDMap.get(s.class__c);
            i++;
            classIDMap.put(s.class__c,i);
            //classMap.get(s.class__c).Number_of_Students__c++;
        }
    }
}