package pw.tales.system.action.modifications;

import pw.tales.system.action.events.OffhandModiferEvent;
import pw.tales.system.game_object.GameObject;

class Offhand implements IModification {
    public static final DN = "offhand";

    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
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

    public function before(action:IAction) {
        var opposition = action.getOpposition();
        var roll = opposition.getPool(this.gameObject);

        var modifer = Offhand.getModifier(gameObject);
        roll.getRequest().addModifier(modifer, Offhand.DN);
    }

    public function after(action:IAction) {

    }
}
