package pw.tales.cofdsystem.character.advancement.generation.trait_advancements;

import pw.tales.cofdsystem.character.advancement.generation.events.GenMeritCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

using Lambda;

class GenMeritGroupAdvancement<T:Trait, TY:TraitType<T>> extends GenAdvancementItem<T, TY>
{
    public static final MERIT_GENERATION_LIMIT = 10;

    public function new(traitClazz:Class<T>, traitTypeClazz:Class<TY>, gameObject:GameObject)
    {
        super(traitClazz, traitTypeClazz, gameObject);
    }

    private function collectMeritForGeneration(gameObject:GameObject)
    {
        var event = new GenMeritCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }

    private function calcualteMeritTotal()
    {
        var merits = this.collectMeritForGeneration(gameObject);

        var meritTotal = 0;
        for (trait in merits)
        {
            meritTotal += trait.getValue();
        }

        return meritTotal;
    }
}
