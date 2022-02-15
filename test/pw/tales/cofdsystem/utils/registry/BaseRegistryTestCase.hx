package pw.tales.cofdsystem.utils.registry;

import haxe.unit.TestCase;

@:nullSafety(Off)
class BaseRegistryTestCase extends TestCase
{
    public var registry:Registry<TestRecord>;

    public static final RECORD_DN = "test";
    public static final RECORD = new TestRecord(RECORD_DN);

    public function createRegistry():Registry<TestRecord>
    {
        return new Registry<TestRecord>();
    }

    public override function setup():Void
    {
        super.setup();
        this.registry = this.createRegistry();
        this.registry.register(RECORD);
    }

    public function testGet():Void
    {
        this.assertEquals(
            this.registry.getRecord(RECORD_DN),
            RECORD
        );
    }

    public function testGetNone():Void
    {
        this.assertEquals(
            this.registry.getRecord("test1"),
            null
        );
    }

    public function testGetNull():Void
    {
        var registry = new Registry(true);
        this.assertEquals(registry.getRecord(null), null);
    }
}
