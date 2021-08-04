package pw.tales.cofdsystem.serialization.system;

import pw.tales.cofdsystem.utils.registry.IRecord;
import pw.tales.cofdsystem.serialization.system.SystemData;
import pw.tales.cofdsystem.utils.registry.Registry;
import thx.error.AbstractMethod;

class SystemSubSerializer<DATA: DnData, RESULT: IRecord> extends Serializer<DATA, RESULT> {
    private final system: CofDSystem;

    private function new(system: CofDSystem) {
        super();
        this.system = system;
    }

    private function getRecords(): Array<RESULT> throw new AbstractMethod();

    private function getRegistry(): Registry<RESULT> throw new AbstractMethod();

    public function load(map: Map<String, DATA>): Void {
        var registry = this.getRegistry();

        for (dn => data in map) {
            var record:Null<RESULT> = cast registry.getRecord(dn);
            if (record == null) {
                record = this.fromData(data);
                registry.register(record);
            } else {
                this.updateWithData(record, data);
            }
        }
    }

    public function dump(): Map<String, DATA> {
        var resultData = new Map<String, DATA>();
        for (value in this.getRecords()) {
            var data = this.toData(value);
            resultData.set(data.dn, data);
        }
        return resultData;
    }
}