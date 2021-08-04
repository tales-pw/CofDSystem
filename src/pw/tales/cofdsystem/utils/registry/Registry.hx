package pw.tales.cofdsystem.utils.registry;

import pw.tales.cofdsystem.utils.registry.exceptions.OverwriteForbiddenException;

@:nullSafety(Off)
class Registry<T:IRecord>
{
    private var registry:Map<String, T>;

    private var normalize:Bool;
    private var allowOverwrite:Bool;

    public function new(normalize:Bool = false, allowOverwrite:Bool = false)
    {
        this.registry = new Map();
        this.normalize = normalize;
        this.allowOverwrite = allowOverwrite;
    }

    private function normalizeDn(dn:String):String
    {
        return StringTools.replace(dn.toLowerCase(), " ", "_");
    }

    private function getDN(record:T):String
    {
        var dn = record.getDN();
        if (this.normalize)
            dn = normalizeDn(dn);
        return dn;
    }

    public function getRecord(dn:String):T
    {
        if (this.normalize)
            dn = normalizeDn(dn);
        return this.registry.get(dn);
    }

    private function saveRecord(record:T)
    {
        var dn = this.getDN(record);

        if (this.registry.exists(dn) && !this.allowOverwrite)
        {
            throw new OverwriteForbiddenException(dn, this.registry[dn], record);
        }

        this.registry[dn] = record;
    }

    public function register(record:T):Registry<T>
    {
        this.saveRecord(record);
        return this;
    }

    public function unregister(record:T)
    {
        var dn = this.getDN(record);
        this.registry.remove(dn);
    }

    public function items():Array<T>
    {
        return [for (value in this.registry) value];
    }

    public function clear()
    {
        this.registry.clear();
    }

    public function toString():String
    {
        return 'Registry[${this.registry}}]';
    }
}
