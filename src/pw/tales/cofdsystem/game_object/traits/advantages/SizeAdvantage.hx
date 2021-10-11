package pw.tales.cofdsystem.game_object.traits.advantages;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageConstant;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("SizeAdvantage")
class SizeAdvantage extends AdvantageConstant
{
    public static final DN = "Размер";
    public static final TYPE:TraitType<SizeAdvantage> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(gameObject, TYPE, 5);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<SizeAdvantage>):SizeAdvantage
    {
        return new SizeAdvantage(gameObject);
    }
}
