package pw.tales.system.character.traits.position;

import pw.tales.system.character.traits.position.PositionProvider;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.Trait;

@autoregister
@:expose("PositionTrait")
class PositionTrait extends Trait {
    public static final DN = "position";
    public static final TYPE:PositionType = new PositionType(DN);

    private var provider:Null<PositionProvider> = null;

    public function new(gameObject:GameObject) {
        super(TYPE.getDN(), gameObject, TYPE);
    }

    public function setPosProvider(provider:PositionProvider):Void {
        this.provider = provider;
    }

    public function getPos():Position {
        if (this.provider == null) throw 'Pos source is not set for ${this.gameObject}.';
        return this.provider.getPos();
    }

    public function distanceTo(other:PositionTrait):Int {
        var p0 = this.getPos();
        var p1 = other.getPos();

        var x = p0.x - p1.x;
        var y = p0.y - p1.y;
        var z = p0.z - p1.z;

        return Std.int(Math.sqrt(x * x + y * y + z * z));
    }
}
