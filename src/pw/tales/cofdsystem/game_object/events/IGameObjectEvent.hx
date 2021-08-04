package pw.tales.cofdsystem.game_object.events;

import pw.tales.cofdsystem.utils.events.IEvent;

interface IGameObjectEvent extends IEvent
{
    function isRelated(gameObject:GameObject):Bool;
}
