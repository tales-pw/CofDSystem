package pw.tales.cofdsystem.utils;

class EnumNamed
{
    private var name:String;

    public function new(name:String)
    {
        this.name = name;
    }

    public function getName():String
    {
        return this.name;
    }

    public function toString():String
    {
        return this.getName();
    }
}
