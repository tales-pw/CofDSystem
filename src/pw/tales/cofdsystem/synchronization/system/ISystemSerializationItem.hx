package pw.tales.cofdsystem.synchronization.system;

interface ISystemSerializationItem {
    function updateFromData(system:CofDSystem, data:Dynamic):Void;

    function writeToData(system:CofDSystem, data:Dynamic):Void;
}
