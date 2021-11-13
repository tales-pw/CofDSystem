package pw.tales.cofdsystem.weapon.actions;

import pw.tales.cofdsystem.action.EnumTime;
import pw.tales.cofdsystem.action.NoRollAction;
import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.weapon.Weapon;

@:expose("PickAction")
class PickAction extends NoRollAction
{
    private final weapon:Null<Weapon>;
    private final hand:EnumHand;

    public function new(actor:GameObject, hand:EnumHand, weapon:Null<Weapon>, system:CofDSystem)
    {
        super(actor, EnumTime.INSTANT, system);
        this.weapon = weapon;
        this.hand = hand;
    }

    override public function perform():Void
    {
        var trait = actor.getTrait(HeldWeapon.TYPE);
        trait.setHand(this.hand, this.weapon);
    }
}
