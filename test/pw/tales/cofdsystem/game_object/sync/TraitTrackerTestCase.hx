package pw.tales.cofdsystem.game_object.sync;

import pw.tales.cofdsystem.character.traits.attribute.Attribute;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.mocks.CharacterMock;
import haxe.unit.TestCase;

@:nullSafety(Off)
class TraitTrackerTestCase extends TestCase
{
    public function testAddTrait():Void
    {
        var system = new CofDSystem();
        var c1 = new CharacterMock(system);

        var manager = c1.getTraitManager();
        var tracker = new TraitTracker(c1);

        var strength:Attribute = cast(manager.addTrait(Attributes.STRENGTH));
        assertEquals(
            Std.string([strength]),
            Std.string(tracker.getUpdate())
        );
        assertEquals(
            Std.string([]),
            Std.string(tracker.getRemove())
        );
    }

    public function testUpdateTrait():Void
    {
        var system = new CofDSystem();
        var c1 = new CharacterMock(system);

        var manager = c1.getTraitManager();
        var tracker = new TraitTracker(c1);

        var strength:Attribute = cast(manager.addTrait(Attributes.STRENGTH));
        tracker.clear();

        assertEquals(
            Std.string([]),
            Std.string(tracker.getUpdate())
        );
        assertEquals(
            Std.string([]),
            Std.string(tracker.getRemove())
        );

        strength.setValue(5);

        assertEquals(
            Std.string([strength]),
            Std.string(tracker.getUpdate())
        );
        assertEquals(
            Std.string([]),
            Std.string(tracker.getRemove())
        );
    }

    public function testRemoveNewTrait():Void
    {
        var system = new CofDSystem();
        var c1 = new CharacterMock(system);

        var manager = c1.getTraitManager();
        var tracker = new TraitTracker(c1);

        var strength:Attribute = cast(manager.addTrait(Attributes.STRENGTH));
        manager.removeTrait(strength);

        assertEquals(
            Std.string([]),
            Std.string(tracker.getUpdate())
        );
        assertEquals(
            Std.string([]),
            Std.string(tracker.getRemove())
        );
    }

    public function testRemoveOldTrait():Void
    {
        var system = new CofDSystem();
        var c1 = new CharacterMock(system);

        var manager = c1.getTraitManager();
        var tracker = new TraitTracker(c1);

        var strength:Attribute = cast(manager.addTrait(Attributes.STRENGTH));
        tracker.clear();
        manager.removeTrait(strength);

        assertEquals(
            Std.string([]),
            Std.string(tracker.getUpdate())
        );
        assertEquals(
            Std.string([strength]),
            Std.string(tracker.getRemove())
        );
    }
}
