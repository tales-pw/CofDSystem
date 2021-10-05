package pw.tales.cofdsystem.action_attack.builder.exceptions;

import haxe.Exception;
import pw.tales.cofdsystem.exceptions.CofDSystemException;

/**
 * Abstract Exception for exception in attack builder action.
**/
class AttackBuilderException extends CofDSystemException
{
    private final attackBuilder:AttackBuilder;

    private function new(attackBuilder:AttackBuilder, msg:String, previous:Null<Exception> = null, native:Null<Any> = null)
    {
        super(msg, previous, native);
        this.attackBuilder = attackBuilder;
    }
}
