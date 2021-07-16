package pw.tales.cofdsystem.scene.turns;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.scene.initiative.Initiative;
import pw.tales.cofdsystem.scene.turns.events.TurnEvent;

/** Handles turn rotation, who's turn now, starting and ending turns. **/
class Turns {
    private final system:CofDSystem;
    private final scene:Scene;
    private final initiative:Initiative;

    private var turns:Array<GameObject> = [];

    public function new(system:CofDSystem, scene:Scene, initiative:Initiative) {
        this.scene = scene;
        this.system = system;
        this.initiative = initiative;
    }

    public function add(gameObject:GameObject) {
        this.turns.push(gameObject);
    }

    public function remove(gameObject:GameObject) {
        this.turns.remove(gameObject);
    }

    public function nextRound() {
        this.turns = this.initiative.getOrder().copy();
    }

    public function start() {
        this.nextTurn();
    }

    public function nextTurn() {
        system.events.post(TurnEvent.END(this, this.getTurn()));

        this.turns.shift();

        var gameObject = this.getTurn();
        if (gameObject == null) this.nextRound();

        system.events.post(TurnEvent.START(this, this.getTurn()));
    }

    public function getScene():Scene {
        return this.scene;
    }

    public function getTurn():GameObject {
        return this.turns[0];
    }
}
