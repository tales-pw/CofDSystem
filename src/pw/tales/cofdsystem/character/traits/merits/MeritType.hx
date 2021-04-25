package pw.tales.cofdsystem.character.traits.merits;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTraitType;
import pw.tales.cofdsystem.parser.nodes.INodeCheck;
import pw.tales.cofdsystem.parser.nodes.INodeLevels;
import pw.tales.cofdsystem.parser.nodes.NodeAnd;
import pw.tales.cofdsystem.parser.nodes.NodeDotsRange;

@:expose("MeritType")
class MeritType extends ValueTraitType<Merit> {
    private var levels:INodeLevels = NodeDotsRange.create(1, 5);
    private var requirements:Null<INodeCheck> = null;

    public function new(dn:String) {
        super(dn);
    }

    public function getRequirements():Null<INodeCheck> {
        return this.requirements;
    }

    public function addRequirements(requirements:INodeCheck) {
        if (this.requirements == null) {
            this.requirements = requirements;
        } else {
            this.requirements = cast(new NodeAnd(this.requirements, requirements));
        }
    }

    public function setRequirements(requirement:INodeCheck) {
        this.requirements = requirement;
    }

    public function getLevels():INodeLevels {
        return this.levels;
    }

    public function setLevels(levels:INodeLevels) {
        this.levels = levels;
    }

    override public function isMultiInstanced():Bool {
        return true;
    }

    public override function getLowestValue() {
        return this.levels.getLevels()[0];
    }

    override public function createWithDN(dn:String, gameObject:GameObject):Merit {
        return new Merit(dn, gameObject, this);
    }
}
