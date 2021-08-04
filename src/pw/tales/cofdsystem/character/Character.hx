package pw.tales.cofdsystem.character;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.prefabs.Accessor;
import pw.tales.cofdsystem.game_object.traits.text.TextTraitType;

@RegisterTraitTypes
class Character extends Accessor
{
    public static final NAME = new TextTraitType("Name");
    public static final AGE = new TextTraitType("Age");
    public static final PLAYER = new TextTraitType("Player");

    public static final RACE = new TextTraitType("Race");
    public static final NATION = new TextTraitType("Nation");
    public static final LANGUAGE = new TextTraitType("Language");

    public static final VIRTUE = new TextTraitType("Добродетель");
    public static final VICE = new TextTraitType("Порок");
    public static final CONCEPT = new TextTraitType("Концепт");

    public function new(gameObject:GameObject)
    {
        super(gameObject);
    }

    public function getName():String
    {
        return this.getText(NAME);
    }
}
