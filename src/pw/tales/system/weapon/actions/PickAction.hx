package pw.tales.system.weapon.actions;

import pw.tales.system.action.EnumTime;
import pw.tales.system.action.NoRollAction;
import pw.tales.system.character.traits.HeldWeapon;
import pw.tales.system.common.EnumHand;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.weapon.Weapon;

class PickAction extends NoRollAction {
    private final weapon:Null<Weapon>;
    private final hand:EnumHand;

    public function new(actor:GameObject, hand:EnumHand, weapon:Null<Weapon>, system:CofDSystem) {
        super(actor, EnumTime.INSTANT, system);
        this.weapon = weapon;
        this.hand = hand;
    }

    override public function execute():Void {
        var trait:HeldWeapon = cast(actor.getTraitManager().getTrait(HeldWeapon.TYPE));
        trait.setHand(this.hand, this.weapon);
    }
}
