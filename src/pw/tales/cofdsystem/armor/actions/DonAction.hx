package pw.tales.cofdsystem.armor.actions;

import pw.tales.cofdsystem.action.EnumTime;
import pw.tales.cofdsystem.action.NoRollAction;
import pw.tales.cofdsystem.character.traits.WornArmor;
import pw.tales.cofdsystem.game_object.GameObject;

class DonAction extends NoRollAction {
    private final armor:Null<Armor>;

    public function new(actor:GameObject, armor:Null<Armor>, system:CofDSystem) {
        super(actor, EnumTime.EXTENDED, system);
        this.armor = armor;
    }

    override public function perform():Void {
        var trait = actor.getTrait(WornArmor.TYPE);
        trait.setArmor(this.armor);
    }
}
