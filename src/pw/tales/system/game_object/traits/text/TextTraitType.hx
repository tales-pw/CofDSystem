package pw.tales.system.game_object.traits.text;

class TextTraitType extends TraitType<TextTrait> {
    override public function create(gameObject:GameObject):TextTrait {
        return new TextTrait(this.getDN(), gameObject, this);
    }

    override public function createWithDN(dn:String, gameObject:GameObject):TextTrait {
        return this.create(gameObject);
    }
}
