package pw.tales.system.game_object.prefabs;

import pw.tales.system.game_object.traits.text.TextTrait;
import pw.tales.system.game_object.traits.text.TextTraitType;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;

/**
* Common class for wrapping GameObject to implement simplified
* access to traits with getters. Mostly for traits added by prefabs.
*
* Rules to follow when implementing Accessor:
* 1) Getters should dynamically get Trait object in case it will be
*    removed from GameObject later.
* 2) If there is no Trait in GameObject, getters should return
*    default value or throw exception.
*
* You may implement other logic in subclass (not just getter)
* but it should follow rules above
*
* Example of such class, getting character name:
* >>> new Character(gameObject).getName()
**/
class Accessor {
    private final gameObject:GameObject;
    private final traitManager:TraitManager;

    private function new(gameObject:GameObject) {
        this.gameObject = gameObject;
        this.traitManager = gameObject.getTraitManager();
    }

    private function getText(type:TextTraitType):String {
        var textTrait:Null<TextTrait> = cast this.traitManager.getTrait(type);
        if (textTrait == null) return "";
        return textTrait.getText();
    }

    private function getInt(type:TraitType<Dynamic>):Int {
        var intTrait:Null<Trait> = cast this.traitManager.getTrait(type);
        if (intTrait == null) return 0;
        return intTrait.getValue();
    }
}
