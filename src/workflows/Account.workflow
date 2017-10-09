<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>IncreasedAnnualRevenue</fullName>
        <description>annualrevenue is greater than $1,000,000</description>
        <protected>true</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/AccountRevenue</template>
    </alerts>
    <fieldUpdates>
        <fullName>Field_Update</fullName>
        <field>Type</field>
        <literalValue>Customer</literalValue>
        <name>Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_1</fullName>
        <field>Type</field>
        <literalValue>Prospect</literalValue>
        <name>Field Update 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lock_Record</fullName>
        <field>Type</field>
        <literalValue>Pending</literalValue>
        <name>Lock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Texas_Owner</fullName>
        <description>New Field Updated</description>
        <field>OwnerId</field>
        <lookupValue>pdsadmin@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Texas Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AccountAnnualRevenue</fullName>
        <actions>
            <name>IncreasedAnnualRevenue</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>the account&apos;s annual revenue is greater than $1,000,000</description>
        <formula>AND (AnnualRevenue &gt;1000000,  CreatedBy.Id !=  LastModifiedBy.Id  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Texas Accounts</fullName>
        <actions>
            <name>Texas_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.BillingState</field>
            <operation>equals</operation>
            <value>TX</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Follow_Up_with_New_Account</name>
                <type>Task</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>Follow_Up_with_New_Account</fullName>
        <assignedTo>pdsadmin@gmail.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Follow Up with New Account</description>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Follow Up with New Account</subject>
    </tasks>
</Workflow>
