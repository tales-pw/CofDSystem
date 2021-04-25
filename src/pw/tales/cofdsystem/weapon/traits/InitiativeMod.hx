package pw.tales.cofdsystem.weapon.traits;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class InitiativeMod extends WeaponMod {
    public static final DN = "Свойство:Initiative";
    public static final TYPE:TraitType<InitiativeMod> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<InitiativeMod>):InitiativeMod {
        return new InitiativeMod(gameObject);
    }
}
