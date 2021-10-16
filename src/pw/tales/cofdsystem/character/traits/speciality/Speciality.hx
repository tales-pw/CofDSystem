package pw.tales.cofdsystem.character.traits.speciality;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.skill.Skill;
import pw.tales.cofdsystem.character.traits.speciality.events.SpecialitiesCollectEvent;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("Speciality")
class Speciality extends Trait
{
    public static final DN = "Специализация";
    public static final TYPE = TraitType.createType(DN, Speciality.new).setMultiInstanced(true);

    @Serialize("name")
    private var name:String = "";

    @Serialize("skill")
    private var skillDn:String = "";

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.eventBus.addHandler(SpecialitiesCollectEvent, this.collect);
    }

    public function getName():String
    {
        return name;
    }

    public function setName(name:String):Void
    {
        this.name = name;
        this.notifyUpdated();
    }

    public function getSkill():Skill
    {
        return cast this.gameObject.getTraitManager().getTraitByDn(this.skillDn);
    }

    public function setSkill(skill:Skill):Void
    {
        this.skillDn = skill.getDN();
        this.notifyUpdated();
    }
}
