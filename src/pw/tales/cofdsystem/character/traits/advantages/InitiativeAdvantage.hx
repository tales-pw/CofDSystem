package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.dices.pool.builder.PBTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageExpression;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.scene.initiative.events.InitiativeModifiersEvent;
import pw.tales.cofdsystem.utils.events.HandlerPriority;
import pw.tales.cofdsystem.weapon.traits.InitiativeMod;

@RegisterTraitTypes
@:expose("InitiativeAdvantage")
class InitiativeAdvantage extends AdvantageExpression {
    public static final DN = "Модификатор_Инициативы";
    public static final TYPE:TraitType<InitiativeMod> = cast TraitType.createType(DN, create);

    private static final EXPR = new PBTrait(DEXTERITY.getDN()).plus(new PBTrait(COMPOSURE.getDN()));

    public function new(gameObject:GameObject) {
        super(gameObject, TYPE, EXPR);
        this.eventBus.addHandler(InitiativeModifiersEvent, this.applyInitiativeMod, HandlerPriority.NORMAL);
    }

    private function applyInitiativeMod(event:InitiativeModifiersEvent) {
        var gameObject = event.getGameObject();
        event.apply(this.getValue());
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<InitiativeAdvantage>):InitiativeAdvantage {
        return new InitiativeAdvantage(gameObject);
    }
}
