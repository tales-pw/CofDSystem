package pw.tales.cofdsystem.character.traits.position;

@:expose("Position")
class Position
{
    public var x:Int;
    public var y:Int;
    public var z:Int;

    public function new(x:Int, y:Int, z:Int)
    {
        this.x = x;
        this.y = y;
        this.z = z;
    }
}
