package pw.tales.cofdsystem.scene;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.CofDSystem;
import pw.tales.cofdsystem.scene.events.SceneEvent;
import pw.tales.cofdsystem.scene.initiative.Initiative;
import pw.tales.cofdsystem.scene.turns.Turns;
import pw.tales.cofdsystem.utils.registry.IRecord;
import pw.tales.cofdsystem.utils.Utility;
import thx.Uuid;

class Scene implements IRecord
{
    private var dn:String = Uuid.create();

    private final system:CofDSystem;

    private var initiative:Initiative;
    private var turns:Turns;

    @:nullSafety(Off)
    private function new(system:CofDSystem)
    {
        this.system = system;
        this.initiative = null;
        this.turns = null;
    }

    private function setUp():Scene
    {
        this.initiative = new Initiative(this.system, this);
        this.turns = new Turns(this.system, this, this.initiative);
        return this;
    }

    public function add(gameObject:GameObject):Void
    {
        this.initiative.add(gameObject);
    }

    public function remove(gameObject:GameObject):Void
    {
        this.initiative.remove(gameObject);
        this.turns.remove(gameObject);
    }

    public function getSystem():CofDSystem
    {
        return system;
    }

    public function getInitiative():Initiative
    {
        return this.initiative;
    }

    public function getTurns():Turns
    {
        return this.turns;
    }

    public function getDN():String
    {
        return this.dn;
    }

    public function begin():Void
    {
        this.system.events.post(SceneEvent.START(this));
    }

    public function end():Void
    {
        this.system.events.post(SceneEvent.END(this));
    }

    public function toString():String
    {
        var clazz = Type.getClass(this);
        return '${Utility.getClassName(clazz)}[${this.dn}}]';
    }

    public static function create(system:CofDSystem):Scene
    {
        return new Scene(system).setUp();
    }
}
