package pw.tales.cofdsystem.game_object.traits;

import haxe.exceptions.NotImplementedException;
import pw.tales.cofdsystem.game_object.events.TraitAddEvent;
import pw.tales.cofdsystem.utils.registry.IRecord;
import pw.tales.cofdsystem.utils.Utility;
import thx.Uuid;

typedef TraitFactoryMethod<Y:Trait> = (dn:String, gameObject:GameObject, t:TraitType<Y>) -> Y;

/**
    This @:expose("represents")
    class represents trait. While Trait
    @:expose("represents")
    class represents specific instance of trait,
    child of this @:expose("would")
    class would represent all Library
    merits, its cost, description and etc.

    Also it handles trait instance creation, being
    some sort of factory for them.

    @see pw.tales.cofdsystem.game_object.traits.Trait
**/
@:expose("TraitType")
class TraitType<T:Trait> implements IRecord
{
    private final dn:String;
    private var name:Null<String> = null;

    private var factoryMethod:Null<TraitFactoryMethod<T>> = null;
    private var multiInstanced:Bool = false;

    public function new(dn:String)
    {
        this.dn = dn;
    }

    public function getDN():String
    {
        return this.dn;
    }

    public function getDisplayName():String
    {
        if (this.name != null)
            return this.name;
        return StringTools.replace(this.dn, "_", " ");
    }

    public function getName():Null<String>
    {
        return this.name;
    }

    public function setName(name:Null<String>):Void
    {
        this.name = name;
    }

    public function isMultiInstanced():Bool
    {
        return this.multiInstanced;
    }

    public function setMultiInstanced(multiInstanced:Bool):TraitType<T>
    {
        this.multiInstanced = multiInstanced;
        return this;
    }

    public function canAdd(gameObject:GameObject):Bool
    {
        var createEvent = new TraitAddEvent(gameObject, this);
        gameObject.getSystem().events.post(createEvent);
        return !createEvent.isCancelled();
    }

    public function createWithDN(dn:String, gameObject:GameObject):T
    {
        if (this.factoryMethod != null)
            return this.factoryMethod(dn, gameObject, this);

        throw new NotImplementedException();
    }

    public function create(gameObject:GameObject):T
    {
        var newDn;

        if (this.isMultiInstanced())
        {
            newDn = Uuid.create();
        } else
        {
            newDn = this.getDN();
        }

        return createWithDN(newDn, gameObject);
    }

    private function toString():String
    {
        var className = Utility.getClassName(Type.getClass(this));
        return '${className}[${this.getDN()}]';
    }

    public static function createType<T:Trait>(dn:String, factoryMethod:TraitFactoryMethod<T>):TraitType<T>
    {
        var newType = new TraitType(dn);
        newType.factoryMethod = factoryMethod;
        return newType;
    }
}
