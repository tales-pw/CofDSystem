package pw.tales.cofdsystem.game_object.prefabs;

import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.game_object.prefabs.exceptions.NoTraitAccessorException;
import pw.tales.cofdsystem.game_object.traits.text.TextTraitType;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
    Common class for wrapping GameObject to implement simplified
    access to traits with getters. Mostly for traits added by prefabs.

    Rules to follow when implementing Accessor:
    1) Getters should dynamically get Trait object in case it will be
       removed from GameObject later.
    2) If there is no Trait in GameObject, getters should return
       default value or throw exception
       (usually subclass of NoTraitAccessorException).

    You may implement other logic in subclass (not just getter)
    but it should follow rules above

    Example of such class, getting character name:
    >>> new Character(gameObject).getName()
**/
@:expose("Accessor")
class Accessor
{
    private final gameObject:GameObject;

    private function new(gameObject:GameObject)
    {
        this.gameObject = gameObject;
    }

    private function getTrait<T:Trait>(type:TraitType<T>):T
    {
        var trait = this.gameObject.getTrait(type);
        if (trait == null)
            throw new NoTraitAccessorException(this.gameObject, type);
        return trait;
    }

    private function getText(type:TextTraitType):String
    {
        var textTrait = this.gameObject.getTrait(type);
        if (textTrait == null)
            return "";
        return textTrait.getText();
    }

    private function getInt(type:TraitType<Dynamic>):Int
    {
        var intTrait:Null<Trait> = this.gameObject.getTrait(type);
        if (intTrait == null)
            return 0;
        return intTrait.getValue();
    }

    public function getGameObject():GameObject
    {
        return this.gameObject;
    }

    public function equals(other:Null<Dynamic>):Bool
    {
        if (this == other)
        {
            return true;
        }

        var clazz = Type.getClass(this);
        var otherAccessor:Null<Accessor> = Utility.downcast(other, clazz);

        if (otherAccessor == null)
        {
            return false;
        }

        return this.getGameObject() == otherAccessor.getGameObject();
    }
}
