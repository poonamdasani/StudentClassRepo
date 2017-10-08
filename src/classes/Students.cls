public class Students extends fflib_SObjectDomain {
	public Students(List<Student__c> sObjectList)
    {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Students(sObjectList);
        }
    }
    
    public Override void onBeforeInsert()
    {
        checkMaxLimit();
    }
    
    private void checkMaxLimit(){
        Set<Id> classId = new Set<Id>();
        for(Student__c student: (List<Student__c>)Records)
        {
          classId.add(student.Class__c);
        }
        
        Map<Id, Class__c> classMap = new Map<Id, Class__c>(new ClassSelecter(true).selectById(classId));
        for(Student__c student: (List<Student__c>)Records)
        {
          if(classMap.containsKey(student.Class__c) && classMap.get(student.Class__c).Max_Size__c <= classMap.get(student.Class__c).Number_of_Students__c)
          {
            	student.addError('Max Size crossed');
          }
        }
    }
}