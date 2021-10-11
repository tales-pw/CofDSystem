package pw.tales.cofdsystem.weapon.prefabs;

import pw.tales.cofdsystem.game_object.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.equipment.prefabs.EquipmentPrefab;
import pw.tales.cofdsystem.equipment.traits.HoldingHand;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.weapon.traits.DamageMod;
import pw.tales.cofdsystem.weapon.traits.InitiativeMod;
import pw.tales.cofdsystem.weapon.traits.LethalDamage;
import pw.tales.cofdsystem.weapon.Weapon;

class WeaponPrefab extends EquipmentPrefab implements IWeapon
{
    private var name:Null<String>;
    private var initiative:Int;
    private var damage:Int;
    private var size:Int;

    private var tags:Array<TraitType<Dynamic>>;

    public function new(dn:String, name:Null<String>, initiative:Int, damage:Int, size:Int, tags:Array<TraitType<Dynamic>>)
    {
        super(dn);
        this.name = name;
        this.initiative = initiative;
        this.damage = damage;
        this.size = size;
        this.tags = tags;
    }

    public function getName():Null<String>
    {
        return this.name;
    }

    public function getDisplayName():String
    {
        if (this.name != null)
            return this.name;
        return this.dn;
    }

    public function getInitiativeMod():Int
    {
        return this.initiative;
    }

    public function getDamageMod():Int
    {
        return this.damage;
    }

    public function getSize():Int
    {
        return this.size;
    }

    public function getWeaponTags():Array<TraitType<Dynamic>>
    {
        return this.tags;
    }

    private override function setUpGameObject(gameObject:GameObject):Void
    {
        super.setUpGameObject(gameObject);

        final manager = gameObject.getTraitManager();

        var initiativeMod = manager.addTrait(InitiativeMod.TYPE);
        initiativeMod.setValue(this.getInitiativeMod());

        var damageMod = manager.addTrait(DamageMod.TYPE);
        damageMod.setValue(this.getDamageMod());

        var size = manager.addTrait(SizeAdvantage.TYPE);
        size.setValue(this.size);

        manager.addTrait(LethalDamage.TYPE);
        manager.addTrait(HoldingHand.TYPE);

        for (tag in this.getWeaponTags())
        {
            manager.addTrait(tag);
        }
    }

    public function createWeapon(system:CofDSystem):Weapon
    {
        return new Weapon(this.createGameObject(system));
    }

    public function toString():String
    {
        var clazz = Type.getClass(this);
        return '${Utility.getClassName(clazz)}[dn=${dn},damageMod=${damage},iniativeMod=${initiative}]';
    }
}
