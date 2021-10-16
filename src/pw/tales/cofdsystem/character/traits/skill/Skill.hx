package pw.tales.cofdsystem.character.traits.skill;

import pw.tales.cofdsystem.game_object.events.traits.TraitPostEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.skill.events.SkillCollectEvent;
import pw.tales.cofdsystem.character.traits.skill.events.SkillGroupCollectEvent;
import pw.tales.cofdsystem.character.traits.speciality.Speciality;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTrait;
import pw.tales.cofdsystem.utils.events.IEvent;

@:expose("Skill")
class Skill extends ValueTrait
{
    public function new(dn:String, gameObject:GameObject, type:SkillType)
    {
        super(dn, gameObject, type, 0);

        this.eventBus.addHandler(SkillCollectEvent, this.collect);
        this.eventBus.addHandler(SkillGroupCollectEvent, (e:SkillGroupCollectEvent) ->
        {
            if (e.getGroup() == type.getGroup())
                this.collect(e);
        });
    }

    private function isSkillSpeciality(trait:Trait):Bool
    {
        var speciality:Null<Speciality> = Std.downcast(trait, Speciality);
        if (speciality == null)
            return false;
        return speciality.getSkill() == this;
    }

    override public function shouldUpdateView(event:IEvent):Bool
    {
        var result = super.shouldUpdateView(event);
        if (result)
            return result;

        var traitEvent:TraitPostEvent = Std.downcast(event, TraitPostEvent);
        if (traitEvent == null)
            return false;

        return this.isSkillSpeciality(traitEvent.getTrait());
    }

    public function getSpecialities():Array<Speciality>
    {
        return cast this.gameObject.getTraitManager().getTraits().items().filter(this.isSkillSpeciality);
    }
}
