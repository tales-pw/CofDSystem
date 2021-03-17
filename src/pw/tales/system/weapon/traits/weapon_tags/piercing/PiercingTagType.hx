package pw.tales.system.weapon.traits.weapon_tags.piercing;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

class PiercingTagType extends TraitType<PiercingTag> {
    private var level:Int;

    public function new(level:Int) {
        super('piercing_(${level})_(weapon_tag)');
        this.level = level;
    }

    public function getLevel() {
        return this.level;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):PiercingTag {
        return new PiercingTag(gameObject, this);
    }
}