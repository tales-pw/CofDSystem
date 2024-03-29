package pw.tales.cofdsystem.parser.nodes;

import pw.tales.cofdsystem.pool.builder.PBTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose("NodeTrait")
class NodeTrait implements INode implements INodePoolBuilder
{
    private var dn:String;

    public function new(dn:String)
    {
        this.dn = dn;
    }

    public function getHumanReadable():String
    {
        return '[[${dn}]]';
    }

    public function getValue():String
    {
        return dn;
    }

    public function build(gameObject:GameObject):IMathOperation<Int>
    {
        var traitType = gameObject.getSystem().traits.getRecord(this.dn);
        return new PBTrait(traitType).build(gameObject);
    }

    public function toString():String
    {
        return 'NodeTrait[${this.dn}]';
    }
}
