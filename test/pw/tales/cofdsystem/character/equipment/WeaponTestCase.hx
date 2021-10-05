package pw.tales.cofdsystem.character.equipment;

import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.common.EnumSide;
import pw.tales.cofdsystem.scene.initiative.events.InitiativeModifiersEvent;
import pw.tales.cofdsystem.scene.Scene;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.weapon_melee.prefabs.MeleeWeaponPrefab;
import pw.tales.cofdsystem.weapon_ranged.prefabs.RangedWeaponPrefab;
import thx.Uuid;

@:nullSafety(Off)
class WeaponTestCase extends CofDSystemTestCase
{
    public final GENERIC_MELEE_WEAPON = new MeleeWeaponPrefab(Uuid.create(), "", -2, 0, []);
    public final GENERIC_RANGED_WEAPON = new RangedWeaponPrefab(Uuid.create(), "", -2, 0, []);

    override public function setup()
    {
        super.setup();
        c1.getTrait(Attributes.STRENGTH).setValue(1);
        c1.getTrait(Skills.WEAPONRY).setValue(1);
        c1.getTrait(Skills.BRAWL).setValue(1);
        c1.getTrait(Skills.SHOOTING).setValue(1);

        c2.getTrait(Attributes.DEXTERITY).setValue(1);
        c2.getTrait(Attributes.WITS).setValue(1);
        c2.getTrait(Skills.ATHLETICS).setValue(0);
    }

    private function getInitiativeMod():Int
    {
        var scene = Scene.create(system);
        var initiativeEvent = new InitiativeModifiersEvent(c1, scene.getInitiative());
        c1.getEventBus().post(initiativeEvent);

        return initiativeEvent.getModifier();
    }

    public function testApplyInitiativeMod()
    {
        assertEquals(2, this.getInitiativeMod());

        var weaponTrait:HeldWeapon = cast c1.getTrait(HeldWeapon.TYPE);

        weaponTrait.setMainHand(GENERIC_MELEE_WEAPON.createWeapon(system));
        assertEquals(0, this.getInitiativeMod());

        weaponTrait.setOffHand(GENERIC_MELEE_WEAPON.createWeapon(system));
        assertEquals(-1, this.getInitiativeMod());

        weaponTrait.setMainHand(null);
        assertEquals(0, this.getInitiativeMod());

        weaponTrait.setOffHand(null);
        assertEquals(2, this.getInitiativeMod());
    }

    public function methodTestWeaponPool(weapon:WeaponPrefab, pool:Array<String>)
    {
        var weaponTrait:HeldWeapon = cast(c1.getTrait(HeldWeapon.TYPE));
        weaponTrait.setMainHand(weapon.createWeapon(system));

        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        var traits = action.getCompetition().getPool(c1).getRequest().getTraits();
        assertEquals(Std.string(pool), Std.string(traits));

        return action;
    }

    public function testMeleeWeaponPool()
    {
        this.methodTestWeaponPool(GENERIC_MELEE_WEAPON, [Attributes.STRENGTH.getDN(), Skills.WEAPONRY.getDN()]);
    }

    public function testRangedWeaponPool()
    {
        var action = this.methodTestWeaponPool(GENERIC_RANGED_WEAPON, [Attributes.DEXTERITY.getDN(), Skills.SHOOTING.getDN()]);

        var traits = action.getCompetition().getPool(c2).getRequest().getTraits();
        assertEquals(Std.string([]), Std.string(traits));
    }

    public function testMeleeWeaponPoolIsRemovedWhenWeaponRemoved()
    {
        var heldWeapon:HeldWeapon = cast(c1.getTrait(HeldWeapon.TYPE));
        heldWeapon.setMainHand(GENERIC_MELEE_WEAPON.createWeapon(system));
        heldWeapon.setMainHand(null);

        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        var traits = action.getCompetition().getPool(c1).getRequest().getTraits();
        assertEquals(Std.string([Attributes.STRENGTH.getDN(), Skills.BRAWL.getDN()]), Std.string(traits));
    }

    public function testWeaponHand()
    {
        var heldWeapon:HeldWeapon = cast(c1.getTrait(HeldWeapon.TYPE));
        heldWeapon.setOffHand(GENERIC_MELEE_WEAPON.createWeapon(system));

        var action = new AttackBuilder(c1, c2).build();
        system.act(action);
        var traits = action.getCompetition().getPool(c1).getRequest().getTraits();
        assertEquals(Std.string([Attributes.STRENGTH.getDN(), Skills.BRAWL.getDN()]), Std.string(traits));

        var action = new AttackBuilder(c1, c2).setHand(EnumSide.ACTOR, EnumHand.OFFHAND).build();
        system.act(action);
        var traits = action.getCompetition().getPool(c1).getRequest().getTraits();
        assertEquals(Std.string([Attributes.STRENGTH.getDN(), Skills.WEAPONRY.getDN()]), Std.string(traits));
    }
}
