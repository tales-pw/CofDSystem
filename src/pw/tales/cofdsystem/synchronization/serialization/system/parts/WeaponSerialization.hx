package pw.tales.cofdsystem.synchronization.serialization.system.parts;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.synchronization.serialization.system.exceptions.ProcessingError;
import pw.tales.cofdsystem.utils.logger.LoggerManager;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import haxe.exceptions.NotImplementedException;

typedef ApiWeapon = {
    tags:Array<String>,
}

class WeaponSerialization<T:ApiWeapon, W:WeaponPrefab> implements IPartSerialization
{
    public function new() {}

    private function getWeaponsData(data:Dynamic):DynamicAccess<T>
    {
        throw new NotImplementedException();
    }

    private function create(
        record:T,
        tags:Array<TraitType<Dynamic>>
    ):W
    {
        throw new NotImplementedException();
    }

    private function getTagList(system:CofDSystem, recordTags:Array<Dynamic>):Array<TraitType<Dynamic>>
    {
        var tags:Array<TraitType<Dynamic>> = [];

        for (tagDN in recordTags)
        {
            var tag = system.traits.getRecord(tagDN);

            if (tag == null)
            {
                throw new ProcessingError('No tag "$tagDN".');
            }

            tags.push(tag);
        }

        return tags;
    }

    private function registerFromRecord(system:CofDSystem, record:T):Void
    {
        var tags = this.getTagList(system, record.tags);
        var weapon = this.create(record, tags);
        system.weapons.register(weapon);
    }

    public function update(system:CofDSystem, data:Dynamic):Void
    {
        var logger = LoggerManager.getLogger();

        var weapons = this.getWeaponsData(data);
        for (dn in weapons.keys())
        {
            var record:T = weapons.get(dn);

            try
            {
                // Trying to create and register weapon for each record.
                // If there is error, log error but continue with next.
                this.registerFromRecord(system, record);
            } catch (e:ProcessingError)
            {
                logger.error('Couldn\'t process $dn: ${e.message}');
            }
        }
    }
}
