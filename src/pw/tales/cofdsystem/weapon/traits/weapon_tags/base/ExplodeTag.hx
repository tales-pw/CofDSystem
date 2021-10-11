package pw.tales.cofdsystem.weapon.traits.weapon_tags.base;

import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import thx.error.NotImplemented;
import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.GameObject;

class ExplodeTag extends WeaponTag
{
    private function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(ActionBuildPoolEvent, this.applyExplode);
    }

    public function applyExplode(e:ActionBuildPoolEvent):Void
    {
        var action = e.getAction();
        var pool = e.getActionPool();

        // Is this holder's pool event.
        if (!this.isHolderPool(pool))
            return;

        // Is this holder's attack action.
        if (!this.isHolderAttack(action))
            return;

        final explode = this.getExplode();
        e.getActionPool().getRequest().setExplode(explode);
    }

    public function getExplode():EnumExplode
    {
        throw new NotImplemented();
    }
}
