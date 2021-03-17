package pw.tales.system.game_object.traits.unknown_trait;

class UnknownType extends TraitType<UnknownTrait> {
    override public function isMultiInstanced():Bool {
        return true;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):UnknownTrait {
        return new UnknownTrait(dn, gameObject);
    }
}
