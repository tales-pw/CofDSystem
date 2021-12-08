package pw.tales.cofdsystem.game_object.traits.unknown_trait;

import pw.tales.cofdsystem.game_object.traits.unknown_trait.events.UnknownTraitsCollectEvent;

@:expose("UnknownTrait")
class UnknownTrait extends Trait
{
    public static final DN = "unknown_trait";
    public static final TYPE:UnknownType = new UnknownType(DN);

    private var data:Dynamic = {};

    public function new(dn:String, gameObject:GameObject)
    {
        super(dn, gameObject, UnknownTrait.TYPE);
        this.eventBus.addHandler(
            UnknownTraitsCollectEvent,
            (e:UnknownTraitsCollectEvent) -> e.collect(this)
        );
    }

    override public function serialize():Dynamic
        throw
            {
                return this.data;
            };

    override public function deserialize(data:Dynamic):Void
    {
        this.data = data;
    }
}
