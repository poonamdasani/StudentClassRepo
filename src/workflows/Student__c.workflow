<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>StudentRecordUpdate</fullName>
        <ccEmails>parul.shivi@gmail.com</ccEmails>
        <description>StudentRecordUpdate</description>
        <protected>true</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>pdsadmin@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pdsauser@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/StudentUpdateRecords</template>
    </alerts>
    <fieldUpdates>
        <fullName>MarriedCheck</fullName>
        <description>If any student have wife name then automatically its married.</description>
        <field>Married__c</field>
        <literalValue>1</literalValue>
        <name>MarriedCheck</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>MarriedCheck</fullName>
        <actions>
            <name>MarriedCheck</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>If any student have wife name then automatically its married</description>
        <formula>NOT(ISBLANK(Wife_Name__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>StudentUpdateRecord</fullName>
        <actions>
            <name>StudentRecordUpdate</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>workflow rule to send email to student when His record gets update. Email template in this case should have students className and contact name with it</description>
        <formula>NOT( ISBLANK(Last_Name__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
