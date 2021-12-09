package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.common.traits.advantages.IAdvantage;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTrait;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTraitType;

@RegisterTraitTypes
@:expose("IntegrityAdvantage")
class IntegrityAdvantage extends ValueTrait implements IAdvantage
{
    public static final DN = "Целостность";
    public static final TYPE = ValueTraitType.createType(DN, IntegrityAdvantage.new);

    public static final DEFAULT = 7;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:ValueTraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, DEFAULT);
    }
}
