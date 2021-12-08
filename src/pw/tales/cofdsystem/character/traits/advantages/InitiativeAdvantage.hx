package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.dices.pool.builder.PBTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageExpression;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.scene.initiative.events.InitiativeModifiersEvent;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("InitiativeAdvantage")
class InitiativeAdvantage extends AdvantageExpression
{
    public static final DN = "Модификатор_Инициативы";
    public static final TYPE = TraitType.createType(DN, InitiativeAdvantage.new);

    private static final EXPR = new PBTrait(DEXTERITY.getDN()).plus(new PBTrait(COMPOSURE.getDN()));

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, EXPR);
        this.eventBus.addHandler(
            InitiativeModifiersEvent,
            this.applyInitiativeMod,
            HandlerPriority.NORMAL
        );
    }

    private function applyInitiativeMod(event:InitiativeModifiersEvent):Void
    {
        event.apply(this.getValue());
    }
}
