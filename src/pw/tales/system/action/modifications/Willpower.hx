package pw.tales.system.action.modifications;

import pw.tales.system.character.traits.advantages.willpower.WillpowerAdvantage;
import pw.tales.system.game_object.GameObject;

class Willpower implements IModification {
    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function before(action:IAction) {
        var opposition = action.getOpposition();
        var roll = opposition.getPool(this.gameObject);
        var request = roll.getRequest();

        var willpower:WillpowerAdvantage = cast(gameObject.getTraitManager().getTrait(WillpowerAdvantage.TYPE));
        willpower.burnWillpower();

        if (opposition.willRoll(roll)) {
            request.addModifier(3, WillpowerAdvantage.DN);
        } else {
            request.addModifier(2, WillpowerAdvantage.DN);
        }
    }

    public function after(action:IAction) {

    }
}
