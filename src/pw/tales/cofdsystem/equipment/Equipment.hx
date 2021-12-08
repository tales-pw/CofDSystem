package pw.tales.cofdsystem.equipment;

import pw.tales.cofdsystem.equipment.traits.Equippable;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.prefabs.Accessor;

@:expose("Equipment")
class Equipment extends Accessor
{
    private function new(gameObject:GameObject)
    {
        super(gameObject);
    }

    public function getEquipper():Null<GameObject>
    {
        try
        {
            return this.ensureEquipable().getHolder();
        } catch (NoTraitAccessorException)
        {
            return null;
        }
    }

    private function ensureEquipable():Equippable
    {
        return this.getTrait(Equippable.TYPE);
    }

    private function setHolder(gameObject:GameObject):Void
    {
        try
        {
            this.ensureEquipable().setHolder(gameObject);
        } catch (NoTraitAccessorException) {}
    }

    private function unsetHolder():Void
    {
        try
        {
            this.ensureEquipable().unset();
        } catch (NoTraitAccessorException) {}
    }
}
