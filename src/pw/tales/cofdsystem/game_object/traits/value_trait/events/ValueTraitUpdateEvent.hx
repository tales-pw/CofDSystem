package pw.tales.cofdsystem.game_object.traits.value_trait.events;

import pw.tales.cofdsystem.game_object.events.traits.TraitPreUpdateEvent;

@:expose("ValueTraitUpdateEvent")
class ValueTraitUpdateEvent extends TraitPreUpdateEvent
{
    private final valueTrait:ValueTrait;
    private final newValue:Int;
    private final preview:Bool;

    public function new(trait:ValueTrait, newValue:Int, preview:Bool)
    {
        super(trait);
        this.valueTrait = trait;
        this.newValue = newValue;
        this.preview = preview;
    }

    public function isPreview():Bool
    {
        return this.preview;
    }

    public override function getTrait():ValueTrait
    {
        return this.valueTrait;
    }

    public function getNewValue():Int
    {
        return this.newValue;
    }
}
