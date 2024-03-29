package pw.tales.cofdsystem.action_attack.targets;

import pw.tales.cofdsystem.character.traits.attribute.Attribute;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.tilts.LegWrackTilt;

@:expose("Leg")
class Leg implements ITarget
{
    public static final INSTANCE = new Leg();

    public function new() {}

    public function getDN():String
    {
        return "leg";
    }

    public function getAttackModifer():Int
    {
        return -2;
    }

    public function apply(action:AttackAction):Void
    {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        var gameObject = action.getCompetition().getTarget();
        var stamina:Attribute = gameObject.getTrait(Attributes.STAMINA);

        if (totalDamage > stamina.getValue())
        {
            gameObject.getTraitManager().addTrait(LegWrackTilt.TYPE);
        }
    }
}
