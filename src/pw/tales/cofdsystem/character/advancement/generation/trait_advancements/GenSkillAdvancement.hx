package pw.tales.cofdsystem.character.advancement.generation.trait_advancements;

import pw.tales.cofdsystem.character.traits.skill.SkillType;
import pw.tales.cofdsystem.character.traits.skill.Skill;
import pw.tales.cofdsystem.game_object.GameObject;

class GenSkillAdvancement extends GenGroupAdvancement<Skill, SkillType> {
    private static final FREEBUYS:Array<Int> = [11, 7, 4];

    public function new(gameObject:GameObject) {
        super(Skill, SkillType, gameObject, FREEBUYS);
    }

    public override function getMinValue():Int {
        return 0;
    }

    public override function getGroup(traitType:SkillType):String {
        return traitType.getGroup().getName();
    }
}