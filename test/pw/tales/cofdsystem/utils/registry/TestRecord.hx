package pw.tales.cofdsystem.utils.registry;

class TestRecord implements IRecord
{
    public final dn:String;

    public function new(dn:String)
    {
        this.dn = dn;
    }

    public function getDN():String
    {
        return this.dn;
    }
}
