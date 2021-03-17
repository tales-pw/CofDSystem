package pw.tales.system.character.traits;

import pw.tales.system.common.EnumHand;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.scene.initiative.events.InitiativeModifiersEvent;
import pw.tales.system.utils.events.HandlerPriority;
import pw.tales.system.weapon.Weapon;

@:keep
@:expose("HeldWeapon")
class HeldWeapon extends Trait {
    public static final DN = "weapon";
    public static final TYPE:TraitType<HeldWeapon> = cast TraitType.createType(DN, create);

    private var mainHand:Null<Weapon> = null;
    private var offHand:Null<Weapon> = null;

    public function new(gameObject:GameObject) {
        super(TYPE.getDN(), gameObject, TYPE);
        this.eventBus.addHandler(InitiativeModifiersEvent, this.applyInitiativeMod, HandlerPriority.NORMAL);
    }

    public function getHand(hand:EnumHand):Null<Weapon> {
        if (hand == EnumHand.HAND) return this.getMainHand();
        if (hand == EnumHand.OFFHAND) return this.getOffHand();
        return null;
    }

    public function setHand(hand:EnumHand, newWeapon:Null<Weapon>):Void {
        var oldWeapon = this.getHand(hand);
        if (oldWeapon != null) oldWeapon.unsetEquipper();

        switch (hand) {
            case EnumHand.HAND: this.mainHand = newWeapon;
            case EnumHand.OFFHAND: this.offHand = newWeapon;
        }

        if (newWeapon != null) newWeapon.setEquipper(this.gameObject, hand);
    }

    public function getMainHand():Null<Weapon> {
        return this.mainHand;
    }

    public function getOffHand():Null<Weapon> {
        return this.offHand;
    }

    public function setMainHand(mainHand:Null<Weapon>) {
        this.setHand(EnumHand.HAND, mainHand);
    }

    public function setOffHand(offHand:Null<Weapon>) {
        this.setHand(EnumHand.OFFHAND, offHand);
    }

    public function calculateWeaponsInitiativeMod(gameObject:GameObject):Int {
        var mainWeaponMod = this.mainHand != null ? this.mainHand.getInitiativeMod() : null;
        var offWeaponMod = this.offHand != null ? this.offHand.getInitiativeMod() : null;

        if (mainWeaponMod != null && offWeaponMod != null) {
            return Std.int(Math.min(mainWeaponMod, offWeaponMod)) - 1;
        }

        if (mainWeaponMod != null)
            return mainWeaponMod;

        if (offWeaponMod != null)
            return offWeaponMod;

        return 0;
    }

    private function applyInitiativeMod(event:InitiativeModifiersEvent) {
        var finalMod = this.calculateWeaponsInitiativeMod(this.gameObject);
        event.apply(finalMod);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<HeldWeapon>):HeldWeapon {
        return new HeldWeapon(gameObject);
    }
}
