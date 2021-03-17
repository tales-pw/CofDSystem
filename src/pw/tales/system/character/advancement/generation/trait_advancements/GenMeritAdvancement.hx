package pw.tales.system.character.advancement.generation.trait_advancements;

import pw.tales.system.character.traits.merits.Merit;
import pw.tales.system.character.traits.merits.MeritType;
import pw.tales.system.game_object.GameObject;

class GenMeritAdvancement extends GenMeritGroupAdvancement<Merit, MeritType> {
    public function new(gameObject:GameObject) {
        super(Merit, MeritType, gameObject);
    }

    public override function canTraitBeAdded(meritType:MeritType):Bool {
        var newValue = meritType.getLowestValue();
        var meritTotal = this.calcualteMeritTotal();

        return meritTotal + newValue <= GenMeritGroupAdvancement.MERIT_GENERATION_LIMIT;
    }

    public override function canTraitBeUpdated(merit:Merit, newValue:Int):Bool {
        var meritTotal = this.calcualteMeritTotal();

        return meritTotal - merit.getValue() + newValue <= GenMeritGroupAdvancement.MERIT_GENERATION_LIMIT;
    }
}
