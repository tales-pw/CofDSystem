package pw.tales.system.weapon;

import pw.tales.system.common.EnumHand;
import pw.tales.system.equipment.Equipment;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.events.HandlerPriority;
import pw.tales.system.weapon.traits.DamageMod;
import pw.tales.system.weapon.traits.InitiativeMod;
import pw.tales.system.weapon.traits.weapon_tags.WeaponTags;

class Weapon extends Equipment implements IWeapon {
    public static final ATTACK_POOL_PRIORITY = HandlerPriority.NORMAL;

    public function new(gameObject:GameObject) {
        super(gameObject);
    }

    public function getInitiativeMod():Int {
        return this.getInt(InitiativeMod.TYPE);
    }

    public function getDamageMod():Int {
        return this.getInt(DamageMod.TYPE);
    }

    public function getWeaponTags():Array<TraitType<Dynamic>> {
        return WeaponTags.collect(this.gameObject).map((tag) -> tag.getType());
    }

    public function getEquipper():Null<GameObject> {
        return this.ensureEquipable().getHolder();
    }

    public function getHand():Null<EnumHand> {
        return this.ensureHoldingHand().getHand();
    }

    public function unsetEquipper() {
        this.ensureEquipable().unset();
        this.ensureHoldingHand().unset();
    }

    public function setEquipper(gameObject:GameObject, hand:EnumHand) {
        this.ensureEquipable().setHolder(gameObject);
        this.ensureHoldingHand().setHand(hand);
    }

    public function getGameObject():GameObject {
        return this.gameObject;
    }
}
