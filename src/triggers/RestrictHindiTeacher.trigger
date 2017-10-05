/*
Not Allow any teacher to insert/update if that teacher is teaching Hindi.
*/
trigger RestrictHindiTeacher on Contact (before insert, before update) {
    for(Contact s : trigger.new){         
        if(s.Subjects__c != null && s.Subjects__c != ''){
            // initialize set for subject
            Set<String> subjectSet = new Set<String>(); 
            // add all subject from the subject__c multi picklist
            subjectSet.addAll(s.Subjects__c.split(';'));
            if(subjectSet.contains('Hindi')){
                // add error in the subject
                s.addError('Teacher who teaches Hindi are restricted for Insert and Update');
            }
        }
    }
}