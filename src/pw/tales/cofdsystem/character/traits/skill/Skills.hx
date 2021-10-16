package pw.tales.cofdsystem.character.traits.skill;

import pw.tales.cofdsystem.character.traits.skill.events.SkillCollectEvent;
import pw.tales.cofdsystem.character.traits.skill.events.SkillGroupCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

@RegisterTraitTypes
@:expose("Skills")
class Skills
{
    // Mental
    public static final ACADEMICS = new SkillType("Эрудиция", SkillGroup.MENTAL);
    public static final ENIGMAS = new SkillType("Загадки", SkillGroup.MENTAL);
    public static final CRAFTS = new SkillType("Ремесло", SkillGroup.MENTAL);
    public static final INVESTIGATION = new SkillType("Расследование", SkillGroup.MENTAL);
    public static final MEDICINE = new SkillType("Медицина", SkillGroup.MENTAL);
    public static final OCCULT = new SkillType("Оккультизм", SkillGroup.MENTAL);
    public static final POLITICS = new SkillType("Политика", SkillGroup.MENTAL);
    public static final SCIENCE = new SkillType("Наука", SkillGroup.MENTAL);

    // Physical
    public static final ATHLETICS = new SkillType("Атлетика", SkillGroup.PHYSICAL);
    public static final BRAWL = new SkillType("Борьба", SkillGroup.PHYSICAL);
    public static final RIDE = new SkillType("Верховая езда", SkillGroup.PHYSICAL);
    public static final SHOOTING = new SkillType("Стрельба", SkillGroup.PHYSICAL);
    public static final LARCENY = new SkillType("Кража", SkillGroup.PHYSICAL);
    public static final STEALTH = new SkillType("Скрытность", SkillGroup.PHYSICAL);
    public static final SURVIVAL = new SkillType("Выживание", SkillGroup.PHYSICAL);
    public static final WEAPONRY = new SkillType("Холодное оружие", SkillGroup.PHYSICAL);

    // Social
    public static final ANIMAL_KEN = new SkillType("Знание_животных", SkillGroup.SOCIAL);
    public static final EMPATHY = new SkillType("Эмпатия", SkillGroup.SOCIAL);
    public static final EXPRESSION = new SkillType("Самовыражение", SkillGroup.SOCIAL);
    public static final INTIMIDATION = new SkillType("Запугивание", SkillGroup.SOCIAL);
    public static final PERSUASION = new SkillType("Убеждение", SkillGroup.SOCIAL);
    public static final SOCIALIZE = new SkillType("Социализация", SkillGroup.SOCIAL);
    public static final STREETWISE = new SkillType("Знание улиц", SkillGroup.SOCIAL);
    public static final SUBTERFUGE = new SkillType("Обман", SkillGroup.SOCIAL);

    public static function collect(gameObject:GameObject):Array<Skill>
    {
        var event = new SkillCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }

    public static function collectByGroup(gameObject:GameObject, group:SkillGroup):Array<Skill>
    {
        var event = new SkillGroupCollectEvent(gameObject, group);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
