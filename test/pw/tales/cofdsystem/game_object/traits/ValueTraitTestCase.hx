package pw.tales.cofdsystem.game_object.traits;

import pw.tales.cofdsystem.game_object.traits.value_trait.exceptions.UpdateRejectedException;
import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTraitType;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTrait;

class ValueTraitTestCase extends CofDSystemTestCase
{
    public static final TRAIT_LIMIT = 5;
    public static final TEST_TRAIT_TYPE = new ValueTraitType(
        "test"
    ).setFactoryMethod(
        (dn, go, type) -> new ValueTrait(dn, go, cast type, 0)
    );

    override public function setup():Void
    {
        super.setup();
        this.c1.getTraitManager().addTrait(TEST_TRAIT_TYPE);
    }

    public function testOrdinarySet():Void
    {
        var trait = this.c1.getTrait(TEST_TRAIT_TYPE);

        this.assertEquals(trait.getValue(), 0);

        for (i in 0...TRAIT_LIMIT)
        {
            trait.setValue(i);
            this.assertEquals(trait.getValue(), i);
        }
    }

    public function testSetAboveTraitLimit():Void
    {
        var triggered = false;

        try
        {
            this.c1.getTrait(TEST_TRAIT_TYPE).setValue(TRAIT_LIMIT + 1);
        } catch (e:UpdateRejectedException)
        {
            triggered = true;
        }

        this.assertTrue(triggered);
    }

    public function testSetForbiddenByExternal():Void
    {
        this.c1.getEventBus().addHandler(ValueTraitUpdateEvent, (e) -> e.setCancelled(true));
        var triggered = false;

        try
        {
            this.c1.getTrait(TEST_TRAIT_TYPE).setValue(TRAIT_LIMIT);
        } catch (e:UpdateRejectedException)
        {
            triggered = true;
        }

        this.assertTrue(triggered);
    }
}
