package pw.tales.cofdsystem.game_object.traits.text;

@:expose("TextTraitType")
class TextTraitType extends TraitType<TextTrait>
{
    override public dynamic function createWithDN(dn:String, gameObject:GameObject):TextTrait
    {
        return new TextTrait(dn, gameObject, this);
    }
}
