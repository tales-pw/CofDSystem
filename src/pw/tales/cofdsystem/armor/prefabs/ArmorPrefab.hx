package pw.tales.cofdsystem.armor.prefabs;

import pw.tales.cofdsystem.equipment.traits.StrengthReq;
import pw.tales.cofdsystem.armor.traits.armor_rating.ArmorRating;
import pw.tales.cofdsystem.armor.traits.DefenceModifer;
import pw.tales.cofdsystem.armor.traits.SpeedModifer;
import pw.tales.cofdsystem.equipment.prefabs.EquipmentPrefab;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.Utility;

class ArmorPrefab extends EquipmentPrefab implements IArmor
{
    private var name:Null<String>;

    private var ballistic:Int;
    private var general:Int;

    private var defenceMod:Int;
    private var speedMod:Int;
    private var strengthReq:Int;

    public function new(dn:String, name:Null<String>, general:Int, ballistic:Int, defenceMod:Int, speedMod:Int, strengthReq:Int)
    {
        super(dn);
        this.name = name;

        this.general = general;
        this.ballistic = ballistic;

        this.defenceMod = defenceMod;
        this.speedMod = speedMod;
        this.strengthReq = strengthReq;
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

    public function getBallistic():Int
    {
        return this.ballistic;
    }

    public function getGeneral():Int
    {
        return this.general;
    }

    public function getStrengthReq():Int
    {
        return this.strengthReq;
    }

    public function getDefenceMod():Int
    {
        return this.defenceMod;
    }

    public function getSpeedMod():Int
    {
        return this.speedMod;
    }

    public function toString(): String
    {
        var clazz = Type.getClass(this);
        return '${Utility.getClassName(clazz)}[dn=$dn,general=$general, ballistic=$ballistic]';
    }

    private override function setUpGameObject(armorGameObject:GameObject): Void
    {
        super.setUpGameObject(armorGameObject);

        var manager = armorGameObject.getTraitManager();

        var armorRating:ArmorRating = manager.addTrait(ArmorRating.TYPE);
        armorRating.setGeneral(this.getGeneral());
        armorRating.setBallistic(this.getBallistic());

        var defenceMod:DefenceModifer = manager.addTrait(DefenceModifer.TYPE);
        defenceMod.setValue(this.getDefenceMod());

        var speedMod:SpeedModifer = manager.addTrait(SpeedModifer.TYPE);
        speedMod.setValue(this.getSpeedMod());

        var strengthReq:StrengthReq = manager.addTrait(StrengthReq.TYPE);
        strengthReq.setValue(this.getStrengthReq());
    }

    public function createArmor(system:CofDSystem):Armor
    {
        return new Armor(this.createGameObject(system));
    }
}
