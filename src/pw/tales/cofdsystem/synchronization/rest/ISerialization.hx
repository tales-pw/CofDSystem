package pw.tales.cofdsystem.synchronization.rest;

interface ISerialization
{
    function handle(system:CofDSystem, data:Dynamic):Void;
}
