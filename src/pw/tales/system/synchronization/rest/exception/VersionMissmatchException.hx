package pw.tales.system.synchronization.rest.exception;

@:expose("VersionMissmatchException")
class VersionMissmatchException {
    public final currentVersion:String;
    public final remoteVersion:String;

    public function new(currentVersion:String, remoteVersion:String) {
        this.currentVersion = currentVersion;
        this.remoteVersion = remoteVersion;
    }
}
