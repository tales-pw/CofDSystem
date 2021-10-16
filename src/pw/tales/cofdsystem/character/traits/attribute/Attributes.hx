package pw.tales.cofdsystem.character.traits.attribute;

@RegisterTraitTypes
@:expose("Attributes")
class Attributes
{
    // Mental
    public static final INTELLIGENCE = new AttributeType("Интеллект", AttributePurpose.POWER, AttributeGroup.MENTAL);
    public static final WITS = new AttributeType("Смекалка", AttributePurpose.FINESSE, AttributeGroup.MENTAL);
    public static final RESOLVE = new AttributeType("Концентрация", AttributePurpose.RESISTANCE, AttributeGroup.MENTAL);

    // Physical
    public static final STRENGTH = new AttributeType("Сила", AttributePurpose.POWER, AttributeGroup.PHYSICAL);
    public static final DEXTERITY = new AttributeType("Ловкость", AttributePurpose.FINESSE, AttributeGroup.PHYSICAL);
    public static final STAMINA = new AttributeType("Выносливость", AttributePurpose.RESISTANCE, AttributeGroup.PHYSICAL);

    // Social
    public static final PRESENCE = new AttributeType("Харизма", AttributePurpose.POWER, AttributeGroup.SOCIAL);
    public static final MANIPULATION = new AttributeType("Манипулирование", AttributePurpose.FINESSE, AttributeGroup.SOCIAL);
    public static final COMPOSURE = new AttributeType("Хладнокровие", AttributePurpose.RESISTANCE, AttributeGroup.SOCIAL);
}
