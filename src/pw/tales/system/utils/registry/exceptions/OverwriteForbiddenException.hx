package pw.tales.system.utils.registry.exceptions;

class OverwriteForbiddenException {
    private final dn:String;
    private final record:IRecord;
    private final newRecord:IRecord;

    public function new(dn:String, record:IRecord, newRecord:IRecord) {
        this.dn = dn;
        this.record = record;
        this.newRecord = newRecord;
    }

    public function toString():String {
        var className = Utility.getClassName(Type.getClass(this));
        return '${className}[dn=${dn},record=${record},new_record=${newRecord}]';
    }
}
