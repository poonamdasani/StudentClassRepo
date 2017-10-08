@isTest
public class TestStudentsInClass {
    
    @isTest
    static void testGetStudentList(){
        // insert dummy class record
        Class__c c = new Class__c(Board__c = 'CBSE',Max_Size__c=40);
        insert c;
        
        // insert dummy student record
        Student__c s = new Student__c(Name='Poonam',Last_Name__c='Dasani',Class__c=c.id);
        insert s;
        
        List<Student__c> studentList = StudentsInClass.getStudentList(c.id);
        System.assertEquals(s.id, studentList.get(0).id );
        
        List<String> studentName = StudentsInClass.getStudentNames(c.id);
        System.assertEquals('Poonam Dasani', studentName.get(0) );
        
        
        delete c;
        
    }
}