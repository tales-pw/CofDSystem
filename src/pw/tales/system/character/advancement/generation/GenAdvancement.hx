package pw.tales.system.character.advancement.generation;

import pw.tales.system.character.advancement.generation.GenAdvancementItem;
import pw.tales.system.character.advancement.generation.trait_advancements.GenAttributeAdvancement;
import pw.tales.system.character.advancement.generation.trait_advancements.GenMeritAdvancement;
import pw.tales.system.character.advancement.generation.trait_advancements.GenSkillAdvancement;
import pw.tales.system.character.advancement.generation.trait_advancements.GenSpecialityAdvancement;
import pw.tales.system.character.advancement.generation.trait_advancements.GenWealthAdvancement;
import pw.tales.system.game_object.events.TraitAddEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.GameObjectState;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.game_object.traits.value_trait.events.ValueTraitUpdateEvent;

@:expose("GenAdvancement")
class GenAdvancement extends Trait {
    public static final DN = "generation_advancement";
    public static final TYPE:TraitType<GenAdvancement> = new GenAdvancementType(DN);

    public var restrictions:Array<GenAdvancementItem<Dynamic, Dynamic>> = [];

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        restrictions.push(new GenAttributeAdvancement(gameObject));
        restrictions.push(new GenSkillAdvancement(gameObject));
        restrictions.push(new GenSpecialityAdvancement(gameObject));
        restrictions.push(new GenMeritAdvancement(gameObject));
        restrictions.push(new GenWealthAdvancement(gameObject));

        this.eventBus.addHandler(TraitAddEvent, this.canBeAdded);
        this.eventBus.addHandler(ValueTraitUpdateEvent, this.canBeUpdated);
    }

    public function canBeAdded(event:TraitAddEvent) {
        if (this.gameObject.getState() != GameObjectState.ACTIVE) return;

        for (restriction in this.restrictions) {
            if (event.isCancelled()) return;
            restriction.canBeAdded(event);
        }
    }

    public function canBeUpdated(event:ValueTraitUpdateEvent) {
        if (this.gameObject.getState() != GameObjectState.ACTIVE) return;

        for (restriction in this.restrictions) {
            if (event.isCancelled()) return;
            restriction.canBeUpdated(event);
        }
    }
}
