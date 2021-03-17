package pw.tales.system.game_object.traits.text;

@:keep
@:expose("TextTrait")
class TextTrait extends Trait {
    @Serialize("value")
    private var value:String = "";

    public function getText():String {
        return this.value;
    }

    public function setText(value:String) {
        this.value = value;
        this.notifyUpdated();
    }
}
