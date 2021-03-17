package pw.tales.system.character.advancement.generation;

import pw.tales.system.game_object.events.TraitAddEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.game_object.traits.value_trait.events.ValueTraitUpdateEvent;
import pw.tales.system.utils.Utility;
import thx.error.AbstractMethod;

class GenAdvancementItem<T:Trait, TY:TraitType<T>> {
    private final gameObject:GameObject;
    private final traitClazz:Class<T>;
    private final traitTypeClazz:Class<TY>;

    public function new(traitClazz:Class<T>, traitTypeClazz:Class<TY>, gameObject:GameObject) {
        this.gameObject = gameObject;
        this.traitClazz = traitClazz;
        this.traitTypeClazz = traitTypeClazz;
    }

    public function canTraitBeAdded(traitType:TY):Bool throw new AbstractMethod();

    public function canTraitBeUpdated(trait:T, newValue:Int):Bool throw new AbstractMethod();

    public function canBeAdded(event:TraitAddEvent) {
        var traitType:Null<TY> = Utility.downcast(event.getTraitType(), this.traitTypeClazz);
        if (traitType == null) return;

        if (!canTraitBeAdded(traitType)) event.setCancelled(true);
    }

    public function canBeUpdated(event:ValueTraitUpdateEvent) {
        var trait:Null<T> = Utility.downcast(event.getTrait(), this.traitClazz);
        if (trait == null) return;

        if (!canTraitBeUpdated(trait, event.getNewValue())) event.setCancelled(true);
    }
}
