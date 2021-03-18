package pw.tales.system.armor.actions;

import pw.tales.system.action.EnumTime;
import pw.tales.system.action.NoRollAction;
import pw.tales.system.character.traits.WornArmor;
import pw.tales.system.game_object.GameObject;

class DonAction extends NoRollAction {
    private final armor:Null<Armor>;

    public function new(actor:GameObject, armor:Null<Armor>, system:CofDSystem) {
        super(actor, EnumTime.EXTENDED, system);
        this.armor = armor;
    }

    override public function execute():Void {
        var trait:WornArmor = cast(actor.getTraitManager().getTrait(WornArmor.TYPE));
        trait.setArmor(this.armor);
    }
}
