package pw.tales.system.action_attack.events;

class AttackSuccesesEvent extends AttackEvent {
    private var succeses:Int;

    public function new(succeses:Int, action:AttackAction, system:CofDSystem) {
        super(action, system);
        this.succeses = succeses;
    }

    public function getDamageSucceses():Int {
        return this.succeses;
    }

    public function setDamageSucceses(succeses:Int) {
        this.succeses = succeses;
    }
}