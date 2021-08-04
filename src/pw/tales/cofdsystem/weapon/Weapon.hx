package pw.tales.cofdsystem.weapon;

import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.equipment.Equipment;
import pw.tales.cofdsystem.equipment.traits.HoldingHand;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.events.HandlerPriority;
import pw.tales.cofdsystem.weapon.traits.DamageMod;
import pw.tales.cofdsystem.weapon.traits.InitiativeMod;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.WeaponTags;

class Weapon extends Equipment implements IWeapon
{
    public static final ATTACK_POOL_PRIORITY = HandlerPriority.NORMAL;

    public function new(gameObject:GameObject)
    {
        super(gameObject);
    }

    public function getInitiativeMod():Int
    {
        return this.getInt(InitiativeMod.TYPE);
    }

    public function getDamageMod():Int
    {
        return this.getInt(DamageMod.TYPE);
    }

    public function getWeaponTags():Array<TraitType<Dynamic>>
    {
        return WeaponTags.collect(this.gameObject).map((tag) -> tag.getType());
    }

    public function getHand():Null<EnumHand>
    {
        try
        {
            return this.ensureHoldingHand().getHand();
        } catch (NoTraitAccessorException)
        {
            return null;
        }
    }

    public function unsetEquipper()
    {
        super.unsetHolder();

        try
        {
            this.ensureHoldingHand().unset();
        } catch (NoTraitAccessorException) {}
    }

    public function setEquipper(gameObject:GameObject, hand:EnumHand)
    {
        super.setHolder(gameObject);

        try
        {
            this.ensureHoldingHand().setHand(hand);
        } catch (NoTraitAccessorException) {}
    }

    private function ensureHoldingHand():HoldingHand
    {
        return this.getTrait(HoldingHand.TYPE);
    }
}
