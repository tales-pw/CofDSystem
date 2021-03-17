package pw.tales.system.action_attack.modifications;

import pw.tales.system.action.IAction;
import pw.tales.system.action.IModification;
import pw.tales.system.character.traits.advantages.DefenceAdvantage;
import pw.tales.system.game_object.GameObject;

class AllOutAttack implements IModification {
    public static final DN = "all_out";
    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function before(action:IAction):Void {
        var opposition = action.getOpposition();
        var roll = opposition.getActorPool();
        roll.getRequest().addModifier(2, DN);

        var manager = gameObject.getTraitManager();
        var defence:DefenceAdvantage = cast manager.getTrait(DefenceAdvantage.TYPE);
        defence.loseDefence();
    }

    public function after(action:IAction) {

    }
}
