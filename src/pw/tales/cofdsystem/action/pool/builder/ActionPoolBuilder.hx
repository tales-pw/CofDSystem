package pw.tales.cofdsystem.action.pool.builder;

import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.game_object.GameObject;

class ActionPoolBuilder
{
    public static final CUSTOM_MODIFIER = "Модификатор";

    private final gameObject:GameObject;
    private var modifier:Int = 0;
    private var traits:Array<String> = [];
    private var explode:EnumExplode = EnumExplode.DEFAULT;

    public function new(gameObject:GameObject)
    {
        this.gameObject = gameObject;
    }

    public function setModifier(modifier:Int):ActionPoolBuilder
    {
        this.modifier = modifier;
        return this;
    }

    public function setExplode(explode:EnumExplode):ActionPoolBuilder
    {
        this.explode = explode;
        return this;
    }

    public function setTraits(traits:Array<String>):ActionPoolBuilder
    {
        this.traits = traits;
        return this;
    }

    public function build():ActionPool
    {
        final actionPool = new ActionPool(this.gameObject, this.traits);

        // Set custom modifer
        final request = actionPool.getRequest();
        request.addModifier(this.modifier, CUSTOM_MODIFIER);
        request.addIgnoreLimit(CUSTOM_MODIFIER);

        // Set explode
        request.setExplode(this.explode);

        return actionPool;
    }
}
