package pw.tales.cofdsystem.action_attack.builder;

import haxe.ds.StringMap;
import pw.tales.cofdsystem.action_attack.targets.Arm;
import pw.tales.cofdsystem.action_attack.targets.Eye;
import pw.tales.cofdsystem.action_attack.targets.Hand;
import pw.tales.cofdsystem.action_attack.targets.Head;
import pw.tales.cofdsystem.action_attack.targets.Heart;
import pw.tales.cofdsystem.action_attack.targets.ITarget;
import pw.tales.cofdsystem.action_attack.targets.Leg;
import pw.tales.cofdsystem.utils.EnumNamed;

@:expose("EnumSpecifiedTarget")
class EnumSpecifiedTarget extends EnumNamed
{
    public static final VALUES = new StringMap<EnumSpecifiedTarget>();

    public static final ARM = new EnumSpecifiedTarget(Arm.INSTANCE);
    public static final LEG = new EnumSpecifiedTarget(Leg.INSTANCE);
    public static final HEAD = new EnumSpecifiedTarget(Head.INSTANCE);
    public static final HEART = new EnumSpecifiedTarget(Heart.INSTANCE);
    public static final HAND = new EnumSpecifiedTarget(Hand.INSTANCE);
    public static final EYE = new EnumSpecifiedTarget(Eye.INSTANCE);

    private final target:ITarget;

    private function new(target:ITarget)
    {
        super(target.getDN());
        this.target = target;

        VALUES.set(this.getName(), this);
    }

    public static function byName(name:String):EnumSpecifiedTarget
    {
        var value = VALUES.get(name);
        if (value == null)
            throw "Wrong name";
        return value;
    }

    public function getTarget():ITarget
    {
        return this.target;
    }
}
