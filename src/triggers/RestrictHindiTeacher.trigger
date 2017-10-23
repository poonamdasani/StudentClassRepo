/*
Not Allow any teacher to insert/update if that teacher is teaching Hindi.
*/
trigger RestrictHindiTeacher on Contact (before insert, before update) 
{
    for(Contact s : trigger.new){         
        if(s.Subjects__c != null && s.Subjects__c != '')
        {
            Set<String> subjectSet = new Set<String>(); 
            subjectSet.addAll(s.Subjects__c.split(';'));
            if(subjectSet.contains('Hindi'))
            {
                s.addError('Teacher who teaches Hindi are restricted for Insert and Update');
            }
        }
    }
}