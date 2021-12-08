package pw.tales.cofdsystem.synchronization;

class TestData
{
    public static final SYSTEM_VALID_DATA = CompileTime.readFile(
        "test/pw/tales/cofdsystem/synchronization/test_data/system_data_valid.json"
    );

    public static final GO_VALID_DATA = CompileTime.readFile("test/pw/tales/cofdsystem/synchronization/test_data/go_data_valid.json");
}
