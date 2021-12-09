package pw.tales.cofdsystem.character.traits.skill;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTraitType;

@:expose("SkillType")
class SkillType extends ValueTraitType<Skill>
{
    private var group:SkillGroup;

    public function new(dn:String, group:SkillGroup)
    {
        super(dn);
        this.group = group;
    }

    public function getGroup():SkillGroup
    {
        return this.group;
    }

    override public dynamic function createWithDN(dn:String, gameObject:GameObject):Skill
    {
        return new Skill(dn, gameObject, this);
    }
}
