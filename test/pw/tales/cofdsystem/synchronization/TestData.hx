package pw.tales.cofdsystem.synchronization;

class TestData
{
    public static final SYSTEM_VALID_DATA = CompileTime.readFile(
        "test/pw/tales/cofdsystem/synchronization/test_data/system_data_valid.json"
    );

    public static final GO_VALID_DATA = CompileTime.readFile(
        "test/pw/tales/cofdsystem/synchronization/test_data/go_data_valid.json"
    );

    public static final SYSTEM_DATA_REMOTE_WEAPON_TAG = CompileTime.readFile(
        "test/pw/tales/cofdsystem/synchronization/test_data/system_data_remote_weapon_tag.json"
    );

    public static final SYSTEM_DATA_REMOTE_CONDITION = CompileTime.readFile(
        "test/pw/tales/cofdsystem/synchronization/test_data/system_data_remote_condition.json"
    );

    public static final SYSTEM_DATA_REMOTE_TILT = CompileTime.readFile(
        "test/pw/tales/cofdsystem/synchronization/test_data/system_data_remote_tilt.json"
    );
}
