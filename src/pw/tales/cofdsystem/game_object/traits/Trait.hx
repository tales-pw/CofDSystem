package pw.tales.cofdsystem.game_object.traits;

import pw.tales.cofdsystem.game_object.events.CollectEvent;
import haxe.DynamicAccess;
import pw.tales.cofdsystem.game_object.events.traits.TraitPostDeserializeEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPostEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPostUpdateEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.IEvent;
import pw.tales.cofdsystem.utils.events.SubEventBus;
import pw.tales.cofdsystem.utils.registry.IRecord;
import pw.tales.cofdsystem.utils.serialization.AnnotationSerialization;
import pw.tales.cofdsystem.utils.Utility;
import thx.error.AbstractMethod;

/**
    This @:expose("represents")
    class represents specific trait instance.
    For examaple, Library merit at 3 dots that belongs
    to specific character would be represented by
    child @:expose("of")
    class of this class.

    @see pw.tales.cofdsystem.game_object.traits.TraitType
**/
@RegisterTraitTypes
@:expose("Trait")
class Trait implements IRecord
{
    private final type:TraitType<Dynamic>;
    private final gameObject:GameObject;
    private final system:CofDSystem;
    private final eventBus:SubEventBus;

    private var version:TraitVersion = TraitVersion.NEW;

    @Serialize("dn")
    private final dn:String;

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        this.dn = dn;
        this.type = type;
        this.gameObject = gameObject;
        this.system = gameObject.getSystem();
        this.eventBus = gameObject.getEventBus().createSubBus();
    }

    public function getDisplayName():String
    {
        return this.type.getDisplayName();
    }

    /**
        Getter for Trait type.

        @returns Trait type.
    **/
    public function getType():TraitType<Dynamic>
    {
        return this.type;
    }

    /**
        Getter for instance DN.

        @returns DN.
    **/
    public function getDN():String
    {
        return this.dn;
    }

    /**
        Getter for Trait owner.

        @returns Trait owner GameObject.
    **/
    public function getGameObject():GameObject
    {
        return this.gameObject;
    }

    public function getValue():Int
        throw new AbstractMethod();

    /**
        This method is needed to check if view representation of
        this trait should be updated when given Event is posted.

        @param  event  Event to check.

        @returns  True  if view should be updated
                        and False if not.
    **/
    public function shouldUpdateView(event:IEvent):Bool
    {
        var traitEvent:TraitPostEvent = Std.downcast(event, TraitPostEvent);
        if (traitEvent == null)
            return false;
        return traitEvent.getTrait() == this;
    }

    /**
        Should be called to notify entire system of
        changes in current trait (mostly to store
        updated data or update view).
    **/
    public function notifyUpdated():Void
    {
        this.eventBus.post(new TraitPostUpdateEvent(this));
    }

    /**
        Is called when trait is created and attached to
        GameObject. Needed to setup some additional things
        such as additional traits for templates, for example.
    **/
    public function onAttached():Void {}

    /**
        Is called when trait is remove from GameObject.
        Needed to cleanup some side effects after trait
        is removed.
    **/
    public function onRemoved():Void
    {
        this.eventBus.disable();
    }

    /**
        Store object data in anonymous structure for future serialization.

        @param  data  Data (anonymous structure with serializable values).
                      Probably created by serialize method.

        @returns      Data. Values should be easy to serialize (mostly
                      primitives, strings and anonymous structures
                      containing primitives and strings).
    **/
    public function serialize():Dynamic
        throw
            {
                var data:DynamicAccess<Dynamic> = AnnotationSerialization.serialize(this);
                data.set("type", this.getType().getDN());
                return data;
            }

    /**
        Fetch object data from given anonymous structure.
        Final state will become object's head of changes.

        @param  data  Data, probably created by serialize method.
    **/
    public function deserialize(data:Dynamic)
    {
        AnnotationSerialization.deserialize(this, data);
        this.acceptChanges();
        this.eventBus.post(new TraitPostDeserializeEvent(this));
    }

    public function isNew():Bool
    {
        return this.version == TraitVersion.NEW;
    }

    /** Check if trait has any changes. **/
    public function hasChanges():Bool
    {
        switch (this.version)
        {
            case TraitVersion.NEW:
                return true;
            case TraitVersion.VERSION(data):
                return haxe.Json.stringify(data) != haxe.Json.stringify(this.serialize());
        }
        return false;
    }

    /** Make current state  object's head of changes. **/
    public function acceptChanges():Void
    {
        this.version = TraitVersion.VERSION(this.serialize());
    }

    /** Revert all changes to trait. **/
    public function revertChanges():Void
    {
        this.deserialize(this.version);
    }

    public function collect(e:CollectEvent<Dynamic>):Void
    {
        e.collect(this);
    }

    public function toString():String
    {
        var className = Utility.getClassName(Type.getClass(this));
        return '${className}[${this.serialize()}]';
    }
}
