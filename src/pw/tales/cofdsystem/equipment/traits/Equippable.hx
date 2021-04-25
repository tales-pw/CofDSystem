package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class Equippable extends Trait {
    public static final DN = "Equippable";
    public static final TYPE:TraitType<Equippable> = cast TraitType.createType(DN, create);

    private var holder:Null<GameObject> = null;

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
    }

    public function setHolder(holder:GameObject) {
        this.holder = holder;
        this.notifyUpdated();
    }

    public function getHolder():Null<GameObject> {
        return this.holder;
    }

    public function unset() {
        this.holder = null;
        this.notifyUpdated();
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<Equippable>):Equippable {
        return new Equippable(gameObject);
    }
}
