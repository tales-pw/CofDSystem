package pw.tales.cofdsystem.scene.initiative;

import pw.tales.cofdsystem.CofDSystem;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.scene.initiative.events.InitiativeModifiersEvent;
import pw.tales.cofdsystem.scene.initiative.events.InitiativeUpdateEvent;
import pw.tales.cofdsystem.scene.initiative.exceptions.AddedAgainException;
import pw.tales.cofdsystem.scene.initiative.exceptions.ParticipantNotFoundException;

/** Stores list of initiatives, their order, handles rolling for initiative and etc **/
@:expose("Initiative")
class Initiative
{
    private final system:CofDSystem;
    private final scene:Scene;

    private var order:Array<GameObject> = [];
    private var rollResults:Map<GameObject, Int> = new Map<GameObject, Int>();

    public function new(system:CofDSystem, scene:Scene)
    {
        this.scene = scene;
        this.system = system;
    }

    public function getOrder():Array<GameObject>
    {
        return this.order;
    }

    public function getInitiative(gameObject:GameObject):Int
    {
        var rollResult = this.rollResults.get(gameObject);

        if (rollResult == null)
            throw new ParticipantNotFoundException(gameObject.getDN());

        var event = new InitiativeModifiersEvent(gameObject, this);
        this.system.events.post(event);

        return rollResult + event.getModifier();
    }

    public function add(gameObject:GameObject)
    {
        if (this.order.indexOf(gameObject) != -1)
        {
            throw new AddedAgainException(gameObject, this);
            return;
        }

        this.order.push(gameObject);

        var rollResult = this.system.dices.d10();
        rollResults.set(gameObject, rollResult);

        this.update();
    }

    public function remove(gameObject:GameObject)
    {
        this.order.remove(gameObject);
        this.rollResults.remove(gameObject);

        this.update();
    }

    public function update()
    {
        this.order.sort(function(a:GameObject, b:GameObject):Int
        {
            var initiativeA = this.getInitiative(a);
            var initiativeB = this.getInitiative(b);

            return initiativeB - initiativeA;
        });

        this.system.events.post(new InitiativeUpdateEvent(this));
    }
}
