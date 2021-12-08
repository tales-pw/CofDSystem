package pw.tales.cofdsystem.character.traits;

import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.scene.initiative.events.InitiativeModifiersEvent;
import pw.tales.cofdsystem.utils.events.HandlerPriority;
import pw.tales.cofdsystem.weapon.Weapon;

@RegisterTraitTypes
@:expose("HeldWeapon")
class HeldWeapon extends Trait
{
    public static final DN = "weapon";
    public static final TYPE = TraitType.createType(DN, HeldWeapon.new);

    private var mainHand:Null<Weapon> = null;
    private var offHand:Null<Weapon> = null;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);
        this.eventBus.addHandler(
            InitiativeModifiersEvent,
            this.applyInitiativeMod,
            HandlerPriority.NORMAL
        );
    }

    public function getHand(hand:EnumHand):Null<Weapon>
    {
        if (hand == EnumHand.HAND)
            return this.getMainHand();
        if (hand == EnumHand.OFFHAND)
            return this.getOffHand();
        return null;
    }

    public function setHand(hand:EnumHand, newWeapon:Null<Weapon>):Void
    {
        var oldWeapon = this.getHand(hand);
        if (oldWeapon != null)
            oldWeapon.unsetEquipper();

        switch (hand)
        {
            case EnumHand.HAND:
                this.mainHand = newWeapon;
            case EnumHand.OFFHAND:
                this.offHand = newWeapon;
        }

        if (newWeapon != null)
            newWeapon.setEquipper(this.gameObject, hand);
    }

    public function getMainHand():Null<Weapon>
    {
        return this.mainHand;
    }

    public function getOffHand():Null<Weapon>
    {
        return this.offHand;
    }

    public function setMainHand(mainHand:Null<Weapon>):Void
    {
        this.setHand(EnumHand.HAND, mainHand);
    }

    public function setOffHand(offHand:Null<Weapon>):Void
    {
        this.setHand(EnumHand.OFFHAND, offHand);
    }

    public function calculateWeaponsInitiativeMod(gameObject:GameObject):Int
    {
        var mainWeaponMod = this.mainHand != null ? this.mainHand.getInitiativeMod() : null;
        var offWeaponMod = this.offHand != null ? this.offHand.getInitiativeMod() : null;

        if (mainWeaponMod != null && offWeaponMod != null)
        {
            return Std.int(Math.min(mainWeaponMod, offWeaponMod)) - 1;
        }

        if (mainWeaponMod != null)
            return mainWeaponMod;

        if (offWeaponMod != null)
            return offWeaponMod;

        return 0;
    }

    private function applyInitiativeMod(event:InitiativeModifiersEvent):Void
    {
        var finalMod = this.calculateWeaponsInitiativeMod(this.gameObject);
        event.apply(finalMod);
    }
}
