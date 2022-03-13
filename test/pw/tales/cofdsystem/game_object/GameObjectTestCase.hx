package pw.tales.cofdsystem.game_object;

class GameObjectTestCase extends CofDSystemTestCase
{
    public function testDeactivate():Void
    {
        this.c1.deactivate();
        assertEquals(GameObjectState.INACTIVE, c1.getState());
    }

    public function testClone():Void
    {
        var c1_clone = this.c1.clone();
        assertTrue(this.c1.getDN() != c1_clone.getDN());
    }
}
