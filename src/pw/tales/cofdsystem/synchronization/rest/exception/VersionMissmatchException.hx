package pw.tales.cofdsystem.synchronization.rest.exception;

import pw.tales.cofdsystem.exceptions.CofDSystemException;

@:expose("VersionMissmatchException")
class VersionMissmatchException extends CofDSystemException
{
    public final currentVersion:String;
    public final remoteVersion:String;

    public function new(currentVersion:String, remoteVersion:String)
    {
        super('Version missmatch: ${remoteVersion} (remote) != ${currentVersion} (our)');
        this.currentVersion = currentVersion;
        this.remoteVersion = remoteVersion;
    }
}
