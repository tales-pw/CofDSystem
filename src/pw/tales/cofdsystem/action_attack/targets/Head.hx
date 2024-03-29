package pw.tales.cofdsystem.action_attack.targets;

import pw.tales.cofdsystem.game_object.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.character.traits.tilts.StunnedTilt;

@:expose("Head")
class Head implements ITarget
{
    public static final INSTANCE = new Head();

    public function new() {}

    public function getDN():String
    {
        return "head";
    }

    public function getAttackModifer():Int
    {
        return -3;
    }

    public function apply(action:AttackAction):Void
    {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        var gameObject = action.getCompetition().getTarget();
        var size = gameObject.getTrait(SizeAdvantage.TYPE);

        if (totalDamage >= size.getValue() - 1)
        {
            gameObject.getTraitManager().addTrait(StunnedTilt.TYPE);
        }
    }
}
