package pw.tales.system.action.modifications;

import pw.tales.system.action.events.OffhandModiferEvent;
import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.events.HandlerPriority;

class Offhand implements IModification {
    public static final DN = "offhand";

    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function init(action:IAction) {
        var eventBus = action.getEventBus();
        eventBus.addHandler(ActionBuildPoolEvent, this.applyRollModifier, HandlerPriority.NORMAL);
    }

    private function applyRollModifier(event:ActionBuildPoolEvent) {
        if (!event.isPoolOwner(this.gameObject)) return;

        var pool = event.getActionPool();
        var modifer = Offhand.getModifier(gameObject);
        pool.getRequest().addModifier(modifer, Offhand.DN);
    }

    public function getGameObject():GameObject {
        return this.gameObject;
    }

    public static function getModifier(gameObject:GameObject):Int {
        var system = gameObject.getSystem();
        var modfierEvent = new OffhandModiferEvent(gameObject);
        system.events.post(modfierEvent);
        return modfierEvent.getModifer();
    }
}
