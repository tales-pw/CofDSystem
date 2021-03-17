package pw.tales.system.character.traits.skill;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.value_trait.ValueTraitType;

class SkillType extends ValueTraitType<Skill> {
    private var group:SkillGroup;

    public function new(dn:String, group:SkillGroup) {
        super(dn);
        this.group = group;
    }

    public function getGroup():SkillGroup {
        return this.group;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):Skill {
        return new Skill(gameObject, this);
    }
}
