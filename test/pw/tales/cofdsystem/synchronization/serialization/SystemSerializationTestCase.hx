package pw.tales.cofdsystem.synchronization.serialization;

import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;

class SystemSerializationTestCase extends CofDSystemTestCase
{
    public function test():Void
    {
        var system = SystemSerialization.INSTANCE.deserialize(TestData.SYSTEM_VALID_DATA);

        this.assertTrue(new CofDSystem().traits.items().length < system.traits.items().length);
    }
}
