public with sharing class StudentNameController {

    public Student__c studentObj{get;set;}
    public Id studentId{get;set;}
    Map<Id,Student__c> studentMap = new Map<Id,Student__c>();
    
    public StudentNameController() {
        // query for fetching all the record of th Student Object
        studentMap = new Map<id,Student__c>([select Id,Name,Last_Name__c,DOB__c,Age__c,Email__c from Student__c]);
        
    }
   
    public List<SelectOption> getStudentsName(){
        // List of options in picked list
        List<SelectOption> optionList = new List<SelectOption>();
        // list of students id
        List<Id> studentsId = new List<Id>();
        // add all student id from map
        studentsId.addAll(studentMap.keySet());
        for( Id student : studentsId){
            // add options in the optionList
            optionList.add(new SelectOption(studentMap.get(student).id, studentMap.get(student).Name + ' ' + studentMap.get(student).Last_Name__c));
        }       
        return optionList ;
    }
    
    public PageReference setStudent() {
        studentObj = studentMap.get(studentId);
        return null;
    }
}