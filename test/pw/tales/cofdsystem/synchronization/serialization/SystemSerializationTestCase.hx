package pw.tales.cofdsystem.synchronization.serialization;

import pw.tales.cofdsystem.character.traits.tilts.Tilt;
import pw.tales.cofdsystem.character.traits.condition.Condition;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.WeaponTag;
import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;

class SystemSerializationTestCase extends CofDSystemTestCase
{
    private final REMOTE_TRAIT_DN = "Remote";

    /** Tests deserialization with real data. **/
    public function test():Void
    {
        SystemSerialization.INSTANCE.deserialize(TestData.SYSTEM_VALID_DATA);
        this.assertTrue(true);
    }

    /** Tests creation of missing trait from remote data. **/
    private function methodTestRemoteTrait(data:String, clazz:Class<Dynamic>)
    {
        var system = SystemSerialization.INSTANCE.update(this.system, data);

        var traitType = system.traits.getRecord(REMOTE_TRAIT_DN);
        var trait = c1.getTraitManager().addTrait(traitType);

        this.assertEquals(REMOTE_TRAIT_DN, trait.getDN());
        this.assertEquals(Type.getClass(trait), clazz);
    }

    /** Tests creation of missing weapon tag from remote data. **/
    public function testRemoteWeaponTag()
    {
        this.methodTestRemoteTrait(
            TestData.SYSTEM_DATA_REMOTE_WEAPON_TAG,
            WeaponTag
        );

        var traitType = system.traits.getRecord(REMOTE_TRAIT_DN);

        var melee = this.system.weapons.getRecord("melee_weapon");
        this.assertArrayEquals([traitType], melee.getWeaponTags());

        var ranged = this.system.weapons.getRecord("ranged_weapon");
        this.assertArrayEquals([traitType], ranged.getWeaponTags());
    }

    /** Tests creation of missing condition from remote data. **/
    public function testRemoteCondition()
    {
        this.methodTestRemoteTrait(
            TestData.SYSTEM_DATA_REMOTE_CONDITION,
            Condition
        );
    }

    /** Tests creation of missing tilt from remote data. **/
    public function testRemoteTilt()
    {
        this.methodTestRemoteTrait(
            TestData.SYSTEM_DATA_REMOTE_TILT,
            Tilt
        );
    }
}
