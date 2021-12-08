package pw.tales.cofdsystem.scene;

import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.mocks.DiceRollerMock;

class InitiativeTestCase extends CofDSystemTestCase
{
    override public function setup()
    {
        super.setup();
        system.dices = new DiceRollerMock([5, 8, 6]);
    }

    public function testInitiative()
    {
        var scene = Scene.create(system);
        var initiative = scene.getInitiative();
        initiative.add(c1);
        initiative.add(c2);
        initiative.add(c3);

        var order = initiative.getOrder();
        assertEquals(Std.string([c2, c3, c1]), Std.string(order));

        c1.getTrait(Attributes.DEXTERITY).setValue(2);
        initiative.update();
        order = initiative.getOrder();
        assertEquals(Std.string([c2, c1, c3]), Std.string(order));

        c1.getTrait(Attributes.DEXTERITY).setValue(5);
        initiative.update();
        order = initiative.getOrder();
        assertEquals(Std.string([c1, c2, c3]), Std.string(order));
    }
}
