package pw.tales.cofdsystem.game_object;

import pw.tales.cofdsystem.synchronization.serialization.game_object.GameObjectSerialization;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;
import pw.tales.cofdsystem.game_object.trait_manager.TraitManager;
import pw.tales.cofdsystem.utils.events.IEvent;
import pw.tales.cofdsystem.utils.events.IEventBus;
import pw.tales.cofdsystem.utils.events.SubEventBus;
import pw.tales.cofdsystem.utils.registry.IRecord;
import pw.tales.cofdsystem.utils.Utility;

@:nullSafety(Off)
@:expose("GameObject")
class GameObject implements IRecord
{
    private final dn:String;

    private final system:CofDSystem;
    private final traitManager:TraitManager;
    private final events:SubEventBus;

    private var state = GameObjectState.ACTIVE;

    public var version = "";

    public function new(dn:String, system:CofDSystem)
    {
        this.dn = dn;
        this.system = system;
        this.traitManager = new TraitManager(this);

        this.events = new SubEventBus(system.events, function(event:IEvent)
        {
            var e:IGameObjectEvent = Std.downcast(event, IGameObjectEvent);
            return e != null && e.isRelated(this);
        });
    }

    public function getDN():String
    {
        return this.dn;
    }

    public function getTraitManager():TraitManager
    {
        return this.traitManager;
    }

    public function getTrait<T:Trait>(type:TraitType<T>, dn:String = null):T
    {
        return this.traitManager.getTrait(type, dn);
    }

    public function getTraits():Array<Trait>
    {
        return this.getTraitManager().getTraits().items();
    }

    public function getSystem():CofDSystem
    {
        return this.system;
    }

    public function getEventBus():IEventBus
    {
        return this.events;
    }

    public function getState():GameObjectState
    {
        return this.state;
    }

    public function setState(state:GameObjectState):Void
    {
        this.state = state;
    }

    public function deactivate():Void
    {
        this.state = GameObjectState.INACTIVE;
        this.getTraitManager().deactivate();
        this.events.disable();
    }

    public function toString():String
    {
        var className = Utility.getClassName(Type.getClass(this));
        return '${className}[${this.getDN()}]';
    }

    public function toData():Dynamic
    {
        var serializer = new GameObjectSerialization(this.system);
        return serializer.toData(this);
    }

    public function updateWithData(data:Dynamic):Void
    {
        var serializer = new GameObjectSerialization(this.system);
        serializer.updateWithData(this, data);
    }

    public static function fromData(system:CofDSystem, data:Dynamic):GameObject
    {
        var serializer = new GameObjectSerialization(system);
        return serializer.fromData(data);
    }
}
