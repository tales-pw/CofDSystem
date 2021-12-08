package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class ReachTagTestCase extends WeaponTagTestCase
{
    private override function getTagType():TraitType<Dynamic>
    {
        return ReachTag.TYPE;
    }

    public function testApplied():Void
    {
        var action = new AttackBuilder(c2, c1).build();
        action.execute();

        this.assertBonus(action, c1, 1);
        this.assertBonus(action, c2, null);
    }

    public function testNotApplied():Void
    {
        var action = new AttackBuilder(c1, c2).build();
        action.execute();

        this.assertBonus(action, c1, null);
        this.assertBonus(action, c2, null);
    }

    public function testNotAppliedWhenEnemyHasReach():Void
    {
        var weapon = c2.getTrait(HeldWeapon.TYPE).getMainHand();
        @:nullSafety(Off)
        weapon.getGameObject().getTraitManager().addTrait(this.getTagType());

        var action = new AttackBuilder(c2, c1).build();
        action.execute();

        this.assertBonus(action, c1, null);
        this.assertBonus(action, c2, null);
    }
}
