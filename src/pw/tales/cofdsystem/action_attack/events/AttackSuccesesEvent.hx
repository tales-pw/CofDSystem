package pw.tales.cofdsystem.action_attack.events;

@:expose("AttackSuccesesEvent")
class AttackSuccesesEvent extends AttackEvent
{
    private var succeses:Int;

    public function new(succeses:Int, action:AttackAction)
    {
        super(action);
        this.succeses = succeses;
    }

    public function getDamageSucceses():Int
    {
        return this.succeses;
    }

    public function setDamageSucceses(succeses:Int):Void
    {
        this.succeses = succeses;
    }
}
