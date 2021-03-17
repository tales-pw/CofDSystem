package pw.tales.system.armor.actions;

import pw.tales.system.action.EnumTime;
import pw.tales.system.action.NoRollAction;
import pw.tales.system.character.traits.WornArmor;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.scene.Scene;

class DonAction extends NoRollAction {
    private final armor:Null<Armor>;

    public function new(actor:GameObject, armor:Null<Armor>) {
        super(actor, EnumTime.EXTENDED);
        this.armor = armor;
    }

    override public function execute(system:CofDSystem, scene:Null<Scene> = null):Void {
        var trait:WornArmor = cast(actor.getTraitManager().getTrait(WornArmor.TYPE));
        trait.setArmor(this.armor);
    }
}
