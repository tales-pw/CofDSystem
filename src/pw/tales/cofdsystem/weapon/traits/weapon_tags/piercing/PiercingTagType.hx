package pw.tales.cofdsystem.weapon.traits.weapon_tags.piercing;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class PiercingTagType extends TraitType<PiercingTag>
{
    private var level:Int;

    public function new(level:Int)
    {
        super('piercing_(${level})_(weapon_tag)');
        this.level = level;
    }

    public function getLevel():Int
    {
        return this.level;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):PiercingTag
    {
        return new PiercingTag(gameObject, this);
    }
}
