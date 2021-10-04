package pw.tales.cofdsystem.action;

import pw.tales.cofdsystem.action.events.ActionPerformedEvent;
import pw.tales.cofdsystem.action.events.IActionEvent;
import pw.tales.cofdsystem.utils.events.IEvent;
import pw.tales.cofdsystem.utils.events.IEventBus;
import pw.tales.cofdsystem.utils.events.SubEventBus;
import pw.tales.cofdsystem.utils.Utility;

class Action implements IAction
{
    private final system:CofDSystem;
    private final time:EnumTime;

    private final eventBus:SubEventBus;
    private var modifications:Array<IModification> = [];

    private function new(time:EnumTime, system:CofDSystem)
    {
        this.time = time;
        this.system = system;

        this.eventBus = new SubEventBus(system.events, (event:IEvent) ->
        {
            var actionEvent:Null<IActionEvent> = Utility.downcast(event, IActionEvent);

            if (actionEvent == null)
                return false;

            return actionEvent.isRelatedAction(this);
        });
    }

    public function getSystem():CofDSystem
    {
        return this.system;
    }

    public function getEventBus():IEventBus
    {
        return this.eventBus;
    }

    public function addModification(modification:IModification):Void
    {
        this.modifications.push(modification);
        modification.init(this);
    }

    public function getModifications():Array<IModification>
    {
        return this.modifications;
    }

    public function getActionTime():EnumTime
    {
        return this.time;
    }

    private function beforeAction():Void {}

    private function perform():Void {}

    private function afterAction():Void
    {
        this.eventBus.post(new ActionPerformedEvent(this));
        this.eventBus.disable();
    }

    public function execute():Void
    {
        this.beforeAction();
        this.perform();
        this.afterAction();
    }
}
