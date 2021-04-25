package pw.tales.cofdsystem.character.traits.attribute;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTraitType;

class AttributeType extends ValueTraitType<Attribute> {
    private final purpose:AttributePurpose;
    private final group:AttributeGroup;

    public function new(dn:String, purpose:AttributePurpose, group:AttributeGroup) {
        super(dn);
        this.purpose = purpose;
        this.group = group;
    }

    public function getPurpose():AttributePurpose {
        return this.purpose;
    }

    public function getGroup():AttributeGroup {
        return this.group;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):Attribute {
        return new Attribute(gameObject, this);
    }
}
