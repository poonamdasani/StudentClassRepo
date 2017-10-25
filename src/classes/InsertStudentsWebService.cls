global Class InsertStudentsWebService{

    webService static Id insertStudents(String studentName, String lastName) {
        Student__c stu = new Student__c(Name = studentName, Last_Name__c = lastName);
        insert stu;
        return stu.Id;
    }
}