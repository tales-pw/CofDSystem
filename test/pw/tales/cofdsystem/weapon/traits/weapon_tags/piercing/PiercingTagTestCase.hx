package pw.tales.cofdsystem.weapon.traits.weapon_tags.piercing;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.WornArmor;
import pw.tales.cofdsystem.armor.prefabs.ArmorPrefab;
import haxe.unit.TestCase;

class PiercingTagTestCase extends WeaponTagTestCase
{
    private static final TYPE = new PiercingTagType(2);

    private override function getTagType():TraitType<Dynamic>
    {
        return TYPE;
    }

    public function setupGOArmor(gameObject:GameObject, general:Int, ballistic:Int):Void
    {
        var armorPrefab = new ArmorPrefab("armor", null, general, ballistic, 0, 0, 0);
        var armor = armorPrefab.createArmor(this.system);
        gameObject.getTrait(WornArmor.TYPE).setArmor(armor);
    }

    public override function getBaseTest():Class<TestCase>
    {
        return PiercingTagTestCase;
    }
}
