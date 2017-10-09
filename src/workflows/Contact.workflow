<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>TeacherExperence</fullName>
        <ccEmails>parul.shivi@gmail.com</ccEmails>
        <description>Teacher Experience more than 5 years</description>
        <protected>true</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/TeacherExperence</template>
    </alerts>
    <alerts>
        <fullName>UpcomingBirthday</fullName>
        <ccEmails>parul.shivi@gmail.com</ccEmails>
        <description>UpcomingBirthday</description>
        <protected>true</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/UpcomingBirthday</template>
    </alerts>
    <rules>
        <fullName>TeacherExperence</fullName>
        <actions>
            <name>TeacherExperence</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Experience__c</field>
            <operation>greaterThan</operation>
            <value>5</value>
        </criteriaItems>
        <description>workflow to teacher(insert/update) if his experience is more then 5</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UpcomingBirthday</fullName>
        <active>true</active>
        <description>Upcoming Birthday in 2 days.</description>
        <formula>NOT( ISBLANK(Birthdate) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>UpcomingBirthday</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contact.Birthdate</offsetFromField>
            <timeLength>-2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
