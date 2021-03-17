package pw.tales.system.game_object.traits;

import pw.tales.system.action.EnumTime;
import pw.tales.system.action.opposition.pool.ActionPool;
import pw.tales.system.action.opposition.Resisted;
import pw.tales.system.action.opposition.Simple;
import pw.tales.system.character.traits.advantages.health.events.GameObjectDiedEvent;
import pw.tales.system.character.traits.advantages.health.HealthAdvantage;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.damage.Damage;
import pw.tales.system.game_object.health_helper.HealthTraitHelper;
import pw.tales.system.mocks.BasicAction;

@:nullSafety(Off)
class HealthTestCase extends CofDSystemTestCase {
    private function prepareHealthAdvantage(bashing:Int, lethal:Int, aggravated:Int):HealthAdvantage {
        var health:HealthAdvantage = cast c1.getTraitManager().getTrait(HealthAdvantage.TYPE);
        assertEquals(health.getValue(), 6);

        // Fill health with lethal
        health.dealDamage(new Damage(bashing, lethal, aggravated));
        assertEquals(bashing, health.getBashing());
        assertEquals(lethal, health.getLethal());
        assertEquals(aggravated, health.getAggravated());

        return health;
    }

    private function methodTestHealthPenalty(diff:Int, result:Null<Int>) {
        var manager = c1.getTraitManager();
        manager.getTrait(Attributes.STAMINA).setValue(1);

        var maxHealth = manager.getTrait(HealthAdvantage.TYPE).getValue();
        HealthTraitHelper.get(c1).dealDamage(new Damage(maxHealth - diff, 0, 0));

        var actorRoll = new ActionPool(c1, []);
        var opposition = new Simple(actorRoll, 0);
        var action = new BasicAction(opposition, EnumTime.INSTANT);
        action.execute(system, null);

        var roll = opposition.getPool(c1);
        assertEquals(result, roll.getRequest().getAppliedModifiers()[HealthAdvantage.DN]);
    }

    public function testPenalty0HPLeft() {
        this.methodTestHealthPenalty(0, -3);
    }

    public function testPenalty1HPLeft() {
        this.methodTestHealthPenalty(1, -3);
    }

    public function testPenalty2HPLeft() {
        this.methodTestHealthPenalty(2, -2);
    }

    public function testPenalty3HPLeft() {
        this.methodTestHealthPenalty(3, -1);
    }

    public function testPenalty4HPLeft() {
        this.methodTestHealthPenalty(4, null);
    }

    public function testHealthRollPenaltyForResistedAction() {
        var maxHealth = c2.getTraitManager().getTrait(HealthAdvantage.TYPE).getValue();
        HealthTraitHelper.get(c2).dealDamage(new Damage(maxHealth, 0, 0));

        var actorRoll = new ActionPool(c1, []);
        var targetRoll = new ActionPool(c2, []);
        var opposition = new Resisted(actorRoll, targetRoll);

        var action = new BasicAction(opposition, EnumTime.INSTANT);
        action.execute(system, null);
        var roll = opposition.getPool(c1);
        assertEquals(null, roll.getRequest().getAppliedModifiers()[HealthAdvantage.DN]);
    }

    public function testSimpleDamage() {
        c1.getTraitManager().getTrait(Attributes.STAMINA).setValue(2);
        var health:HealthAdvantage = cast(c1.getTraitManager().getTrait(HealthAdvantage.TYPE));
        assertEquals(7, health.getValue());

        // Cassidy has seven boxes in her Health track.
        // She’s just taken one point of bashing damage. Her Health
        // boxes look like this:
        // [/] [ ] [ ] [ ] [ ] [ ] [ ]
        health.dealDamage(new Damage(1, 0, 0));
        assertEquals(1, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());

        // If she’s later stabbed and takes a point of lethal damage,
        // her Health track would be:
        // [X] [/] [ ] [ ] [ ] [ ] [ ]
        health.dealDamage(new Damage(0, 1, 0));
        assertEquals(1, health.getBashing());
        assertEquals(1, health.getLethal());
        assertEquals(0, health.getAggravated());

        // If Cassidy next suffered a point of aggravated damage,
        // her Health boxes would look like this:
        // [*] [X] [/] [ ] [ ] [ ] [ ]
        health.dealDamage(new Damage(0, 0, 1));
        assertEquals(1, health.getBashing());
        assertEquals(1, health.getLethal());
        assertEquals(1, health.getAggravated());
    }

    public function testUpgradingBashingWithBashing() {
        var health:HealthAdvantage = this.prepareHealthAdvantage(6, 0, 0);

        health.dealDamage(new Damage(1, 0, 0));
        assertEquals(5, health.getBashing());
        assertEquals(1, health.getLethal());
        assertEquals(0, health.getAggravated());
    }

    public function testUpgradingBashingWithLethal() {
        var health:HealthAdvantage = this.prepareHealthAdvantage(6, 0, 0);

        health.dealDamage(new Damage(0, 1, 0));
        assertEquals(5, health.getBashing());
        assertEquals(1, health.getLethal());
        assertEquals(0, health.getAggravated());
    }

    public function testUpgradingBashingWithAggravated() {
        var health:HealthAdvantage = this.prepareHealthAdvantage(6, 0, 0);

        health.dealDamage(new Damage(0, 0, 1));
        assertEquals(5, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(1, health.getAggravated());
    }

    public function testUpgradingLethalWithBashing() {
        var health:HealthAdvantage = this.prepareHealthAdvantage(0, 6, 0);

        health.dealDamage(new Damage(1, 0, 0));
        assertEquals(0, health.getBashing());
        assertEquals(5, health.getLethal());
        assertEquals(1, health.getAggravated());
    }

    public function testUpgradingLethalWithLethal() {
        var health:HealthAdvantage = this.prepareHealthAdvantage(0, 6, 0);

        health.dealDamage(new Damage(0, 1, 0));
        assertEquals(0, health.getBashing());
        assertEquals(5, health.getLethal());
        assertEquals(1, health.getAggravated());
    }

    public function testUpgradingLethalWithAggravated() {
        var health:HealthAdvantage = this.prepareHealthAdvantage(0, 6, 0);

        health.dealDamage(new Damage(0, 0, 1));
        assertEquals(0, health.getBashing());
        assertEquals(5, health.getLethal());
        assertEquals(1, health.getAggravated());
    }

    public function testDeath() {
        var health:HealthAdvantage = cast(c1.getTraitManager().getTrait(HealthAdvantage.TYPE));
        assertEquals(health.getValue(), 6);

        var hasDied = false;
        c1.getEventBus().addHandler(GameObjectDiedEvent, function(e:GameObjectDiedEvent) {
            hasDied = true;
        });

        // Make sure character doesn't die from any damage
        health.dealDamage(new Damage(1, 0, 0));
        assertFalse(hasDied);

        // Kill character by filling it health with aggravated damage
        health.dealDamage(new Damage(0, 0, 6));
        assertTrue(hasDied);
    }
}
