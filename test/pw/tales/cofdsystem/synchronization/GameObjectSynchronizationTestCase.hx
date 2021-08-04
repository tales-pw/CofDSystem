package pw.tales.cofdsystem.synchronization;

import pw.tales.cofdsystem.character.traits.advantages.health.HealthAdvantage;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.damage.Damage;
import pw.tales.cofdsystem.synchronization.GameObjectSynchronization;

@:nullSafety(Off)
class GameObjectSynchronizationTestCase extends CofDSystemTestCase
{
    public function testTraitSync()
    {
        c1.getTrait(Attributes.STRENGTH).setValue(3);
        c1.getTrait(Skills.BRAWL).setValue(2);
        c1.getTrait(HealthAdvantage.TYPE).dealDamage(new Damage(1, 0, 0));

        var serializer = GameObjectSynchronization.create(system, c1);
        var serialzedData = serializer.serialize();

        var deserializer = GameObjectSynchronization.createDeserializer(system);
        deserializer.deserialize(serialzedData);
        var dc1 = deserializer.gameObject;

        assertEquals(c1.getDN(), dc1.getDN());

        var c1Manager = c1.getTraitManager();
        var dc1Manager = dc1.getTraitManager();

        assertEquals(c1Manager.getTraits().items().length, dc1Manager.getTraits().items().length);

        for (trait in c1Manager.getTraits().items())
        {
            var traitType = trait.getType();
            assertEquals(Std.string(c1Manager.getTraitByDn(trait.getDN()).serialize()), Std.string(dc1Manager.getTraitByDn(trait.getDN()).serialize()));
        }
    }
}
