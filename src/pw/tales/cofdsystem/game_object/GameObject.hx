package pw.tales.cofdsystem.game_object;

import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;
import pw.tales.cofdsystem.game_object.trait_manager.TraitManager;
import pw.tales.cofdsystem.utils.events.IEvent;
import pw.tales.cofdsystem.utils.events.IEventBus;
import pw.tales.cofdsystem.utils.events.SubEventBus;
import pw.tales.cofdsystem.utils.registry.IRecord;
import pw.tales.cofdsystem.utils.Utility;

@:expose('GameObject')
@:nullSafety(Off)
class GameObject implements IRecord {
    private final dn:String;

    private final system:CofDSystem;
    private final traitManager:TraitManager;
    private final events:SubEventBus;

    private var state = GameObjectState.ACTIVE;

    public var version = "";

    public function new(dn:String, system:CofDSystem) {
        this.dn = dn;
        this.system = system;
        this.traitManager = new TraitManager(this);

        this.events = new SubEventBus(system.events, function(event:IEvent) {
            var e:IGameObjectEvent = Std.downcast(event, IGameObjectEvent);
            return e != null && e.isRelated(this);
        });
    }

    public function getDN():String {
        return this.dn;
    }

    public function getTraitManager():TraitManager {
        return this.traitManager;
    }

    public function getSystem():CofDSystem {
        return this.system;
    }

    public function getEventBus():IEventBus {
        return this.events;
    }

    public function getState():GameObjectState {
        return this.state;
    }

    public function setState(state:GameObjectState) {
        this.state = state;
    }

    public function deactivate() {
        this.state = GameObjectState.INACTIVE;
        this.getTraitManager().deactivate();
        this.events.disable();
    }

    public function toString() {
        var className = Utility.getClassName(Type.getClass(this));
        return '${className}[${this.getDN()}]';
    }
}