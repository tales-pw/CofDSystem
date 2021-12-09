package pw.tales.cofdsystem.game_object.traits.unknown_trait;

@:expose("UnknownType")
class UnknownType extends TraitType<UnknownTrait>
{
    override public function isMultiInstanced():Bool
    {
        return true;
    }

    override public dynamic function createWithDN(dn:String, gameObject:GameObject):UnknownTrait
    {
        return new UnknownTrait(dn, gameObject);
    }
}
