package pw.tales.cofdsystem.action_attack.targets;

import pw.tales.cofdsystem.action_attack.events.HeartPiercedEvent;

@:expose("Heart")
class Heart implements ITarget
{
    public static final INSTANCE = new Heart();

    public function new() {}

    public function getDN():String
    {
        return "heart";
    }

    public function getAttackModifer():Int
    {
        return -3;
    }

    public function apply(action:AttackAction):Void
    {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        if (totalDamage >= 5)
        {
            var gameObject = action.getCompetition().getTarget();
            gameObject.getSystem().events.post(new HeartPiercedEvent(gameObject));
        }
    }
}
