package pw.tales.cofdsystem.utils.registry.exceptions;

import pw.tales.cofdsystem.exceptions.CofDSystemException;

@:expose("OverwriteForbiddenException")
class OverwriteForbiddenException extends CofDSystemException
{
    private final dn:String;
    private final record:IRecord;
    private final newRecord:IRecord;

    public function new(dn:String, record:IRecord, newRecord:IRecord)
    {
        super(
            'Attempted to overwrite ${record} with ${newRecord}, which is forbidden.'
        );
        this.dn = dn;
        this.record = record;
        this.newRecord = newRecord;
    }
}
