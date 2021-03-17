package pw.tales.system.character.traits.condition;

import pw.tales.system.character.traits.condition.events.ConditionsCollectEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;

@:keep
@:expose("Condition")
class Condition extends Trait {
    @Optional
    @Serialize("customName")
    private var customName:Null<String> = null;

    @Optional
    @Serialize("description")
    private var description:String = "";

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>) {
        super(dn, gameObject, type);
        this.eventBus.addHandler(ConditionsCollectEvent, (e:ConditionsCollectEvent) -> e.collect(this));
    }

    public function setCustomName(customName:String) {
        this.customName = customName;
        this.notifyUpdated();
    }

    public function getCustomName():Null<String> {
        return this.customName;
    }

    public function setDescription(description:String) {
        this.description = description;
        this.notifyUpdated();
    }

    public function getDescription() {
        return this.description;
    }

    override public function getDisplayName():String {
        if (customName != null) return this.customName;
        return super.getDisplayName();
    }
}
