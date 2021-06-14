package pw.tales.cofdsystem.synchronization.system;

import pw.tales.cofdsystem.synchronization.system.serialization.APIAbilitySerialization;
import pw.tales.cofdsystem.synchronization.system.serialization.APIArmorSerialization;
import pw.tales.cofdsystem.synchronization.system.serialization.APIConditionSerialization;
import pw.tales.cofdsystem.synchronization.system.serialization.MeleeSerialization;
import pw.tales.cofdsystem.synchronization.system.serialization.RangedSerialization;
import pw.tales.cofdsystem.synchronization.system.serialization.TagSerialization;
import pw.tales.cofdsystem.synchronization.system.serialization.TiltSerialization;

@:expose("SystemSynchronization")
class SystemSynchronization extends Synchronization<Dynamic, CofDSystem> {
    public static final instance = SystemSynchronization();

    private static final handlers:Array<ISystemSerializationItem> = [
        APIAbilitySerialization.INSTANCE,
        APIConditionSerialization.INSTANCE,
        TiltSerialization.INSTANCE,
        APIArmorSerialization.INSTANCE,
        TagSerialization.INSTANCE,
        MeleeSerialization.INSTANCE,
        RangedSerialization.INSTANCE,
    ];

    public override function updateWithData(system:CofDSystem, data:Dynamic):Void {
        for (handler in handlers) {
            handler.updateFromData(system, data);
        }
    }

    override public function fromData(data:Dynamic):CofDSystem {
        var system = new CofDSystem();
        this.updateWithData(system, data);
        return system;
    }

    override public function toData(system:CofDSystem):Dynamic {
        var data:Dynamic = {};
        for (handler in handlers) {
            handler.writeToData(system, data);
        }
        return data;
    }
}
