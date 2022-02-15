package pw.tales.cofdsystem.synchronization.serialization.system;

import thx.semver.Version;
import pw.tales.cofdsystem.synchronization.serialization.Serialization;
import pw.tales.cofdsystem.synchronization.serialization.system.exceptions.VersionMissmatchException;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.AbilitySerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.ConditionSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.TiltSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.ArmorSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.MeleeSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.RangedSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.TagSerialization;

class SystemSerialization extends Serialization<CofDSystem, SystemData>
{
    public static final INSTANCE = new SystemSerialization();

    private static final HANDLERS:Array<IPartSerialization> = [
        AbilitySerialization.INSTANCE,
        ConditionSerialization.INSTANCE,
        TiltSerialization.INSTANCE,
        ArmorSerialization.INSTANCE,
        TagSerialization.INSTANCE,
        MeleeSerialization.INSTANCE,
        RangedSerialization.INSTANCE,
    ];

    public function new() {}

    public override function createNewObj(data:SystemData):CofDSystem
    {
        return new CofDSystem();
    }

    private function checkVersion(data:SystemData):Void
    {
        if (!CofDSystem.VERSION_CHECK)
            return;

        var localVersion:Version = CofDSystem.VERSION;
        var remoteVersion:Version = data.version;

        if (remoteVersion.major != localVersion.major)
        {
            throw new VersionMissmatchException(CofDSystem.VERSION, remoteVersion);
        }
    }

    public override function updateWithData(obj:CofDSystem, data:SystemData):CofDSystem
    {
        this.checkVersion(data);

        for (handler in HANDLERS)
        {
            handler.update(obj, data);
        }

        return obj;
    }

    public override function toData(obj:CofDSystem):SystemData
        throw "Not Implemented";
}
