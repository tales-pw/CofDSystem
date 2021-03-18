package pw.tales.system.action.modifications;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action.events.pool.ActionBuildResistEvent;
import pw.tales.system.character.traits.advantages.willpower.WillpowerAdvantage;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.events.HandlerPriority;

class Willpower implements IModification {
    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function init(action:IAction) {
        var eventBus = action.getEventBus();
        eventBus.addHandler(ActionBuildPoolEvent, this.applyRollBonus, HandlerPriority.NORMAL);
        eventBus.addHandler(ActionBuildResistEvent, this.applyResistBonus, HandlerPriority.NORMAL);
    }

    private function applyRollBonus(event:ActionBuildPoolEvent) {
        if (!event.isPoolOwner(this.gameObject)) return;

        this.burnWillpower();

        var pool = event.getActionPool();
        var request = pool.getRequest();
        request.addModifier(3, WillpowerAdvantage.DN);
    }

    private function applyResistBonus(event:ActionBuildResistEvent) {
        if (!event.isPoolOwner(this.gameObject)) return;

        this.burnWillpower();

        var pool = event.getActionPool();
        var request = pool.getRequest();
        request.addModifier(2, WillpowerAdvantage.DN);
    }

    private function burnWillpower() {
        var manager = gameObject.getTraitManager();
        var willpower:WillpowerAdvantage = cast manager.getTrait(WillpowerAdvantage.TYPE);
        willpower.burnWillpower();
    }
}
