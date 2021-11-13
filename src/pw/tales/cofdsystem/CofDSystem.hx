package pw.tales.cofdsystem;

import pw.tales.cofdsystem.action.IAction;
import pw.tales.cofdsystem.armor.prefabs.ArmorPrefab;
import pw.tales.cofdsystem.dices.DiceRoller;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.EventBus;
import pw.tales.cofdsystem.utils.registry.Registry;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;

@:expose("CofDSystem")
class CofDSystem
{
    public static final version = LibVersion.get();
    public static final versionCheck = LibVersion.shouldCheck();

    public var dices:DiceRoller = new DiceRoller();

    public final gameObjects = new Registry<GameObject>();
    public final traits = new TraitTypeRegistry();

    public final weapons = new Registry<WeaponPrefab>(true);
    public final armors = new Registry<ArmorPrefab>(true);

    public var events = new EventBus();

    public function new() {}

    public function act(action:IAction)
    {
        action.execute();
    }
}
