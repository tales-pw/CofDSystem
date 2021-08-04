package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class HoldingHand extends Trait
{
    public static final DN = "holding_hand";
    public static final TYPE:TraitType<HoldingHand> = cast TraitType.createType(DN, create);

    private var hand:Null<EnumHand>;

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
    }

    public function setHand(hand:EnumHand)
    {
        this.hand = hand;
        this.notifyUpdated();
    }

    public function getHand():Null<EnumHand>
    {
        return this.hand;
    }

    public function unset()
    {
        this.hand = null;
        this.notifyUpdated();
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<HoldingHand>):HoldingHand
    {
        return new HoldingHand(gameObject);
    }
}
