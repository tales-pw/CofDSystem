package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.weapon_melee.prefabs.MeleeWeaponPrefab;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.character.traits.HeldWeapon;
import haxe.exceptions.NotImplementedException;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import haxe.unit.TestCase;

class WeaponTagTestCase extends CofDSystemTestCase
{
    private static final NO_TAG_WEAPON = new MeleeWeaponPrefab("no_tag_weapon", null, 0, 0, 0, 0, []);

    @:nullSafety(Off)
    private var weapon:Weapon;

    @:nullSafety(Off)
    private var no_tag_weapon:Weapon;

    override public function setup()
    {
        super.setup();

        this.weapon = this.createWeapon();
        this.c1.getTrait(HeldWeapon.TYPE).setHand(EnumHand.HAND, weapon);

        this.no_tag_weapon = this.createNoTagWeapon();
        c2.getTrait(HeldWeapon.TYPE).setHand(EnumHand.HAND, no_tag_weapon);
    }

    private function createNoTagWeapon():Weapon
    {
        return NO_TAG_WEAPON.createWeapon(this.system);
    }

    private function createWeapon():Weapon
    {
        var prefab = this.createPrefab();
        var weapon = prefab.createWeapon(this.system);
        return weapon;
    }

    private function assertBonus(action:AttackAction, gameObject:GameObject, value:Null<Int>):Void
    {
        var pool = action.getCompetition().getPool(gameObject);
        var request = pool.getRequest();
        var modifiers = request.getAppliedModifiers();
        assertEquals(value, modifiers[this.getTagType().getDN()]);
    }

    private function assertTraits(action:AttackAction, gameObject:GameObject, traits:Array<TraitType<Dynamic>>)
    {
        var pool = action.getCompetition().getPool(gameObject);
        var request = pool.getRequest();
        this.assertArrayEquals(traits.map(v -> v.getDN()), request.getTraits());
    }

    private function createPrefab():WeaponPrefab
    {
        return new MeleeWeaponPrefab("weapon", null, 0, 0, 0, 0, [this.getTagType()]);
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
