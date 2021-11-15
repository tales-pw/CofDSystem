package pw.tales.cofdsystem.parser.nodes;

@:expose("NodeDots")
class NodeDots extends NodeNumber implements INodeLevels
{
    override public function getHumanReadable():String
    {
        return [for (i in 0...this.number) "•"].join("");
    }

    public function getLevels():Array<Int>
    {
        return [number];
    }

    override public function toString():String
    {
        return 'NodeDots[${this.number}]';
    }
}
