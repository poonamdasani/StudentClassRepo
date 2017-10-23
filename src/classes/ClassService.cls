public class ClassService {

    
    public static List<Class__c> getClassDetails()
    {
        List<Class__c> classList = new ClassSelecter(true).selectClassDetails();
        return classList;
    }
    
     public static List<Class__c> getClassDetailsById(String classId)
    {
        Set<Id> idSet = new Set<Id>();
        idSet.add(classId);
        List<Class__c> classList = new ClassSelecter(true).selectById(idSet);
        return classList;
    }
}