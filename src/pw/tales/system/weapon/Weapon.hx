package pw.tales.system.weapon;

import pw.tales.system.common.EnumHand;
import pw.tales.system.equipment.traits.Equippable;
import pw.tales.system.equipment.traits.HoldingHand;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.TraitManager;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.events.HandlerPriority;
import pw.tales.system.weapon.traits.DamageMod;
import pw.tales.system.weapon.traits.InitiativeMod;
import pw.tales.system.weapon.traits.weapon_tags.WeaponTags;

class Weapon implements IWeapon {
    public static final ATTACK_POOL_PRIORITY = HandlerPriority.NORMAL;

    private final gameObject:GameObject;
    private final traitManager:TraitManager;
    private final equippable:Equippable;
    private final holdingHand:HoldingHand;
    private final initiativeMod:InitiativeMod;
    private final damageMod:DamageMod;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
        this.traitManager = gameObject.getTraitManager();
        this.equippable = cast(traitManager.getTrait(Equippable.TYPE));
        this.holdingHand = cast(traitManager.getTrait(HoldingHand.TYPE));
        this.initiativeMod = cast(this.traitManager.getTrait(InitiativeMod.TYPE));
        this.damageMod = cast(this.traitManager.getTrait(DamageMod.TYPE));
    }

    public function getInitiativeMod():Int {
        return initiativeMod.getValue();
    }

    public function getDamageMod():Int {
        return damageMod.getValue();
    }

    public function getWeaponTags():Array<TraitType<Dynamic>> {
        return WeaponTags.collect(this.gameObject).map((tag) -> tag.getType());
    }

    public function getEquipper():Null<GameObject> {
        return this.equippable.getHolder();
    }

    public function getHand():Null<EnumHand> {
        return this.holdingHand.getHand();
    }

    public function unsetEquipper() {
        this.equippable.unset();
        this.holdingHand.unset();
    }

    public function setEquipper(gameObject:GameObject, hand:EnumHand) {
        this.equippable.setHolder(gameObject);
        this.holdingHand.setHand(hand);
    }

    public function getGameObject():GameObject {
        return this.gameObject;
    }
}
