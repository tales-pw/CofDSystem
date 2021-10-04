package pw.tales.cofdsystem.action.events;

class RollActionEvent extends ActionEvent
{
    private var rollAction:RollAction;

    public function new(action:RollAction)
    {
        super(action);
        this.rollAction = action;
    }
}
