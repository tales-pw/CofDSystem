package pw.tales.cofdsystem.synchronization.serialization.system;

import pw.tales.cofdsystem.synchronization.serialization.Serialization;
import pw.tales.cofdsystem.synchronization.serialization.system.exceptions.VersionMissmatchException;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.AbilitySerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.ConditionSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.TiltSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.ArmorSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.MeleeSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.RangedSerialization;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.TagSerialization;

class SystemSerialization extends Serialization<CofDSystem, Dynamic>
{
    public static final INSTANCE = new SystemSerialization();

    private static final HANDLERS:Array<IPartSerialization> = [
        AbilitySerialization.INSTANCE,
        ConditionSerialization.INSTANCE,
        TiltSerialization.INSTANCE,
        ArmorSerialization.INSTANCE,
        MeleeSerialization.INSTANCE,
        RangedSerialization.INSTANCE,
        TagSerialization.INSTANCE
    ];

    public function new() {}

    public override function createNewObj(data:Dynamic):CofDSystem
    {
        return new CofDSystem();
    }

    public override function updateWithData(obj:CofDSystem, data:Dynamic):CofDSystem
    {
        var remoteVersion:String = data.version;
        if (CofDSystem.versionCheck && remoteVersion != CofDSystem.version)
        {
            throw new VersionMissmatchException(CofDSystem.version, remoteVersion);
        }

        for (handler in HANDLERS)
        {
            handler.update(obj, data);
        }

        return obj;
    }
}
