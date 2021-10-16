package pw.tales.cofdsystem.character.traits.aspiration;

import pw.tales.cofdsystem.character.traits.aspiration.events.AspirationsCollectEvent;
import pw.tales.cofdsystem.character.traits.Experience;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.text.TextTrait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@:expose("Aspiration")
class Aspiration extends TextTrait
{
    @Optional
    @Serialize("description")
    private var description:String = "";

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.eventBus.addHandler(AspirationsCollectEvent, (e:AspirationsCollectEvent) -> e.collect(this));
    }

    public function setTitle(title:String):Void
    {
        this.setText(title);
    }

    public function getTitle():String
    {
        return this.getText();
    }

    public function setDescription(description:String):Void
    {
        this.description = description;
        notifyUpdated();
    }

    public function getDescription():String
    {
        return this.description;
    }

    public function accomplish():Void
    {
        var experience = gameObject.getTrait(Experience.TYPE);
        experience.grantBeat();

        var manager = gameObject.getTraitManager();
        manager.removeTrait(this);
    }
}
