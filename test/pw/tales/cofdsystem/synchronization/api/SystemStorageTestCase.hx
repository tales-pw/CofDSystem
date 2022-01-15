package pw.tales.cofdsystem.synchronization.api;

class SystemStorageTestCase extends APIStorageTestCase
{
    @:nullSafety(Off)
    private var storage:SystemStorage = null;

    public override function setup():Void
    {
        super.setup();
        this.storage = new SystemStorage(this.DOMAIN);
        this.storage.createHttp = this.mockCreateHttp();
    }

    /** Tests successful fetch. **/
    public function testSuccessfulFetch():Void
    {
        this.httpMock.setData(TestData.SYSTEM_VALID_DATA);

        var system = new CofDSystem();
        this.storage.update(system);

        this.assertEquals(httpMock.url, '${this.DOMAIN}/system');
    }
}
