package pw.tales.cofdsystem.synchronization.serialization.game_object;

import thx.Set;
import pw.tales.cofdsystem.utils.serialization.DeserializationException;
import haxe.Json;
import pw.tales.cofdsystem.game_object.traits.unknown_trait.UnknownTrait;
import pw.tales.cofdsystem.utils.logger.LoggerManager;
import pw.tales.cofdsystem.game_object.GameObjectState;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.trait_manager.TraitManager;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;

typedef GameObjectData = {
    version:String,
    dn:String,
    traits:Array<Dynamic>
}

@:expose("GameObjectSerialization")
class GameObjectSerialization extends Serialization<GameObject, GameObjectData>
{
    private var system:CofDSystem;

    public function new(system:CofDSystem)
    {
        this.system = system;
    }

    private function ensureTrait(
        manager:TraitManager,
        type:TraitType<Dynamic>,
        dn:String
    ):Trait
    {
        var trait:Null<Trait> = manager.getTrait(type, dn);
        if (trait != null)
            return trait;
        return manager.addTrait(type, dn);
    }

    private function getRemovedTraits(gameObject:GameObject, data:GameObjectData):Array<String>
    {
        var oldTraits = gameObject.getTraitManager().getTraits().items();
        var oldDns = Set.createString(
            [for (trait in oldTraits) trait.getDN()]
        );
        var newDNs = Set.createString([
            for (traitData in data.traits) traitData.dn
        ]);
        return (oldDns - newDNs).toArray();
    }

    public override function createNewObj(data:GameObjectData):GameObject
    {
        return new GameObject(data.dn, this.system);
    }

    public override function updateWithData(gameObject:GameObject, data:GameObjectData):GameObject
    {
        var logger = LoggerManager.getLogger();
        logger.info('Loading ${gameObject}.');

        gameObject.setState(GameObjectState.LOADING);

        // Start updating given GameObject
        gameObject.version = data.version;

        // Handle removed traits
        var removedTraits = this.getRemovedTraits(gameObject, data);

        this.applyChanges(gameObject, data.traits, removedTraits);

        // Mark all traits as having latest version.
        for (trait in gameObject.getTraitManager().getTraits().items()) {
            trait.acceptChanges();
        }

        // Make GameObject active
        gameObject.setState(GameObjectState.ACTIVE);
        logger.info('${gameObject} loaded.');

        return gameObject;
    }

    public function applyChanges(
        gameObject:GameObject,
        update:Array<Dynamic>,
        remove:Array<String>
    ):Void
    {
        var logger = LoggerManager.getLogger();
        var manager = gameObject.getTraitManager();

        // Remove traits
        for (dn in remove)
        {
            var trait = manager.getTraitByDn(dn);
            manager.removeTrait(trait);
        }

        // Handle new and updated traits
        for (traitData in update)
        {
            var type:TraitType<Dynamic> = system.traits.getRecord(traitData.type);
            if (type == null)
            {
                type = UnknownTrait.TYPE;
                logger.warning(
                    'Unable to identify trait type for data: ${Json.stringify(traitData)} fallback to ${type}'
                );
            }

            var trait:Trait = this.ensureTrait(manager, type, traitData.dn);
            try
            {
                trait.loadData(traitData);
            } catch (e:DeserializationException)
            {
                logger.warning(
                    'Unable to create ${trait.getType()} from data ${Json.stringify(traitData)} because: ${e.message}.'
                );
                manager.removeTrait(trait);
                trait = manager.addTrait(UnknownTrait.TYPE);
                trait.loadData(traitData);
            }
        }
    }

    public override function toData(gameObject:GameObject):GameObjectData
    {
        var data:GameObjectData = {
            version: gameObject.version,
            dn: gameObject.getDN(),
            traits: []
        };

        var traitManager:TraitManager = gameObject.getTraitManager();
        for (trait in traitManager.getTraits().items())
        {
            data.traits.push(trait.serialize());
        }

        return data;
    }
}
