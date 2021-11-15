package pw.tales.cofdsystem.action.modifications;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.events.pool.ActionBuildResistEvent;
import pw.tales.cofdsystem.character.traits.advantages.willpower.WillpowerAdvantage;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

@:expose("Willpower")
class Willpower implements IModification
{
    private final gameObject:GameObject;

    public function new(gameObject:GameObject)
    {
        this.gameObject = gameObject;
    }

    public function init(action:IAction):Void
    {
        var eventBus = action.getEventBus();
        eventBus.addHandler(ActionBuildPoolEvent, this.applyRollBonus, HandlerPriority.NORMAL);
        eventBus.addHandler(ActionBuildResistEvent, this.applyResistBonus, HandlerPriority.NORMAL);
    }

    private function applyRollBonus(event:ActionBuildPoolEvent):Void
    {
        if (!event.isPoolOwner(this.gameObject))
            return;

        this.burnWillpower();

        var pool = event.getActionPool();
        var request = pool.getRequest();
        request.addModifier(3, WillpowerAdvantage.DN);
    }

    private function applyResistBonus(event:ActionBuildResistEvent):Void
    {
        if (!event.isPoolOwner(this.gameObject))
            return;

        this.burnWillpower();

        var pool = event.getActionPool();
        var request = pool.getRequest();
        request.addModifier(2, WillpowerAdvantage.DN);
    }

    private function burnWillpower():Void
    {
        var willpower = this.gameObject.getTrait(WillpowerAdvantage.TYPE);
        willpower.burnWillpower();
    }
}
