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
    
    public Override void onAfterInsert()
    {
       updateMyCount(null);
    }
    
    public Override void onAfterUpdate(Map<Id, SObject> studentObject)
    {
       updateMyCount((Map<Id, Student__c>)studentObject);
    }
    
    public Override void onBeforeInsert()
    {
        checkMaxLimit();
    }
    
    private void updateMyCount(Map<Id, Student__c> oldStudentMap){
        Set<Id> classId = new Set<Id>();
        for(Student__c student: (List<Student__c>)Records)
        {
          classId.add(student.Class__c);
        }
        if(oldStudentMap != null){
            for(Student__c student: oldStudentMap.values())
            {
              classId.add(student.Class__c);
            }
        }
        
        Map<Id, Class__c> classMap = new Map<Id, Class__c>(new ClassSelecter(true).selectById(classId));
        for(Student__c student: (List<Student__c>)Records)
        {
          if(oldStudentMap != null)
          {
              //update call
              if(classMap.containsKey(oldStudentMap.get(student.Id).Class__c) && student.Class__c != oldStudentMap.get(student.Id).Class__c){
          		classMap.get(oldStudentMap.get(student.Id).Class__c).My_Count__c -= 1;
              }
          }
            if(classMap.containsKey(student.Class__c)){
          		classMap.get(student.Class__c).My_Count__c += 1;
              }
        }
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