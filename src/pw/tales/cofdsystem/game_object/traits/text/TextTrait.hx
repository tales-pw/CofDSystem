package pw.tales.cofdsystem.game_object.traits.text;

@:expose("TextTrait")
class TextTrait extends Trait
{
    @Serialize("value")
    private var value:String = "";

    public function getText():String
    {
        return this.value;
    }

    public function setText(value:String):Void
    {
        this.value = value;
        this.notifyUpdated();
    }
}
