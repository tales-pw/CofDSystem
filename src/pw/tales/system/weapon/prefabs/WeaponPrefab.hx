package pw.tales.system.weapon.prefabs;

import pw.tales.system.equipment.prefabs.EquipmentPrefab;
import pw.tales.system.equipment.traits.HoldingHand;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.Utility;
import pw.tales.system.weapon.traits.DamageMod;
import pw.tales.system.weapon.traits.InitiativeMod;
import pw.tales.system.weapon.traits.LethalDamage;
import pw.tales.system.weapon.Weapon;

class WeaponPrefab extends EquipmentPrefab implements IWeapon {
    private var name:Null<String>;
    private var initiative:Int;
    private var damage:Int;

    private var tags:Array<TraitType<Dynamic>>;

    public function new(dn:String, name:Null<String>, initiative:Int, damage:Int, tags:Array<TraitType<Dynamic>>) {
        super(dn);
        this.name = name;
        this.initiative = initiative;
        this.damage = damage;
        this.tags = tags;
    }

    public function getName():Null<String> {
        return this.name;
    }

    public function getDisplayName():String {
        if (this.name != null) return this.name;
        return this.dn;
    }

    public function getInitiativeMod():Int {
        return this.initiative;
    }

    public function getDamageMod():Int {
        return this.damage;
    }

    public function getWeaponTags():Array<TraitType<Dynamic>> {
        return this.tags;
    }

    private override function setUpGameObject(weaponGameObject:GameObject) {
        super.setUpGameObject(weaponGameObject);

        final manager = weaponGameObject.getTraitManager();

        var initiativeMod:InitiativeMod = manager.addTrait(InitiativeMod.TYPE);
        initiativeMod.setValue(this.getInitiativeMod());

        var damageMod:DamageMod = manager.addTrait(DamageMod.TYPE);
        damageMod.setValue(this.getDamageMod());

        manager.addTrait(LethalDamage.TYPE);
        manager.addTrait(HoldingHand.TYPE);

        for (tag in this.getWeaponTags()) {
            manager.addTrait(tag);
        }
    }

    public function createWeapon(system:CofDSystem):Weapon {
        return new Weapon(this.createGameObject(system));
    }

    public function toString():String {
        var clazz = Type.getClass(this);
        return '${Utility.getClassName(clazz)}[dn=${dn},damageMod=${damage},iniativeMod=${initiative}]';
    }
}
