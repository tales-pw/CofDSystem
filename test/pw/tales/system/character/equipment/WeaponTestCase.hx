package pw.tales.system.character.equipment;

import pw.tales.system.action_attack.builder.AttackBuilder;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.character.traits.HeldWeapon;
import pw.tales.system.character.traits.skill.Skills;
import pw.tales.system.common.EnumHand;
import pw.tales.system.common.EnumSide;
import pw.tales.system.scene.initiative.events.InitiativeModifiersEvent;
import pw.tales.system.scene.Scene;
import pw.tales.system.weapon.prefabs.WeaponPrefab;
import pw.tales.system.weapon_melee.prefabs.MeleeWeaponPrefab;
import pw.tales.system.weapon_ranged.prefabs.RangedWeaponPrefab;
import thx.Uuid;

@:nullSafety(Off)
class WeaponTestCase extends CofDSystemTestCase {
    public final GENERIC_MELEE_WEAPON = new MeleeWeaponPrefab(Uuid.create(), "", -2, 0, []);
    public final GENERIC_RANGED_WEAPON = new RangedWeaponPrefab(Uuid.create(), "", -2, 0, []);

    override public function setup() {
        super.setup();
        c1.getTraitManager().getTrait(Attributes.STRENGTH).setValue(1);
        c1.getTraitManager().getTrait(Skills.WEAPONRY).setValue(1);
        c1.getTraitManager().getTrait(Skills.BRAWL).setValue(1);
        c1.getTraitManager().getTrait(Skills.SHOOTING).setValue(1);

        c2.getTraitManager().getTrait(Attributes.DEXTERITY).setValue(1);
        c2.getTraitManager().getTrait(Attributes.WITS).setValue(1);
        c2.getTraitManager().getTrait(Skills.ATHLETICS).setValue(0);
    }

    private function getInitiativeMod():Int {
        var scene = Scene.create(system);
        var initiativeEvent = new InitiativeModifiersEvent(c1, scene.getInitiative());
        c1.getEventBus().post(initiativeEvent);

        return initiativeEvent.getModifier();
    }

    public function testApplyInitiativeMod() {
        assertEquals(2, this.getInitiativeMod());

        var weaponTrait:HeldWeapon = cast(c1.getTraitManager().getTrait(HeldWeapon.TYPE));

        weaponTrait.setMainHand(GENERIC_MELEE_WEAPON.createWeapon(system));
        assertEquals(0, this.getInitiativeMod());

        weaponTrait.setOffHand(GENERIC_MELEE_WEAPON.createWeapon(system));
        assertEquals(-1, this.getInitiativeMod());

        weaponTrait.setMainHand(null);
        assertEquals(0, this.getInitiativeMod());

        weaponTrait.setOffHand(null);
        assertEquals(2, this.getInitiativeMod());
    }

    public function methodTestWeaponPool(weapon:WeaponPrefab, pool:Array<String>) {
        var weaponTrait:HeldWeapon = cast(c1.getTraitManager().getTrait(HeldWeapon.TYPE));
        weaponTrait.setMainHand(weapon.createWeapon(system));

        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        var traits = action.getOpposition().getPool(c1).getRequest().getTraits();
        assertEquals(Std.string(pool), Std.string(traits));
    }

    public function testMeleeWeaponPool() {
        this.methodTestWeaponPool(GENERIC_MELEE_WEAPON, [
            Attributes.STRENGTH.getDN(),
            Skills.WEAPONRY.getDN()
        ]);
    }

    public function testRangedWeaponPool() {
        this.methodTestWeaponPool(GENERIC_RANGED_WEAPON, [
            Attributes.DEXTERITY.getDN(),
            Skills.SHOOTING.getDN()
        ]);
    }

    public function testMeleeWeaponPoolIsRemovedWhenWeaponRemoved() {
        var heldWeapon:HeldWeapon = cast(c1.getTraitManager().getTrait(HeldWeapon.TYPE));
        heldWeapon.setMainHand(GENERIC_MELEE_WEAPON.createWeapon(system));
        heldWeapon.setMainHand(null);

        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        var traits = action.getOpposition().getPool(c1).getRequest().getTraits();
        assertEquals(Std.string([Attributes.STRENGTH.getDN(), Skills.BRAWL.getDN()]), Std.string(traits));
    }

    public function testWeaponHand() {
        var heldWeapon:HeldWeapon = cast(c1.getTraitManager().getTrait(HeldWeapon.TYPE));
        heldWeapon.setOffHand(GENERIC_MELEE_WEAPON.createWeapon(system));

        var action = new AttackBuilder(c1, c2).build();
        system.act(action);
        var traits = action.getOpposition().getPool(c1).getRequest().getTraits();
        assertEquals(Std.string([Attributes.STRENGTH.getDN(), Skills.BRAWL.getDN()]), Std.string(traits));

        var action = new AttackBuilder(c1, c2).setHand(EnumSide.ACTOR, EnumHand.OFFHAND).build();
        system.act(action);
        var traits = action.getOpposition().getPool(c1).getRequest().getTraits();
        assertEquals(Std.string([Attributes.STRENGTH.getDN(), Skills.WEAPONRY.getDN()]), Std.string(traits));
    }
}
