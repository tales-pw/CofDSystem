package pw.tales.cofdsystem.synchronization.api;

import haxe.http.HttpBase;

class APIStorage
{
    public dynamic function createHttp(url:String):HttpBase
    {
        var request = new haxe.Http(url);
        #if js
            request.withCredentials = true;
        #end
        return request;
    }
}
