package pw.tales.cofdsystem.character.traits;

import pw.tales.cofdsystem.armor.Armor;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("WornArmor")
class WornArmor extends Trait
{
    public static final DN = "worn_armor";
    public static final TYPE = TraitType.createType(DN, WornArmor.new);

    private var armor:Null<Armor> = null;

    public function setArmor(armor:Null<Armor>):Void
    {
        if (this.armor != null)
            this.armor.unsetHolder();

        this.armor = armor;

        if (this.armor != null)
            this.armor.setHolder(this.gameObject);
    }

    public function getArmor():Null<Armor>
    {
        return armor;
    }
}
