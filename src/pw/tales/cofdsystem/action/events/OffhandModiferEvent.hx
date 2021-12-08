package pw.tales.cofdsystem.action.events;

import pw.tales.cofdsystem.game_object.events.GameObjectEvent;

@:expose("OffhandModiferEvent")
class OffhandModiferEvent extends GameObjectEvent
{
    public var modifer:Int = -2;

    public function getModifer():Int
    {
        return this.modifer;
    }

    public function setModifer(modifer:Int):Void
    {
        this.modifer = modifer;
    }
}
