package pw.tales.cofdsystem.character.traits.skill;

import pw.tales.cofdsystem.utils.EnumNamed;

@:expose("SkillGroup")
class SkillGroup extends EnumNamed {
    public static var VALUES = new Map<String, SkillGroup>();

    public static final MENTAL = new SkillGroup("mental", -3);
    public static final PHYSICAL = new SkillGroup("physical", -1);
    public static final SOCIAL = new SkillGroup("social", -1);

    private final penalty:Int;

    private function new(name:String, penalty:Int) {
        super(name);
        this.penalty = penalty;
        VALUES.set(name, this);
    }

    public function getPenalty():Int {
        return this.penalty;
    }

    public static function byName(name:String):SkillGroup {
        var value = VALUES.get(name);
        if (value == null) throw "Wrong name";
        return value;
    }
}