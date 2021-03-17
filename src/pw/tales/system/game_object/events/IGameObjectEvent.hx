package pw.tales.system.game_object.events;

import pw.tales.system.utils.events.IEvent;

interface IGameObjectEvent extends IEvent {
    function isRelated(gameObject:GameObject):Bool;
}
