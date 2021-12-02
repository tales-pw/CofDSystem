package pw.tales.cofdsystem;

import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;
import pw.tales.cofdsystem.armor.prefabs.ArmorPrefab;
import pw.tales.cofdsystem.dices.DiceRoller;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.EventBus;
import pw.tales.cofdsystem.utils.registry.Registry;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;

@:expose("CofDSystem")
class CofDSystem
{
    public static final VERSION = LibVersion.get();
    public static final VERSION_CHECK = LibVersion.shouldCheck();

    public var dices:DiceRoller = new DiceRoller();

    public final gameObjects = new Registry<GameObject>();
    public final traits = new TraitTypeRegistry();

    public final weapons = new Registry<WeaponPrefab>(true);
    public final armors = new Registry<ArmorPrefab>(true);

    public var events = new EventBus();

    public function new() {}

    public static function fromData(data: Dynamic): CofDSystem {
        return SystemSerialization.INSTANCE.fromData(data);
    }
}
