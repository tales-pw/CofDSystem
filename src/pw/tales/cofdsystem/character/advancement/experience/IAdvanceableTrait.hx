package pw.tales.cofdsystem.character.advancement.experience;

interface IAdvanceableTrait
{
    function getCost(newValue:Int):Null<Int>;

    function getWorth():Null<Int>;
}
