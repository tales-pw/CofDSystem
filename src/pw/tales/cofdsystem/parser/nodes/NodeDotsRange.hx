package pw.tales.cofdsystem.parser.nodes;

class NodeDotsRange implements INodeLevels
{
    private var start:NodeDots;
    private var end:NodeDots;

    public function new(start:NodeDots, end:NodeDots)
    {
        this.start = start;
        this.end = end;
    }

    public function getHumanReadable():String
    {
        var left_str = start.getHumanReadable();
        var right_str = end.getHumanReadable();

        return 'от $left_str до $right_str';
    }

    public function getLevels():Array<Int>
    {
        return [for (i in start.getValue()...end.getValue() + 1) i];
    }

    public function toString():String
    {
        return 'NodeDotsRange[${this.start},${this.end}}]';
    }

    public static function create(start:Int, end:Int)
    {
        return new NodeDotsRange(new NodeDots(start), new NodeDots(end));
    }
}
