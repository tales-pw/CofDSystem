package pw.tales.cofdsystem.synchronization.serialization;

import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;

class SystemSerializationTestCase extends CofDSystemTestCase
{
    public function testDeserialize()
    {
        var data = CompileTime.readFile("test/pw/tales/cofdsystem/synchronization/serialization/test_data/system_data_valid.json");
        var system = SystemSerialization.INSTANCE.deserialize(data);

        this.assertTrue(new CofDSystem().traits.items().length < system.traits.items().length);
    }
}
