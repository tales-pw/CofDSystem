package pw.tales.cofdsystem.character.tilts;

import haxe.unit.TestCase;
import thx.error.NotImplemented;
import pw.tales.cofdsystem.scene.Scene;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class BaseTiltTestCase extends CofDSystemTestCase
{
    public function getTiltType():TraitType<Dynamic>
    {
        throw new NotImplemented();
    }

    public function testTiltsDeletedOnSceneEnd():Void
    {
        var scene = Scene.create(this.system);
        scene.add(c1);
        scene.begin();

        var tiltType = this.getTiltType();
        var tilt = c1.getTraitManager().addTrait(tiltType);

        // Exists before scene end
        assertTrue(
            c1.getTraitManager().getTrait(tiltType, tilt.getDN()) != null
        );

        // Scene end
        scene.end();

        // Disappears after scene end
        assertTrue(
            c1.getTraitManager().getTrait(tiltType, tilt.getDN()) == null
        );
    }

    public override function getBaseTest():Class<TestCase>
    {
        return BaseTiltTestCase;
    }
}
