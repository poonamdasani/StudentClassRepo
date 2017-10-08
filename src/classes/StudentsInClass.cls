public class StudentsInClass {
   
    public static List<Student__c> getStudentList(String classId){
        List<Student__c> students = [SELECT Name FROM Student__c WHERE Class__c =: classId];
        return students;
    }
    
    public static List<String> getStudentNames(String classId){
        List<Student__c> students = [SELECT Name, Last_Name__c FROM Student__c WHERE Class__c =: classId];
        List<String> names = new List<String>();
        for(Student__c student : students){
            names.add(student.Name + ' ' + student.Last_Name__c);
        }
        return names;
    }
   
}