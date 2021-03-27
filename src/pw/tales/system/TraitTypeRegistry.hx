package pw.tales.system;

import haxe.DynamicAccess;
import haxe.rtti.Meta;
import pw.tales.system.character.traits.merits.Merit;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.registry.Registry;

class TraitTypeRegistry extends Registry<TraitType<Dynamic>> {
    public static final AUTOREGISTER_ANNOTATION = "RegisterTraitTypes";

    private final registartionMap:Map<String, Class<Dynamic>> = new Map();

    public function new() {
        super(true);

        this.autoregister();

        var customMeritType = Merit.CUSTOM_MERIT_TYPE;
        customMeritType.setName("Пользовательское Достоинство");
    }

    private function autoregister() {
        try {
            var classes = CompileTime.getAllClasses("pw.tales.system");
            for (clazz in classes) {
                var metadata:DynamicAccess<Dynamic> = Meta.getType(clazz);
                if (metadata.exists(AUTOREGISTER_ANNOTATION)) {
                    this.registerFromClass(clazz);
                }
            }
        } catch (e:haxe.Exception) {
            throw e;
        }
    }

    private function registerFromClass(clazz:Class<Dynamic>) {
        for (fieldName in Type.getClassFields(clazz)) {
            var field = Reflect.getProperty(clazz, fieldName);
            if (Std.isOfType(field, TraitType)) {
                var traitType:TraitType<Dynamic> = cast field;
                this.register(traitType);
                this.registartionMap.set(traitType.getDN(), clazz);
            }
        }
    }
}
