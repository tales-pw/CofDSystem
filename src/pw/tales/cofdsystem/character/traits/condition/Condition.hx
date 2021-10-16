package pw.tales.cofdsystem.character.traits.condition;

import pw.tales.cofdsystem.character.traits.condition.events.ConditionsCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@:expose("Condition")
class Condition extends Trait
{
    @Optional
    @Serialize("customName")
    private var customName:Null<String> = null;

    @Optional
    @Serialize("description")
    private var description:String = "";

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.eventBus.addHandler(ConditionsCollectEvent, this.collect);
    }

    public function setCustomName(customName:String):Void
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
