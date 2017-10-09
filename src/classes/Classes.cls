public class Classes extends fflib_SObjectDomain {
    
    public Classes(List<Class__c> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Classes(sObjectList);
        }
    }
    
    public Override void onBeforeDelete()
    {
     	checkFemaleStudents();
    }
    
   
    
    private void checkFemaleStudents(){
        Set<Id> femaleClassIdSet = new Set<Id>();
        Set<Id> classIdSet = new Set<Id>();
        for(Class__c classObject : (List<Class__c>)Records){
            classIdSet.add(classObject.Id);
        }
        
        for(Student__c student: (new StudentsSelecter(true).selectByClass(classIdSet)))
        {
            femaleClassIdSet.add(student.Class__c);
        }
        
        for(Class__c classObject : (List<Class__c>)Records)
        {
			if(femaleClassIdSet.contains(classObject.Id))
            {
                classObject.addError('Could not remove class as it contains Female Students');
            }
        }
    }
}