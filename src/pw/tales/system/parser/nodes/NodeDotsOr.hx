package pw.tales.system.parser.nodes;

class NodeDotsOr implements INodeLevels {
    private var left:INodeLevels;
    private var right:INodeLevels;

    public function new(left:INodeLevels, right:INodeLevels) {
        this.left = left;
        this.right = right;
    }

    public function getHumanReadable():String {
        var left_str = left.getHumanReadable();
        var right_str = right.getHumanReadable();

        return '$left_str или $right_str';
    }

    public function getLevels():Array<Int> {
        return left.getLevels().concat(right.getLevels());
    }

    public function toString():String {
        return 'NodeDotsOr[${this.left},${this.right}]';
    }
}
