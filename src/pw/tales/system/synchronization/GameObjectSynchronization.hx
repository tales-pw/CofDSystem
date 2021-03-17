package pw.tales.system.synchronization;

import haxe.Json;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.GameObjectState;
import pw.tales.system.game_object.TraitManager;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.game_object.traits.unknown_trait.UnknownTrait;
import pw.tales.system.utils.logger.LoggerManager;
import pw.tales.system.utils.serialization.DeserializationException;

typedef GameObjectData = {
    version:String,
    dn:String,
    traits:Array<Dynamic>
}

@:keep
@:expose("GameObjectSynchronization")
class GameObjectSynchronization {
    // Things serializer needs to know
    public var system:CofDSystem;

    // What to serialize
    public var gameObject:Null<GameObject>;

    private function new(system:CofDSystem) {
        this.system = system;
    }

    public static function createDeserializer(system:CofDSystem, gameObject:GameObject = null):GameObjectSynchronization {
        var serializer = new GameObjectSynchronization(system);
        serializer.gameObject = gameObject;
        return serializer;
    }

    public static function create(s:CofDSystem, gameObject:GameObject):GameObjectSynchronization {
        var serializer = new GameObjectSynchronization(s);
        serializer.gameObject = gameObject;
        return serializer;
    }

    private function ensureGameObject(data:GameObjectData):GameObject {
        if (this.gameObject == null) this.gameObject = new GameObject(data.dn, this.system);
        return this.gameObject;
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

    public function fromData(data:GameObjectData):GameObject {
        var gameObject:GameObject = this.ensureGameObject(data);
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
                    'Unable to deserialize ${e.getField()},' +
                    'needed by ${trait.getType()}' +
                    'from data ${Json.stringify(trait_data)}'
                );
                manager.removeTrait(trait);
                trait = manager.addTrait(UnknownTrait.TYPE);
                trait.deserialize(trait_data);
            }
        }

        // Make GameObject active
        gameObject.setState(GameObjectState.ACTIVE);
        return gameObject;
    }

    public function toData():GameObjectData {
        if (this.gameObject == null) throw "Unable to serialize gameObject as gameObject is not set";

        var data:GameObjectData = {
            version: this.gameObject.version,
            dn: this.gameObject.getDN(),
            traits: []
        };

        var traitManager:TraitManager = this.gameObject.getTraitManager();
        for (trait in traitManager.getTraits().items()) {
            data.traits.push(trait.serialize());
        }

        return data;
    }

    public function deserialize(serializedData:String):GameObject {
        var data:GameObjectData = haxe.Json.parse(serializedData);
        return this.fromData(data);
    }

    public function serialize():String {
        var data:GameObjectData = toData();
        return haxe.Json.stringify(data);
    }
}
