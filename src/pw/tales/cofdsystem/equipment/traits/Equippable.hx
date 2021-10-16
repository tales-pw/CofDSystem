package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class Equippable extends Trait
{
    public static final DN = "Equippable";
    public static final TYPE:TraitType<Equippable> = TraitType.createType(DN, Equippable.new);

    private var holder:Null<GameObject> = null;

    public function setHolder(holder:GameObject): Void
    {
        this.holder = holder;
        this.notifyUpdated();
    }

    public function getHolder():Null<GameObject>
    {
        return this.holder;
    }

    public function unset(): Void
    {
        this.holder = null;
        this.notifyUpdated();
    }
}
