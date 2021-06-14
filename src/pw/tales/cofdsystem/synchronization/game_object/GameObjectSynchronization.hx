package pw.tales.cofdsystem.synchronization.game_object;

import haxe.Json;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.GameObjectState;
import pw.tales.cofdsystem.game_object.trait_manager.TraitManager;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.traits.unknown_trait.UnknownTrait;
import pw.tales.cofdsystem.utils.logger.LoggerManager;
import pw.tales.cofdsystem.utils.serialization.DeserializationException;

typedef GameObjectData = {
    version:String,
    dn:String,
    traits:Array<Dynamic>
}

@:expose("GameObjectSynchronization")
class GameObjectSynchronization extends Synchronization<GameObjectData, GameObject> {
    private final system:CofDSystem;

    public function new(system:CofDSystem) {
        this.system = system;
    }

    private function ensureTrait(manager:TraitManager, type:TraitType<Dynamic>, dn:String):Trait {
        var trait:Null<Trait> = manager.getTrait(type, dn);
        if (trait != null) return trait;
        return manager.addTrait(type, dn);
    }

    private function getRemovedTraits(gameObject:GameObject, data:GameObjectData):Array<Trait> {
        var oldTraits = gameObject.getTraitManager().getTraits().items();
        var newDNs = [for (trait in data.traits) trait.dn];

        return oldTraits.filter((v:Trait) -> !newDNs.contains(v.getDN()));
    }

    public override function updateWithData(gameObject:GameObject, data:GameObjectData):Void {
        gameObject.setState(GameObjectState.LOADING);

        // Start updating given GameObject
        gameObject.version = data.version;

        var traits:Array<Dynamic> = data.traits;
        var manager = gameObject.getTraitManager();

        // Handle removed traits
        var removedTraits = this.getRemovedTraits(gameObject, data);
        for (trait in removedTraits) manager.removeTrait(trait);

        var logger = LoggerManager.getLogger();
        // Handle new and updated traits
        for (trait_data in traits) {
            var type:TraitType<Dynamic> = system.traits.getRecord(trait_data.type);
            if (type == null) {
                type = cast(UnknownTrait.TYPE);
                logger.warning(
                    'Unable to identify trait type for data:' +
                    '${Json.stringify(trait_data)}' +
                    'fallback to ${type}'
                );
            }

            var trait:Trait = this.ensureTrait(manager, type, trait_data.dn);
            try {
                trait.deserialize(trait_data);
            } catch (e:DeserializationException) {
                logger.warning(
                    'Unable to create ${trait.getType()} ' +
                    'from data ${Json.stringify(trait_data)} ' +
                    'because: ${e.message}.'
                );
                manager.removeTrait(trait);
                trait = manager.addTrait(UnknownTrait.TYPE);
                trait.deserialize(trait_data);
            }
        }

        // Make GameObject active
        gameObject.setState(GameObjectState.ACTIVE);
    }

    public override function fromData(data:GameObjectData):GameObject {
        var gameObject:GameObject = new GameObject(this.system);
        this.updateWithData(gameObject, data);
        return gameObject;
    }

    public override function toData(gameObject:GameObject):GameObjectData {
        var data:GameObjectData = {
            version: gameObject.version,
            dn: gameObject.getDN(),
            traits: []
        };

        var traitManager:TraitManager = gameObject.getTraitManager();
        for (trait in traitManager.getTraits().items()) {
            data.traits.push(trait.serialize());
        }

        return data;
    }
}
