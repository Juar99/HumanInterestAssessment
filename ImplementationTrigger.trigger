trigger ImplementationTrigger on Implementation__c (before insert, before update) {
    
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore){
        ImplementationTriggerHelper.updateIMRepManager(Trigger.new, Trigger.oldMap);
    }
}