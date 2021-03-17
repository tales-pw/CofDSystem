package pw.tales.system;

import haxe.unit.TestRunner;
import pw.tales.system.action_attack.AttackBuilderTestCase;
import pw.tales.system.character.advancement.GenAdvancementTestCase;
import pw.tales.system.character.equipment.ArmorTestCase;
import pw.tales.system.character.equipment.WeaponTestCase;
import pw.tales.system.character.merits.AmbidextrousTestCase;
import pw.tales.system.character.merits.FleetOfFootTestCase;
import pw.tales.system.character.merits.GiantTestCase;
import pw.tales.system.character.merits.SmallFramedTestCase;
import pw.tales.system.damage.DamageTestCase;
import pw.tales.system.damage.DamageUtilTestCase;
import pw.tales.system.dices.DiceTestCase;
import pw.tales.system.game_object.GameObjectTestCase;
import pw.tales.system.game_object.sync.TraitTrackerTestCase;
import pw.tales.system.game_object.traits.HealthTestCase;
import pw.tales.system.game_object.traits.ManagerTestCase;
import pw.tales.system.parser.parsers.DotsLevelsTestCase;
import pw.tales.system.parser.parsers.RequirementsTestCase;
import pw.tales.system.range.RangeTestCase;
import pw.tales.system.scene.InitiativeTestCase;
import pw.tales.system.scene.TurnsTestCase;
import pw.tales.system.synchronization.GameObjectSynchronizationTestCase;
import pw.tales.system.synchronization.SystemSynchronizationTestCase;
import pw.tales.system.utils.events.EventBusTestCase;

class MainTest {
    static public function main() {
        var r = new TestRunner();

        r.add(new GameObjectTestCase());
        r.add(new ManagerTestCase());
        r.add(new GameObjectSynchronizationTestCase());

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
