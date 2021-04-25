package pw.tales.cofdsystem.game_object.traits.value_trait;

import pw.tales.cofdsystem.character.advancement.experience.IAdvanceableType;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class ValueTraitType<T:ValueTrait> extends TraitType<T> implements IAdvanceableType {
    private var dotCost:Null<Int> = null;

    public function getLowestValue():Int {
        return 0;
    }

    public function getDotCost():Null<Int> {
        return this.dotCost;
    }

    public function getCreateCost():Null<Int> {
        if (this.dotCost == null) return null;
        return this.getLowestValue() * this.dotCost;
    }
}
