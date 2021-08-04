package pw.tales.cofdsystem.action_attack.builder.exceptions;

import haxe.Exception;
import pw.tales.cofdsystem.exceptions.CofDSystemException;

/**
 * Abstract Exception for exception in attack builder action.
**/
class AttackBuilderException extends CofDSystemException
{
    private final attackBuilder:AttackBuilder;

    private function new(attackBuilder:AttackBuilder, msg:String, ?previous:Exception, ?native:Any)
    {
        super(msg, previous, native);
        this.attackBuilder = attackBuilder;
    }
}
