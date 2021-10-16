package pw.tales.cofdsystem.game_object.traits.text;

class TextTraitType extends TraitType<TextTrait>
{
    override public function createWithDN(dn:String, gameObject:GameObject):TextTrait
    {
        return new TextTrait(dn, gameObject, this);
    }
}
