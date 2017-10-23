public with sharing class MyClassController
{
    public List<Class__c> classList { get; set; }
    public String classId {get; set;}
    public Class__c myClass{get;set;}
    private Boolean isRender=false;
    
    public MyClassController() 
    {
        classList = ClassService.getClassDetails();
    }
    
    public Boolean getIsRender()
    {
        return isRender;
    }
    
    public void editClass()
    {
        classId  = ApexPages.CurrentPage().getParameters().get('classId');
        List<Class__c> classList= ClassService.getClassDetailsById(classId);
        if(classList.size() > 0)
        {
            isRender=true;
            myClass=classList.get(0);
        }
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Class Id not Found'+classId ));
        }
    }
    
    public void saveClass()
    {
        isRender=false;
        update myClass;
    }
    
    public void deleteClass()
    {
        List<Class__c> classList=ClassService.getClassDetailsById(classId);
        delete classList;
    }
    
}