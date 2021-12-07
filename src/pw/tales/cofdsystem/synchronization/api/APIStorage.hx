package pw.tales.cofdsystem.synchronization.api;

import haxe.http.HttpBase;

class APIStorage
{
    public dynamic function createHttp(url:String):HttpBase
    {
        return new haxe.Http(url);
    }
}
