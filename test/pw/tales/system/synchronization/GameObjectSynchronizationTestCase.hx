package pw.tales.system.synchronization;

import pw.tales.system.character.traits.advantages.health.HealthAdvantage;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.character.traits.skill.Skills;
import pw.tales.system.damage.Damage;
import pw.tales.system.synchronization.GameObjectSynchronization;

@:nullSafety(Off)
class GameObjectSynchronizationTestCase extends CofDSystemTestCase {

    public function testTraitSync() {
        c1.getTraitManager().getTrait(Attributes.STRENGTH).setValue(3);
        c1.getTraitManager().getTrait(Skills.BRAWL).setValue(2);
        c1.getTraitManager().getTrait(HealthAdvantage.TYPE).dealDamage(new Damage(1, 0, 0));

        var serializer = GameObjectSynchronization.create(system, c1);
        var serialzedData = serializer.serialize();

        var deserializer = GameObjectSynchronization.createDeserializer(system);
        deserializer.deserialize(serialzedData);
        var dc1 = deserializer.gameObject;

        assertEquals(c1.getDN(), dc1.getDN());

        var c1Manager = c1.getTraitManager();
        var dc1Manager = dc1.getTraitManager();

        assertEquals(
            c1Manager.getTraits().items().length,
            dc1Manager.getTraits().items().length
        );

        for (trait in c1Manager.getTraits().items()) {
            var traitType = trait.getType();
            assertEquals(
                Std.string(c1Manager.getTraitByDn(trait.getDN()).serialize()),
                Std.string(dc1Manager.getTraitByDn(trait.getDN()).serialize())
            );
        }
    }
}
