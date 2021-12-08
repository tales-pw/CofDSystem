package pw.tales.cofdsystem.game_object;

import pw.tales.cofdsystem.game_object.events.tracker.TrackerClearedEvent;
import pw.tales.cofdsystem.game_object.events.tracker.TrackerTrackEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPostAttachEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPostChangeEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPostRemoveEvent;
import pw.tales.cofdsystem.game_object.events.traits.TraitPostUpdateEvent;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.utils.events.HandlerPriority;
import pw.tales.cofdsystem.utils.events.SubEventBus;
import pw.tales.cofdsystem.utils.registry.Registry;

@:expose("TraitTracker")
class TraitTracker
{
    private final gameObject:GameObject;
    private final events:SubEventBus;

    private var update:Registry<Trait> = new Registry<Trait>(true, true);
    private var remove:Registry<Trait> = new Registry<Trait>(true, true);

    public function new(gameObject:GameObject)
    {
        this.gameObject = gameObject;
        this.events = gameObject.getEventBus().createSubBus();

        this.events.addHandler(TraitPostAttachEvent, trackChange, HandlerPriority.NORMAL);
        this.events.addHandler(TraitPostUpdateEvent, trackChange, HandlerPriority.NORMAL);
        this.events.addHandler(TraitPostRemoveEvent, trackRemove, HandlerPriority.NORMAL);
    }

    public function getGameObject():GameObject
    {
        return this.gameObject;
    }

    private function trackChange(event:TraitPostChangeEvent):Void
    {
        final trait:Trait = event.getTrait();
        final gameObject = trait.getGameObject();

        if (gameObject.getState() != GameObjectState.ACTIVE)
            return;

        if (trait.hasChanges())
        {
            update.register(trait);
            remove.unregister(trait);
        } else
        {
            update.unregister(trait);
        }

        gameObject.getSystem().events.post(new TrackerTrackEvent(this));
    }

    private function trackRemove(event:TraitPostRemoveEvent):Void
    {
        final trait:Trait = event.getTrait();
        final gameObject = trait.getGameObject();

        if (gameObject.getState() != GameObjectState.ACTIVE)
            return;

        if (!trait.isNew())
            remove.register(trait);
        update.unregister(trait);

        gameObject.getSystem().events.post(new TrackerTrackEvent(this));
    }

    public function getUpdate():Array<Trait>
    {
        return update.items();
    }

    public function getRemove():Array<Trait>
    {
        return remove.items();
    }

    public function hasChanges():Bool
    {
        return this.getUpdate().length > 0 || this.getRemove().length > 0;
    }

    public function clear():Void
    {
        for (trait in update.items())
            trait.acceptChanges();

        update.clear();
        remove.clear();

        gameObject.getSystem().events.post(new TrackerClearedEvent(this));
    }
}
