package pw.tales.cofdsystem.character;

import pw.tales.cofdsystem.armor.prefabs.ArmorPrefab;
import pw.tales.cofdsystem.character.traits.WornArmor;
import thx.Uuid;

class WornArmorTestCase extends CofDSystemTestCase {
    public final ARMOR = new ArmorPrefab(Uuid.create(), "", 0, 0, 0, 0, 0);

    public function testCreate() {
        var trait = WornArmor.create("dn", this.c1, WornArmor.TYPE);

        this.assertEquals(trait.getDN(), WornArmor.TYPE.getDN());
        this.assertEquals(trait.getArmor(), null);
    }

    public function testSetArmor() {
        var trait = this.c1.getTrait(WornArmor.TYPE);
        var armor = ARMOR.createArmor(this.system);

        trait.setArmor(armor);
        this.assertEquals(trait.getArmor(), armor);
        this.assertEquals(armor.getEquipper(), this.c1);

        trait.setArmor(null);
        this.assertEquals(trait.getArmor(), null);
        this.assertEquals(armor.getEquipper(), null);
    }
}