package pw.tales.system.character.traits.skill.events;

import pw.tales.system.game_object.events.CollectEvent;
import pw.tales.system.game_object.GameObject;

class SkillGroupCollectEvent extends CollectEvent<Skill> {
    private final group:SkillGroup;

    public function new(gameObject:GameObject, group:SkillGroup) {
        super(gameObject);
        this.group = group;
    }

    public function getGroup():SkillGroup {
        return this.group;
    }
}
