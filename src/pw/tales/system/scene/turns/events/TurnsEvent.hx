package pw.tales.system.scene.turns.events;

import pw.tales.system.utils.events.IEvent;

class TurnsEvent implements IEvent {
    private final intitiative:Turns;

    private function new(intitiative:Turns) {
        this.intitiative = intitiative;
    }

    public function getInitiative():Turns {
        return this.intitiative;
    }
}
