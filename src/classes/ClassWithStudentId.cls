public with sharing class ClassWithStudentId
{
    /**
method that returns a map where key is class and value is set of studentid in it. 
*/
    public static Map<Class__c,Set<Student__c>> getClassesWithStudentId()
    {
        List<Class__c> myClasses = [SELECT id,(SELECt id FROM Students__r) FROM Class__c]; 
        Map<Class__c,Set<Student__c>> classMap = new Map<Class__c,Set<Student__c>>();
        for(Class__c myClass : myClasses)
        {
            List<Student__c> studentList = myClass.Students__r;
            Set<Student__c> studentsSet = new Set<Student__c>(myClass.Students__r);
            System.debug(studentsSet);
            classMap.put(myclass, studentsSet);
        }
        return classMap;
    }
    
}