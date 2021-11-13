package pw.tales.cofdsystem.scene.initiative.events;

import pw.tales.cofdsystem.utils.events.IEvent;

@:expose("InitiativeEvent")
class InitiativeEvent implements IEvent
{
    private var initiative:Initiative;

    public function new(initiative:Initiative)
    {
        this.initiative = initiative;
    }

    public function getInitiative():Initiative
    {
        return this.initiative;
    }
}
