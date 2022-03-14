package pw.tales.cofdsystem.game_object.trait_manager;

import pw.tales.cofdsystem.utils.registry.IRecord;
import pw.tales.cofdsystem.game_object.events.TraitRemoveEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPostAttachEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPostRemoveEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPreAttachEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPreRemoveEvent;
import pw.tales.cofdsystem.game_object.trait_manager.exceptions.CreationRejectedException;
import pw.tales.cofdsystem.game_object.trait_manager.exceptions.MITraitAddException;
import pw.tales.cofdsystem.game_object.trait_manager.exceptions.MITraitFetchException;
import pw.tales.cofdsystem.game_object.trait_manager.exceptions.RemoveRejectedException;
import pw.tales.cofdsystem.game_object.trait_manager.exceptions.WrongTypeException;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.registry.Registry;
import pw.tales.cofdsystem.utils.Utility;

/**
    This class is responsible for managing GameObject's traits.
**/
@:expose("TraitManager")
class TraitManager
{
    /** Bound system object. Field is mostly used for quicker access to value stored in GameObject. **/
    private final system:CofDSystem;

    /** GameObject whose traits are managed. **/
    private final gameObject:GameObject;

    /** Registry that stores all GameObject's traits. **/
    private final traits:Registry<Trait> = new Registry<Trait>();

    public function new(gameObject:GameObject)
    {
        this.gameObject = gameObject;
        this.system = gameObject.getSystem();
    }

    /**
        Creates Trait from given TraitType. Created Trait is attached
        to GameObject.

        It posts some important events related to trait creation
        which may be cancelled somewhere in the code.

        @param    type  TraitType from which Trait will be created.
        @param    dn    dn for newly create trait. If is not passed, dn will be generated.
        @returns        Created Trait.
    **/
    public function addTrait<T:Trait>(type:TraitType<T>, dn:String = null):T
    {
        if (!type.isMultiInstanced())
        {
            var trait = this.getTrait(type);
            if (trait != null)
                throw new MITraitAddException(this.gameObject, type);
        }

        if (!type.canAdd(gameObject))
            throw new CreationRejectedException(this.gameObject, type);

        var trait:T;
        if (dn == null)
            trait = type.create(this.gameObject);
        else
            trait = type.createWithDN(dn, this.gameObject);

        this.system.events.post(new TraitPreAttachEvent(trait));
        this.traits.register(trait);
        trait.onAttached();
        this.system.events.post(new TraitPostAttachEvent(trait));

        return trait;
    }

    public function removeTrait<T:Trait>(trait:T):Void
    {
        var event = new TraitRemoveEvent(trait);
        this.system.events.post(event);

        if (event.isCancelled())
            throw new RemoveRejectedException(trait);

        this.system.events.post(new TraitPreRemoveEvent(trait));
        this.traits.unregister(trait);
        trait.onRemoved();
        this.system.events.post(new TraitPostRemoveEvent(trait));
    }

    /**
        This method fetches trait.

        @param    type  TraitType of wanted trait.
        @param    dn    Trait's DN. Optional but required for multi-instanced traits.
        @returns        Wanted Trait or null if it's not found.

        @throws  MultiInstancedException  If tries to search for multi-instanced without
                                          DN.
        @throws  WrongTypeException       If Trait is found by DN but TraitType is
                                          different.
    **/
    @:nullSafety(Off)
    public function getTrait<T:Trait>(type:TraitType<T>, dn:String = null):T
    {
        if (dn == null)
        {
            if (type.isMultiInstanced())
                throw new MITraitFetchException(this.gameObject, type);
            dn = type.getDN();
        }

        var record = traits.getRecord(dn);
        if (record == null)
            return null;
        if (record.getType() != type)
            throw new WrongTypeException(this.gameObject, record, type);

        return cast(record);
    }

    /**
        This method fetches trait by dn. There is no way to determin trait type whe we do that.

        @param    dn    Trait's DN.
        @returns        Wanted Trait or null if it's not found.
    **/
    @:nullSafety(Off)
    public function getTraitByDn(dn:String):Trait
    {
        var record:IRecord = traits.getRecord(dn);
        if (record == null)
            return null;
        return cast(record);
    }

    /**
        Getter for registry that stores Traits. Avoid using it.

        Used internally for serialization and deserialization.

        @returns Registry.
    **/
    public function getTraits():Registry<Trait>
    {
        return this.traits;
    }

    public function deactivate():Void
    {
        for (trait in traits.items())
        {
            trait.onRemoved();
        }
    }

    public function toString():String
    {
        var className = Utility.getClassName(Type.getClass(this));
        return '${className}[owner=${this.gameObject.getDN()}]';
    }
}
