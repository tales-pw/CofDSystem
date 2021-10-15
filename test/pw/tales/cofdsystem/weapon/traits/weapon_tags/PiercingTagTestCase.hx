package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.common.EnumSide;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.character.traits.WornArmor;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.armor.prefabs.ArmorPrefab;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.piercing.PiercingTagType;

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

    public function testApplyToGeneral()
    {
        this.setupGOArmor(c2, 3, 0);

        var action = new AttackBuilder(c1, c2).setModifier(EnumSide.ACTOR, 5).build();
        system.act(action);

        // Damage is 5L, effective armor is 1/0
        assertArrayEquals([0, 4, 0], action.getDamage().getTuple());
    }

    public function testApplyToBallistic()
    {
        this.setupGOArmor(c2, 0, 3);

        var action = new AttackBuilder(c1, c2).setModifier(EnumSide.ACTOR, 5).build();
        system.act(action);

        // Damage is 5L, effective armor is 0/1
        assertArrayEquals([1, 4, 0], action.getDamage().getTuple());
    }

    public function testApplyToBoth()
    {
        this.setupGOArmor(c2, 2, 2);

        var action = new AttackBuilder(c1, c2).setModifier(EnumSide.ACTOR, 5).build();
        system.act(action);

        // Damage is 5L, effective armor is 2/0
        assertArrayEquals([0, 3, 0], action.getDamage().getTuple());
    }
}
