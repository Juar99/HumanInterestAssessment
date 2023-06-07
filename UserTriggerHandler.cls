public without sharing class UserTriggerHandler extends TriggerHandler {

    private Map<Id, User> newUserMap;
    private Map<Id, User> oldUserMap;
  
    public UserTriggerHandler() {
      this.newUserMap = (Map<Id, User>) Trigger.newMap;
      this.oldUserMap = (Map<Id, User>) Trigger.oldMap;
    }
    
    public override void afterUpdate() {
        if(TriggerUtils.isValidRun('updateManager')){
            UserToImplementationUpdate.updateManager(this.newUserMap, this.oldUserMap);
        }
    }
}