package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.game_object.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.character.traits.HeldWeapon;
import haxe.exceptions.NotImplementedException;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import haxe.unit.TestCase;

class WeaponTagTestCase extends CofDSystemTestCase
{
    @:nullSafety(Off)
    private var weapon:Weapon;

    override public function setup()
    {
        super.setup();

        this.weapon = this.createWeapon();

        var trait = this.c1.getTrait(HeldWeapon.TYPE);
        trait.setHand(EnumHand.HAND, weapon);
    }

    private function createWeapon():Weapon
    {
        var prefab = this.createPrefab();
        var weapon = prefab.createWeapon(this.system);
        return weapon;
    }

    private function createPrefab()
    {
        return new WeaponPrefab("weapon", null, 0, 0, 0, [this.getTagType()]);
    }

    private function assertBonus(action:AttackAction, gameObject:GameObject, value:Null<Int>):Void
    {
        var pool = action.getCompetition().getPool(gameObject);
        var request = pool.getRequest();
        var modifiers = request.getAppliedModifiers();
        assertEquals(value, modifiers[this.getTagType().getDN()]);
    }

    private function getTagType():TraitType<Dynamic>
    {
        throw new NotImplementedException();
    }

    public override function getBaseTest():Class<TestCase>
    {
        return WeaponTagTestCase;
    }
}
