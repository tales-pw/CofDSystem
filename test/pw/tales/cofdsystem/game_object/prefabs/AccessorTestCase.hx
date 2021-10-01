package pw.tales.cofdsystem.game_object.prefabs;

import pw.tales.cofdsystem.weapon.Weapon;

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
        assertFalse(accessor1.equals(null));
    }

    public function testEqualsDifferentClass()
    {
        var accessor1 = new TestAccessor(this.c1);
        var accessor2 = new Weapon(this.c2);

        assertFalse(accessor1.equals(accessor2));
    }
}
