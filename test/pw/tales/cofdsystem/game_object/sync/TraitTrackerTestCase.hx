package pw.tales.cofdsystem.game_object.sync;

import pw.tales.cofdsystem.character.traits.attribute.Attribute;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.mocks.CharacterMock;

@:nullSafety(Off)
class TraitTrackerTestCase extends haxe.unit.TestCase {
    public function testAddTrait() {
        var system = new CofDSystem();
        var c1 = new CharacterMock(system);

        var manager = c1.getTraitManager();
        var tracker = new TraitTracker(c1);

        var strength:Attribute = cast(manager.addTrait(Attributes.STRENGTH));
        assertEquals(Std.string([strength]), Std.string(tracker.getUpdate()));
        assertEquals(Std.string([]), Std.string(tracker.getRemove()));
    }

    public function testUpdateTrait() {
        var system = new CofDSystem();
        var c1 = new CharacterMock(system);

        var manager = c1.getTraitManager();
        var tracker = new TraitTracker(c1);

        var strength:Attribute = cast(manager.addTrait(Attributes.STRENGTH));
        tracker.clear();

        assertEquals(Std.string([]), Std.string(tracker.getUpdate()));
        assertEquals(Std.string([]), Std.string(tracker.getRemove()));

        strength.setValue(5);

        assertEquals(Std.string([strength]), Std.string(tracker.getUpdate()));
        assertEquals(Std.string([]), Std.string(tracker.getRemove()));
    }

    public function testRemoveNewTrait() {
        var system = new CofDSystem();
        var c1 = new CharacterMock(system);

        var manager = c1.getTraitManager();
        var tracker = new TraitTracker(c1);

        var strength:Attribute = cast(manager.addTrait(Attributes.STRENGTH));
        manager.removeTrait(strength);

        assertEquals(Std.string([]), Std.string(tracker.getUpdate()));
        assertEquals(Std.string([]), Std.string(tracker.getRemove()));
    }

    public function testRemoveOldTrait() {
        var system = new CofDSystem();
        var c1 = new CharacterMock(system);

        var manager = c1.getTraitManager();
        var tracker = new TraitTracker(c1);

        var strength:Attribute = cast(manager.addTrait(Attributes.STRENGTH));
        tracker.clear();
        manager.removeTrait(strength);

        assertEquals(Std.string([]), Std.string(tracker.getUpdate()));
        assertEquals(Std.string([strength]), Std.string(tracker.getRemove()));
    }
}
