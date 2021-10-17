package pw.tales.cofdsystem.armor.prefabs;

import pw.tales.cofdsystem.equipment.traits.StrengthReq;
import pw.tales.cofdsystem.armor.traits.armor_rating.ArmorRating;
import pw.tales.cofdsystem.armor.traits.DefenceModifer;
import pw.tales.cofdsystem.armor.traits.SpeedModifer;
import pw.tales.cofdsystem.equipment.prefabs.EquipmentPrefab;
import pw.tales.cofdsystem.game_object.GameObject;

@:structInit class ArmorPrefab extends EquipmentPrefab implements IArmor
{
    private final name:Null<String> = null;

    private final ballistic:Int = 0;
    private final general:Int = 0;

    private final defenceMod:Int = 0;
    private final speedMod:Int = 0;
    private final strengthReq:Int = 0;

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

    private override function setUpGameObject(armorGameObject:GameObject):Void
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
