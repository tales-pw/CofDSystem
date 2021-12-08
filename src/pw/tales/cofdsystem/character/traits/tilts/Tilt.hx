package pw.tales.cofdsystem.character.traits.tilts;

import pw.tales.cofdsystem.character.traits.tilts.events.TiltsCollectEvent;
import pw.tales.cofdsystem.utils.events.HandlerPriority;
import pw.tales.cofdsystem.scene.events.SceneEndEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@:expose("Tilt")
class Tilt extends Trait
{
    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);
        this.eventBus.addHandler(
            SceneEndEvent,
            this.onSceneEnd,
            HandlerPriority.NORMAL
        );
        this.eventBus.addHandler(TiltsCollectEvent, this.collect);
    }

    private function onSceneEnd(event:SceneEndEvent):Void
    {
        this.gameObject.getTraitManager().removeTrait(this);
    }
}
