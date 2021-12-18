package pw.tales.cofdsystem.character.traits.merits;

import pw.tales.cofdsystem.character.advancement.generation.events.GenMeritCollectEvent;
import pw.tales.cofdsystem.character.traits.merits.events.MeritsCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTrait;

@RegisterTraitTypes
@:expose("Merit")
class Merit extends ValueTrait
{
    public static final CUSTOM_MERIT_TYPE = new MeritType("Custom_Merit");

    private var meritType:MeritType;

    @Optional
    @Serialize("customName")
    private var customName:Null<String> = null;

    @Optional
    @Serialize("description")
    private var description:String = "";

    public function new(
        dn:String,
        gameObject:GameObject,
        type:MeritType,
        customName:String = null,
        description:String = null
    )
    {
        super(
            dn,
            gameObject,
            type,
            type.getLowestValue()
        );
        this.meritType = type;
        this.customName = customName;

        if (description != null)
        {
            this.description = description;
        }

        this.eventBus.addHandler(
            MeritsCollectEvent,
            (e:MeritsCollectEvent) -> e.collect(this)
        );
        this.eventBus.addHandler(
            GenMeritCollectEvent,
            (e:GenMeritCollectEvent) -> e.collect(this)
        );
    }

    override public function canUpdate(newValue:Int, preview:Bool = true):Bool
    {
        var levels = meritType.getLevels();

        if (levels.getLevels().indexOf(newValue) == -1)
        {
            return false;
        }

        return super.canUpdate(newValue);
    }

    override public function getValue():Int
    {
        return this.value;
    }

    public function setCustomName(customName:Null<String>):Void
    {
        this.customName = customName;
        this.notifyUpdated();
    }

    public function getCustomName():Null<String>
    {
        return this.customName;
    }

    public function setDescription(description:String):Void
    {
        this.description = description;
        this.notifyUpdated();
    }

    public function getDescription():String
    {
        return this.description;
    }

    override public function getDisplayName():String
    {
        if (customName != null)
            return this.customName;
        return super.getDisplayName();
    }
}
