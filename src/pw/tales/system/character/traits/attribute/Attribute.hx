package pw.tales.system.character.traits.attribute;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.value_trait.ValueTrait;

@:expose("Attribute")
class Attribute extends ValueTrait {
    public static final STARTING_VALUE = 1;

    private final attributeType:AttributeType;

    public function new(gameObject:GameObject, type:AttributeType) {
        super(type.getDN(), gameObject, type, STARTING_VALUE);
        this.attributeType = type;
    }

    public override function getType():AttributeType {
        return this.attributeType;
    }
}
