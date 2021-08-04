package pw.tales.cofdsystem.action_attack.targets;

interface ITarget
{
    function getDN():String;

    function getAttackModifer():Int;

    function apply(action:AttackAction):Void;
}
