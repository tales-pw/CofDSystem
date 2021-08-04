package pw.tales.cofdsystem.action_attack.builder.exceptions;

/**
 * Exception for situation where you try to use willpower while you can't.
**/
class NoWillpowerBuilderException extends AttackBuilderException
{
    public function new(attackBuilder:AttackBuilder)
    {
        super(attackBuilder, "Can't use willpower.");
    }
}
