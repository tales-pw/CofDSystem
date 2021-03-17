package pw.tales.system.scene.initiative.events;

import pw.tales.system.utils.events.IEvent;

class InitiativeEvent implements IEvent {
    private var initiative:Initiative;

    public function new(initiative:Initiative) {
        this.initiative = initiative;
    }

    public function getInitiative():Initiative {
        return this.initiative;
    }
}
