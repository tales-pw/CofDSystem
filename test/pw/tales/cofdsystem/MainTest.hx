package pw.tales.cofdsystem;

import haxe.unit.TestRunner;
import pw.tales.cofdsystem.action_attack.AttackBuilderTestCase;
import pw.tales.cofdsystem.character.advancement.GenAdvancementTestCase;
import pw.tales.cofdsystem.character.advantages.WillpowerAdvantageTestCase;
import pw.tales.cofdsystem.character.equipment.ArmorTestCase;
import pw.tales.cofdsystem.character.equipment.WeaponTestCase;
import pw.tales.cofdsystem.character.merits.AmbidextrousTestCase;
import pw.tales.cofdsystem.character.merits.FleetOfFootTestCase;
import pw.tales.cofdsystem.character.merits.GiantTestCase;
import pw.tales.cofdsystem.character.merits.SmallFramedTestCase;
import pw.tales.cofdsystem.damage.DamageTestCase;
import pw.tales.cofdsystem.damage.DamageUtilTestCase;
import pw.tales.cofdsystem.dices.DiceTestCase;
import pw.tales.cofdsystem.game_object.GameObjectTestCase;
import pw.tales.cofdsystem.game_object.sync.TraitTrackerTestCase;
import pw.tales.cofdsystem.game_object.traits.HealthTestCase;
import pw.tales.cofdsystem.game_object.traits.ManagerTestCase;
import pw.tales.cofdsystem.parser.parsers.DotsLevelsTestCase;
import pw.tales.cofdsystem.parser.parsers.RequirementsTestCase;
import pw.tales.cofdsystem.range.RangeTestCase;
import pw.tales.cofdsystem.scene.InitiativeTestCase;
import pw.tales.cofdsystem.scene.TurnsTestCase;
import pw.tales.cofdsystem.synchronization.GameObjectSynchronizationTestCase;
import pw.tales.cofdsystem.synchronization.SystemSynchronizationTestCase;
import pw.tales.cofdsystem.utils.events.EventBusTestCase;

class MainTest {
    static public function main() {
        var r = new TestRunner();

        r.add(new GameObjectTestCase());
        r.add(new ManagerTestCase());
        r.add(new GameObjectSynchronizationTestCase());

        // Advatnages
        r.add(new WillpowerAdvantageTestCase());

        // Merits
        r.add(new AmbidextrousTestCase());
        r.add(new FleetOfFootTestCase());
        r.add(new GiantTestCase());
        r.add(new SmallFramedTestCase());

        // Utils
        r.add(new EventBusTestCase());
        r.add(new DiceTestCase());
        r.add(new RangeTestCase());

        // Damage
        r.add(new DamageTestCase());
        r.add(new DamageUtilTestCase());

        // Parsers
        r.add(new DotsLevelsTestCase());
        r.add(new RequirementsTestCase());

        // Advancement
        r.add(new GenAdvancementTestCase());

        // Attack
        r.add(new AttackBuilderTestCase());

        // Equipment
        r.add(new ArmorTestCase());
        r.add(new WeaponTestCase());

        // Advantages
        r.add(new HealthTestCase());
        r.add(new TraitTrackerTestCase());

        // Scene
        r.add(new TurnsTestCase());
        r.add(new InitiativeTestCase());

        // Sync
        r.add(new SystemSynchronizationTestCase());

        r.run();
    }
}
