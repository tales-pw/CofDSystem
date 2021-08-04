package pw.tales.cofdsystem.scene.initiative.exceptions;

class ParticipantNotFoundException extends InitiativeException
{
    public function new(dn:String)
    {
        super('${dn} is not found in initiative.');
    }
}
