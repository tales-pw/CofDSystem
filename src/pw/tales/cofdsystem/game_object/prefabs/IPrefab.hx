package pw.tales.cofdsystem.game_object.prefabs;

import pw.tales.cofdsystem.utils.registry.IRecord;

/**
* Prefabs are used to create GameObjects with specific traits.
*
* Unlike Templates, they don't have any logic or meaning after
* GameObject is created. On the other hand, they may configure
* traits in specific way once when GameObject is being created.
**/
interface IPrefab extends IRecord {
    function createGameObject(system:CofDSystem):GameObject;
}
