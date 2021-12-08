package pw.tales.cofdsystem.synchronization.serialization.system.exceptions;

import pw.tales.cofdsystem.exceptions.CofDSystemException;

@:expose("VersionMissmatchException")
class VersionMissmatchException extends CofDSystemException
{
    public final currentVersion:String;
    public final remoteVersion:String;

    public function new(currentVersion:String, remoteVersion:String)
    {
        super(
            'Version missmatch: ${remoteVersion} (remote) != ${currentVersion} (our)'
        );
        this.currentVersion = currentVersion;
        this.remoteVersion = remoteVersion;
    }
}
