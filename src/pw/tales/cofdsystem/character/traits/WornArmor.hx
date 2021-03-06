package pw.tales.cofdsystem.character.traits;

import pw.tales.cofdsystem.armor.Armor;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("Armor")
class WornArmor extends Trait
{
    public static final DN = "worn_armor";
    public static final TYPE:TraitType<WornArmor> = cast TraitType.createType(DN, create);

    private var armor:Null<Armor> = null;

    public function new(gameObject:GameObject)
    {
        super(TYPE.getDN(), gameObject, TYPE);
    }

    public function setArmor(armor:Null<Armor>)
    {
        if (this.armor != null)
            this.armor.unsetHolder();

        if (armor != null)
        {
            armor.setHolder(this.gameObject);
            this.armor = armor;
        }
    }

    public function getArmor():Null<Armor>
    {
        return armor;
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<WornArmor>):WornArmor
    {
        return new WornArmor(gameObject);
    }
}
