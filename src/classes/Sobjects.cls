/**
Class which show the list of sobjects exists in Organization.
*/

public with sharing class Sobjects
{
    public static List<Schema.SObjectType> getNames()
    {
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();    
        return gd;
    }
    
    public static List<SelectOption> getName()
    {
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();    
        System.debug(gd);
        List<SelectOption> options = new List<SelectOption>();
        for(Schema.SObjectType f : gd)
        {
            options.add(new SelectOption(f.getDescribe().getLabel(),f.getDescribe().getLabel()));
        }
        return options;
    }
}