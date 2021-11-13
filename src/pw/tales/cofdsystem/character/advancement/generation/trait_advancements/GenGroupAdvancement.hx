package pw.tales.cofdsystem.character.advancement.generation.trait_advancements;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTrait;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTraitType;
import pw.tales.cofdsystem.utils.Utility;
import thx.error.AbstractMethod;

using pw.tales.cofdsystem.utils.Utility;

@:expose("GenGroupAdvancement<T:ValueTrait,")
class GenGroupAdvancement<T:ValueTrait, TY:ValueTraitType<T>> extends GenAdvancementItem<T, TY>
{
    private final freebuys:Array<Int>;

    public function new(traitClazz:Class<T>, traitTypeClazz:Class<TY>, gameObject:GameObject, freebuys:Array<Int>)
    {
        super(traitClazz, traitTypeClazz, gameObject);
        this.freebuys = freebuys;
    }

    public function getGroup(traitType:TY):String
        throw new AbstractMethod();

    public function getMinValue():Int
        throw new AbstractMethod();

    private function calcualteGroupSpent():Map<Dynamic, Int>
    {
        var groupValues = new Map<String, Int>();

        for (trait in this.gameObject.getTraitManager().getTraits().items())
        {
            var traitType:Null<TY> = cast(Utility.downcast(trait.getType(), this.traitTypeClazz));
            if (traitType == null)
                continue;

            var group = this.getGroup(traitType);

            var currentValue = groupValues.get(group);
            if (currentValue == null)
                currentValue = 0;
            groupValues[group] = currentValue + trait.getValue() - this.getMinValue();
        }

        return groupValues;
    }

    public override function canTraitBeAdded(traitType:TY):Bool
    {
        return true;
    }

    public override function canTraitBeUpdated(trait:T, newValue:Int):Bool
    {
        if (newValue < this.getMinValue())
            return false;

        var traitType:Null<TY> = Utility.downcast(trait.getType(), this.traitTypeClazz);
        if (traitType == null)
            return false;

        var traitGroup = this.getGroup(traitType);
        var groupSpentMap = this.calcualteGroupSpent();

        var traitGroupSpent = groupSpentMap.get(traitGroup);
        if (traitGroupSpent == null)
            traitGroupSpent = 0;

        // Filter claimed freebuys and store who clamed them
        var availableFreebuys:Array<Int> = freebuys.copy();
        var claimedFreebuys:Map<String, Int> = new Map<String, Int>();

        for (item in groupSpentMap.sortedItems())
        {
            var first = availableFreebuys[0];
            var second = 0;
            if (availableFreebuys.length > 0)
                second = availableFreebuys[1];

            if (item.value > second)
            {
                claimedFreebuys.set(item.key, first);
                availableFreebuys.remove(first);
            }
        }

        // Pick freebuy for tested trait group
        var targetedFreebuy:Int = traitGroupSpent;
        if (claimedFreebuys.exists(traitGroup))
        {
            targetedFreebuy = cast(claimedFreebuys.get(traitGroup));
        } else if (availableFreebuys.length > 0)
        {
            var biggestFreebuy = availableFreebuys[0];
            if (targetedFreebuy <= biggestFreebuy)
                targetedFreebuy = biggestFreebuy;
        }

        // Check if new value will take more freebuy than given. Reject change if true.
        return traitGroupSpent - trait.getValue() + newValue <= targetedFreebuy;
    }
}
