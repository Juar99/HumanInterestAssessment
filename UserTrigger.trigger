trigger UserTrigger on User (before delete, before insert, before update, after delete, after insert, after update) {
    new UserTriggerHandler().run();
}