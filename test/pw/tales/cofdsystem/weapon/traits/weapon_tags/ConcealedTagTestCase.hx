package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.game_object.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;

class ConcealedTagTestCase extends WeaponTagTestCase
{
    private override function getTagType():TraitType<Dynamic>
    {
        return ConcealedTag.TYPE;
    }

    private function setShieldSize(size:Int):Void
    {
        var gameObject = this.weapon.getGameObject();
        gameObject.getTrait(SizeAdvantage.TYPE).setValue(size);
    }

    public function testConcealedAppliedWhenTargetWithShield():Void
    {
        for (size in 1...5)
        {
            this.setShieldSize(size);

            var action = new AttackBuilder(c2, c1).build();
            action.execute();

            this.assertBonus(action, c1, size);
            this.assertBonus(action, c2, null);
        }
    }

    public function testConcealedNotAppliedWhenActorWithShield():Void
    {
        this.setShieldSize(3);

        var action = new AttackBuilder(c1, c2).build();
        action.execute();

        this.assertBonus(action, c1, null);
        this.assertBonus(action, c2, null);
    }
}
