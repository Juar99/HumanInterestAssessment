public without sharing class UserToImplementationUpdate {
    public static void updateManager(Map<Id, User> newUserMap, Map<Id, User> oldUserMap){
        Set<Id> userIds = new Set<Id>();
        for(User user : newUserMap.values()){
            User oldUser = oldUserMap.containsKey(user.Id) ? oldUserMap.get(user.Id) : null;
            if(user.ManagerId != oldUser?.ManagerId){
                userIds.add(user.Id);
            }
        }

        List<Implementation__c> impsToUpdate = [Select Id, IM_Rep_Manager__c, OwnerId
                                                FROM Implementation__c 
                                                WHERE Stage__c != 'Complete' AND OwnerId IN :userIds];
        if(impsToUpdate.isEmpty()){
            return;
        }

        for(Implementation__c imp : impsToUpdate){
            imp.IM_Rep_Manager__c = newUserMap.get(imp.OwnerId).ManagerId;
        }

        update impsToUpdate;
    }
}