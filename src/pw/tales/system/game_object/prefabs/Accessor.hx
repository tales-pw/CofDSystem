package pw.tales.system.game_object.prefabs;

import pw.tales.system.game_object.traits.text.TextTrait;
import pw.tales.system.game_object.traits.text.TextTraitType;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;

class Accessor {
    private final gameObject:GameObject;
    private final traitManager:TraitManager;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
        this.traitManager = gameObject.getTraitManager();
    }

    public function getText(type:TextTraitType):String {
        var textTrait:Null<TextTrait> = cast this.traitManager.getTrait(type);
        if (textTrait == null) return "";
        return textTrait.getText();
    }

    public function getInt(type:TraitType<Dynamic>):Int {
        var intTrait:Null<Trait> = cast this.traitManager.getTrait(type);
        if (intTrait == null) return 0;
        return intTrait.getValue();
    }
}
