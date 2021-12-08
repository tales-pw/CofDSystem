package pw.tales.cofdsystem.character.advancement.generation;

import pw.tales.cofdsystem.game_object.events.TraitAddEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;
import pw.tales.cofdsystem.utils.Utility;
import thx.error.AbstractMethod;

@:expose("GenAdvancementItem")
class GenAdvancementItem<T:Trait, TY:TraitType<T>>
{
    private final gameObject:GameObject;
    private final traitClazz:Class<T>;
    private final traitTypeClazz:Class<TY>;

    public function new(
        traitClazz:Class<T>,
        traitTypeClazz:Class<TY>,
        gameObject:GameObject
    )
    {
        this.gameObject = gameObject;
        this.traitClazz = traitClazz;
        this.traitTypeClazz = traitTypeClazz;
    }

    public function canTraitBeAdded(traitType:TY):Bool
        throw new AbstractMethod();

    public function canTraitBeUpdated(trait:T, newValue:Int):Bool
        throw new AbstractMethod();

    public function canBeAdded(event:TraitAddEvent):Void
    {
        var traitType:Null<TY> = Utility.downcast(event.getTraitType(), this.traitTypeClazz);
        if (traitType == null)
            return;

        if (!canTraitBeAdded(traitType))
            event.setCancelled(true);
    }

    public function canBeUpdated(event:ValueTraitUpdateEvent):Void
    {
        var trait:Null<T> = Utility.downcast(event.getTrait(), this.traitClazz);
        if (trait == null)
            return;

        if (!canTraitBeUpdated(trait, event.getNewValue()))
            event.setCancelled(true);
    }
}
