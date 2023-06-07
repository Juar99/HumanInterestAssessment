public without sharing class TriggerUtils {
    
    private static Map<String, TriggerTracker> triggerTrackerMap = initializeSettingsMap();
    
    public static Boolean isValidRun(String methodName){
        TriggerTracker tracker = triggerTrackerMap.containsKey(methodName) ? triggerTrackerMap.get(methodName) : null;
        if(tracker == null){
            System.debug(methodName + ' was allowed to run since no metadata record existed');
            return true;
        }

        if(tracker.runCount < tracker.setting.Max_Run_Count__c && tracker.setting.Active__c){
            tracker.runCount++;
            System.debug(methodName + ' will run and has now run ' + tracker.runCount + ' times of it\'s limit of ' + tracker.setting.Max_Run_Count__c  + ' and is ' + (tracker.setting.Active__c ? 'Active' : 'Inactive'));
            return true;
        }
        
        System.debug(methodName + ' will NOT run. It has run ' + tracker.runCount + ' times of it\'s limit of ' + tracker.setting.Max_Run_Count__c + ' and is ' + (tracker.setting.Active__c ? 'Active' : 'Inactive'));
        return false;
    }

    private static Map<String, TriggerTracker> initializeSettingsMap(){
        Map<String, TriggerTracker> TriggerTrackerMap = new Map<String, TriggerTracker>();
        
        List<Trigger_Setting__mdt> triggerSettings = [Select Id, Label, Active__c, Max_Run_Count__c FROM Trigger_Setting__mdt];
        for(Trigger_Setting__mdt setting : triggerSettings){
            TriggerTrackerMap.put(setting.Label, new TriggerTracker(setting));
        }

        return TriggerTrackerMap;
    }

    private class TriggerTracker{
        Trigger_Setting__mdt setting;
        Integer runCount;

        TriggerTracker(Trigger_Setting__mdt setting){
            this.setting = setting;
            runCount = 0;
        }
    }
}