package pw.tales.cofdsystem.action_attack.modifications;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.IAction;
import pw.tales.cofdsystem.action.IModification;
import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

class AllOutAttack implements IModification {
    public static final DN = "all_out";
    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function init(action:IAction) {
        var eventBus = action.getEventBus();
        eventBus.addHandler(ActionBuildPoolEvent, this.applyRollBonus, HandlerPriority.NORMAL);
    }

    public function applyRollBonus(event:ActionBuildPoolEvent):Void {
        var pool = event.getActionPool();
        pool.getRequest().addModifier(2, DN);

        // Lose defence
        var manager = gameObject.getTraitManager();
        var defence:DefenceAdvantage = cast manager.getTrait(DefenceAdvantage.TYPE);
        defence.loseDefence();
    }
}
