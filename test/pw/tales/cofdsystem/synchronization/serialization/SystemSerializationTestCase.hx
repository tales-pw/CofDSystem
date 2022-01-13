package pw.tales.cofdsystem.synchronization.serialization;

import pw.tales.cofdsystem.weapon.traits.weapon_tags.WeaponTag;
import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;

class SystemSerializationTestCase extends CofDSystemTestCase
{
    /** Tests deserialization with real data. **/
    public function test():Void
    {
        SystemSerialization.INSTANCE.deserialize(TestData.SYSTEM_VALID_DATA);
        this.assertTrue(true);
    }

    /** Tests creation of missing weapon tag from remote data. **/
    public function testRemoteWeaponTag() {
        var system = SystemSerialization.INSTANCE.update(this.system, TestData.SYSTEM_DATA_REMOTE_WEAPON_TAG);

        var traitType = system.traits.getRecord("Remote (weapon tag)");
        var trait = c1.getTraitManager().addTrait(traitType);

        this.assertEquals(Type.getClass(trait), WeaponTag);
    }
}
