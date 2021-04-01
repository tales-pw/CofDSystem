package pw.tales.system.scene.initiative.exceptions;

class ParticipantNotFoundException extends InitiativeException {
    public function new(dn:String) {
        super('${dn} is not found in initiative.');
    }
}
