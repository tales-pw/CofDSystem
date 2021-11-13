package pw.tales.cofdsystem.game_object.trait_manager.exceptions;

import pw.tales.cofdsystem.game_object.exceptions.GameObjectException;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@:expose("WrongTypeException")
class WrongTypeException extends GameObjectException
{
    private final trait:Trait;
    private final expected:TraitType<Dynamic>;

    public function new(gameObject:GameObject, trait:Trait, expected:TraitType<Dynamic>)
    {
        super(gameObject, 'Attempted to get ${expected} with dn ${trait.getDN()} ' + 'but ${trait} has other type (${trait.getType()})');
        this.trait = trait;
        this.expected = expected;
    }
}
