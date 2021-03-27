package pw.tales.system;

import pw.tales.system.action.IAction;
import pw.tales.system.armor.prefabs.ArmorPrefab;
import pw.tales.system.dices.DiceRoller;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.events.EventBus;
import pw.tales.system.utils.registry.Registry;
import pw.tales.system.weapon.prefabs.WeaponPrefab;

@:keep
@:expose('CofDSystem')
class CofDSystem {
    public static final version = Version.get();
    public static final versionCheck = Version.shouldCheck();

    public var dices:DiceRoller = new DiceRoller();

    public final gameObjects = new Registry<GameObject>();
    public final traits = new TraitTypeRegistry();

    public final weapons = new Registry<WeaponPrefab>(true);
    public final armors = new Registry<ArmorPrefab>(true);

    public var events = new EventBus();

    public function new() {}

    public function act(action:IAction) {
        action.execute();
    }
}
