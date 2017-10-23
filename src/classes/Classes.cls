public class Classes extends fflib_SObjectDomain 
{
    
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
        Set<Id> classIdSet = new Set<Id>();
        for(Class__c classObject : (List<Class__c>)Records){
            classIdSet.add(classObject.Id);
        }
        
        Integer countFemaleStudents = new StudentsSelector(true).getFemaleStudentCount(classIdSet);
        
        for(Class__c classObject : (List<Class__c>)Records)
        {
			if(countFemaleStudents != 0)
            {
                classObject.addError('Could not remove class as it contains Female Students');
            }
        }
    }
}