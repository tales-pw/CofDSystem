package pw.tales.cofdsystem.character.traits.skill.events;

import pw.tales.cofdsystem.game_object.events.CollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

class SkillGroupCollectEvent extends CollectEvent<Skill>
{
    private final group:SkillGroup;

    public function new(gameObject:GameObject, group:SkillGroup)
    {
        super(gameObject);
        this.group = group;
    }

    public function getGroup():SkillGroup
    {
        return this.group;
    }
}
