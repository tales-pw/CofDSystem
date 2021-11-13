package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@:expose("HoldingHand")
class HoldingHand extends Trait
{
    public static final DN = "holding_hand";
    public static final TYPE = TraitType.createType(DN, HoldingHand.new);

    private var hand:Null<EnumHand>;

    public function setHand(hand:EnumHand):Void
    {
        this.hand = hand;
        this.notifyUpdated();
    }

    public function getHand():Null<EnumHand>
    {
        return this.hand;
    }

    public function unset():Void
    {
        this.hand = null;
        this.notifyUpdated();
    }
}
