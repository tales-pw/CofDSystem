package pw.tales.system.character.traits.skill;

import pw.tales.system.game_object.events.traits.TraitPostEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.character.traits.skill.events.SkillCollectEvent;
import pw.tales.system.character.traits.skill.events.SkillGroupCollectEvent;
import pw.tales.system.character.traits.speciality.Speciality;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.value_trait.ValueTrait;
import pw.tales.system.utils.events.IEvent;

@:keep
@:expose("Skill")
class Skill extends ValueTrait {
    public function new(gameObject:GameObject, type:SkillType) {
        super(type.getDN(), gameObject, type, 0);

        this.eventBus.addHandler(SkillCollectEvent, (e:SkillCollectEvent) -> e.collect(this));
        this.eventBus.addHandler(SkillGroupCollectEvent, (e:SkillGroupCollectEvent) -> {
            if (e.getGroup() == type.getGroup()) e.collect(this);
        });
    }

    private function isSkillSpeciality(v:Trait) {
        var speciality:Null<Speciality> = Std.downcast(v, Speciality);
        if (speciality == null) return false;
        return speciality.getSkill() == this;
    }

    override public function shouldUpdateView(event:IEvent):Bool {
        var result = super.shouldUpdateView(event);
        if (result) return result;

        var traitEvent:TraitPostEvent = Std.downcast(event, TraitPostEvent);
        if (traitEvent == null) return false;

        return this.isSkillSpeciality(traitEvent.getTrait());
    }

    public function getSpecialities():Array<Speciality> {
        return cast this.gameObject.getTraitManager().getTraits().items().filter(this.isSkillSpeciality);
    }
}
