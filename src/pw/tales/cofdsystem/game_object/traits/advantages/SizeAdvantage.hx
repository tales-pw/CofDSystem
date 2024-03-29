package pw.tales.cofdsystem.game_object.traits.advantages;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("SizeAdvantage")
class SizeAdvantage extends AdvantageValue
{
    public static final DN = "Размер";
    public static final TYPE = TraitType.createType(DN, SizeAdvantage.new);

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, 5);
    }
}
