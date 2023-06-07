public with sharing class ImplementationTriggerHelper {
    public static void updateIMRepManager(List<Implementation__c> newImps, Map<Id, Implementation__c> oldImpMap){

        List<Id> ownerIds = new List<Id>();
        List<Implementation__c> impsToProcess = new List<Implementation__c>();
        for(Implementation__c imp : newImps){
            Implementation__c oldImp = Trigger.isUpdate && oldImpMap.containsKey(imp.Id) ? oldImpMap.get(imp.Id) : null;
            if(imp.Stage__c != 'Complete' && (Trigger.isInsert || imp.ownerId != oldImp?.ownerId)){
                ownerIds.add(imp.ownerId);
                impsToProcess.add(imp);
            }
        }

        Map<Id, User> ownersMap = new Map<Id, User>([Select Id, ManagerId FROM User WHERE Id IN :ownerIds]);

        for(Implementation__c imp : impsToProcess){
            imp.IM_Rep_Manager__c = ownersMap.get(imp.ownerId).ManagerId;
        }
    }
}