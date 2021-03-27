package pw.tales.system.character.traits.speciality;

import pw.tales.system.character.traits.skill.Skill;
import pw.tales.system.character.traits.speciality.events.SpecialitiesCollectEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;

@:keep
@autoregister
@:expose("Speciality")
class Speciality extends Trait {
    public static final DN = "Специализация";
    public static final TYPE:TraitType<Speciality> = cast TraitType.createType(DN, create).setMultiInstanced(true);

    @Serialize("name")
    private var name:String = "";

    @Serialize("skill")
    private var skillDn:String = "";

    @overload public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>) {
        super(dn, gameObject, type);
        this.eventBus.addHandler(SpecialitiesCollectEvent, (e:SpecialitiesCollectEvent) -> e.collect(this));
    }

    public function getName() {
        return name;
    }

    public function setName(name:String) {
        this.name = name;
        this.notifyUpdated();
    }

    public function setSkill(skill:Skill) {
        this.skillDn = skill.getDN();
        this.notifyUpdated();
    }

    public function getSkill():Skill {
        return cast this.gameObject.getTraitManager().getTraitByDn(this.skillDn);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<Speciality>):Speciality {
        return new Speciality(dn, gameObject, t);
    }
}
