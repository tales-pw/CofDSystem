package pw.tales.cofdsystem.action.modifications;

import pw.tales.cofdsystem.action.events.ActionGetHandEvent;
import pw.tales.cofdsystem.action.events.OffhandModiferEvent;
import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

class Offhand implements IModification {
    public static final DN = "offhand";

    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function init(action:IAction) {
        var eventBus = action.getEventBus();
        eventBus.addHandler(ActionBuildPoolEvent, this.applyRollModifier, HandlerPriority.NORMAL);
        eventBus.addHandler(ActionGetHandEvent, this.onHandEvent, HandlerPriority.NORMAL);
    }

    private function onHandEvent(event:ActionGetHandEvent) {
        if (event.getGameObject() == this.gameObject) {
            event.setHand(EnumHand.OFFHAND);
        }
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
