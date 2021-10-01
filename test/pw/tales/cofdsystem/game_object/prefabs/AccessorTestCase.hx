package pw.tales.cofdsystem.game_object.prefabs;

class TestAccessor extends Accessor
{
    public function new(gameObject:GameObject)
    {
        super(gameObject);
    }
}

class AccessorTestCase extends CofDSystemTestCase
{
    public function testEqualsEqual()
    {
        var accessor1 = new TestAccessor(this.c1);
        var accessor2 = new TestAccessor(this.c1);

        assertTrue(accessor1.equals(accessor1));
        assertTrue(accessor1.equals(accessor2));
    }

    public function testEqualsNotEqual()
    {
        var accessor1 = new TestAccessor(this.c1);
        var accessor2 = new TestAccessor(this.c2);

        assertFalse(accessor1.equals(accessor2));
    }
}
