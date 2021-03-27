package pw.tales.system.action;

import pw.tales.system.action.events.ActionPerformedEvent;
import pw.tales.system.action.events.IActionEvent;
import pw.tales.system.action.opposition.base.Opposition;
import pw.tales.system.utils.events.IEvent;
import pw.tales.system.utils.events.IEventBus;
import pw.tales.system.utils.events.SubEventBus;
import pw.tales.system.utils.Utility;

class Action implements IAction {
    private final system:CofDSystem;
    private final opposition:Opposition;
    private final time:EnumTime;

    private final eventBus:SubEventBus;
    private var modifications:Array<IModification> = [];

    private function new(opposition:Opposition, time:EnumTime, system:CofDSystem) {
        this.opposition = opposition;
        this.time = time;
        this.system = system;

        this.eventBus = new SubEventBus(system.events, (event:IEvent) -> {
            var actionEvent:Null<IActionEvent> = Utility.downcast(event, IActionEvent);
            if (actionEvent == null) return false;
            return actionEvent.isRelatedAction(this);
        });
    }

    public function getSystem():CofDSystem {
        return this.system;
    }

    public function getEventBus():IEventBus {
        return this.eventBus;
    }

    public function addModification(modification:IModification) {
        this.modifications.push(modification);
        modification.init(this);
    }

    public function getModifications():Array<IModification> {
        return this.modifications;
    }

    public function getOpposition():Opposition {
        return this.opposition;
    }

    public function getActionTime():EnumTime {
        return this.time;
    }

    private function beforeAction() {

    }

    private function perform() {

    }

    private function roll() {
        this.opposition.roll(this);
    }

    private function afterAction() {
        this.eventBus.post(new ActionPerformedEvent(this));
        this.eventBus.disable();
    }

    public final function execute():Void {
        this.beforeAction();
        this.roll();
        this.perform();
        this.afterAction();
    }
}
