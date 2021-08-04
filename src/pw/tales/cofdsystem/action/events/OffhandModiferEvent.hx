package pw.tales.cofdsystem.action.events;

import pw.tales.cofdsystem.game_object.events.GameObjectEvent;

class OffhandModiferEvent extends GameObjectEvent
{
    public var modifer:Int = -2;

    public function getModifer():Int
    {
        return this.modifer;
    }

    public function setModifer(modifer:Int)
    {
        this.modifer = modifer;
    }
}
