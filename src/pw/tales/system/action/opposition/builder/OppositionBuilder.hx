package pw.tales.system.action.opposition.builder;

import pw.tales.system.action.opposition.base.Opposition;
import pw.tales.system.action.opposition.base.OppositionCompetitive;
import pw.tales.system.action.opposition.Contested;
import pw.tales.system.action.opposition.pool.ActionPool;
import pw.tales.system.action.opposition.Resisted;
import pw.tales.system.action.opposition.Simple;
import pw.tales.system.common.EnumSide;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.registry.IRecord;
import thx.Uuid;

class OppositionBuilder implements IRecord {
    private var oppositionType:Null<EnumOpposition> = null;

    private var actor:Null<GameObject> = null;
    private var target:Null<GameObject> = null;

    public var actorModifier:Int = 0;
    public var targetModifier:Int = 0;

    public var actorTraits:Array<String> = [];
    public var targetTraits:Array<String> = [];

    private var dn:String = Uuid.create();

    public static final CUSTOM_MODIFIER = "Модификатор";

    public function new() {}

    public function getActor():Null<GameObject> {
        return this.actor;
    }

    public function setActor(gameObject:GameObject):OppositionBuilder {
        this.actor = gameObject;
        return this;
    }

    public function getTarget():Null<GameObject> {
        return this.target;
    }

    public function setTarget(gameObject:GameObject):OppositionBuilder {
        this.target = gameObject;
        return this;
    }

    public function getDN():String {
        return this.dn;
    }

    public function setDN(dn:String):OppositionBuilder {
        this.dn = dn;
        return this;
    }

    public function setModifier(side:EnumSide, modifier:Int):OppositionBuilder {
        if (side == EnumSide.ACTOR) this.actorModifier = modifier;
        if (side == EnumSide.TARGET) this.targetModifier = modifier;
        return this;

    }

    public function setTraits(side:EnumSide, traits:Array<String>):OppositionBuilder {
        if (side == EnumSide.ACTOR) this.actorTraits = traits;
        if (side == EnumSide.TARGET) this.targetTraits = traits;
        return this;
    }

    public function setOppositionType(opposition:EnumOpposition):OppositionBuilder {
        this.oppositionType = opposition;
        return this;
    }

    private function prepareActor(opposition:Opposition) {
        var roll:ActionPool = opposition.getActorPool();
        final request = roll.getRequest();
        request.addModifier(this.actorModifier, CUSTOM_MODIFIER);
        request.addIgnoreLimit(CUSTOM_MODIFIER);
    }

    private function prepareTarget(opposition:OppositionCompetitive) {
        var roll:ActionPool = opposition.getTargetPool();
        final request = roll.getRequest();
        request.addModifier(this.targetModifier, CUSTOM_MODIFIER);
        request.addIgnoreLimit(CUSTOM_MODIFIER);
    }

    private function createSimple():Simple {
        if (this.actor == null) throw "Actor is needed";

        var actorRoll = new ActionPool(actor, this.actorTraits);
        var opposition:Simple = new Simple(actorRoll, 0);

        return opposition;
    }

    private function createResisted():Resisted {
        if (this.actor == null) throw "Actor is needed";
        if (this.target == null) throw "Target is needed";

        var actorRoll = new ActionPool(actor, this.actorTraits);
        var targetRoll = new ActionPool(target, this.targetTraits);
        var opposition:Resisted = new Resisted(actorRoll, targetRoll);

        this.prepareActor(opposition);
        this.prepareTarget(opposition);
        return opposition;
    }

    private function createContested():Contested {
        if (this.actor == null) throw "Actor is needed";
        if (this.target == null) throw "Target is needed";

        var actorRoll = new ActionPool(actor, this.actorTraits);
        var targetRoll = new ActionPool(target, this.targetTraits);
        var opposition:Contested = new Contested(actorRoll, targetRoll);

        this.prepareActor(opposition);
        this.prepareTarget(opposition);
        return opposition;
    }

    public function build():Opposition {
        var obj:Opposition;

        if (this.oppositionType == null) {
            throw "You should choose opposition type (Simple, Resisted, Contested).";
        }

        switch this.oppositionType {
            case EnumOpposition.SIMPLE:
                obj = this.createSimple();
            case EnumOpposition.RESISTED:
                obj = this.createResisted();
            case EnumOpposition.CONTESTED:
                obj = this.createContested();
        }

        return obj;
    }

    public function toString() {
        return 'OppositionBuilder[dn=${this.getDN()}, ${this.actorTraits.join(" + ")} vs ${this.targetTraits.join("+")}]';
    }
}
