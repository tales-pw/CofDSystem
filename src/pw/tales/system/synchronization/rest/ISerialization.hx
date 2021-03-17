package pw.tales.system.synchronization.rest;

interface ISerialization {
    function handle(system:CofDSystem, data:Dynamic):Void;
}
