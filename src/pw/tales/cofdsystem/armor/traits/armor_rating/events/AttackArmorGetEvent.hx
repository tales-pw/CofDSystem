package pw.tales.cofdsystem.armor.traits.armor_rating.events;

import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.action_attack.events.AttackEvent;

@:expose("AttackArmorGetEvent")
class AttackArmorGetEvent extends AttackEvent
{
    private var general:Int;
    private var ballistic:Int;

    public function new(action:AttackAction, general:Int, ballistic:Int)
    {
        super(action);
        this.general = general;
        this.ballistic = ballistic;
    }

    public function getGeneral():Int
    {
        return this.general;
    }

    public function getBallistic():Int
    {
        return this.ballistic;
    }

    public function setGeneral(general:Int):Void
    {
        this.general = general;
    }

    public function setBallistic(ballistic:Int):Void
    {
        this.ballistic = ballistic;
    }
}
