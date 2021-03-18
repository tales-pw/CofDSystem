package pw.tales.system.action_attack.modifications;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action.IAction;
import pw.tales.system.action.IModification;
import pw.tales.system.character.traits.advantages.DefenceAdvantage;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.events.HandlerPriority;

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
