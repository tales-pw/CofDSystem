package pw.tales.cofdsystem.character.advancement.generation;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.character.advancement.generation.trait_advancements.GenAttributeAdvancement;
import pw.tales.cofdsystem.character.advancement.generation.trait_advancements.GenMeritAdvancement;
import pw.tales.cofdsystem.character.advancement.generation.trait_advancements.GenSkillAdvancement;
import pw.tales.cofdsystem.character.advancement.generation.trait_advancements.GenSpecialityAdvancement;
import pw.tales.cofdsystem.character.advancement.generation.trait_advancements.GenWealthAdvancement;
import pw.tales.cofdsystem.game_object.events.TraitAddEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.GameObjectState;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;

@:expose("GenAdvancement")
class GenAdvancement extends AdvancementTrait
{
    public static final DN = "generation_advancement";
    public static final TYPE = TraitType.createType(DN, GenAdvancement.new);

    public var restrictions:Array<GenAdvancementItem<Dynamic, Dynamic>> = [];

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);

        restrictions.push(new GenAttributeAdvancement(gameObject));
        restrictions.push(new GenSkillAdvancement(gameObject));
        restrictions.push(
            new GenSpecialityAdvancement(gameObject)
        );
        restrictions.push(new GenMeritAdvancement(gameObject));
        restrictions.push(new GenWealthAdvancement(gameObject));
    }

    public override function canBeAdded(event:TraitAddEvent):Void
    {
        if (this.gameObject.getState() != GameObjectState.ACTIVE)
            return;

        for (restriction in this.restrictions)
        {
            if (event.isCancelled())
                return;
            restriction.canBeAdded(event);
        }
    }

    public override function canBeUpdated(event:ValueTraitUpdateEvent):Void
    {
        if (this.gameObject.getState() != GameObjectState.ACTIVE)
            return;

        for (restriction in this.restrictions)
        {
            if (event.isCancelled())
                return;
            restriction.canBeUpdated(event);
        }
    }
}
