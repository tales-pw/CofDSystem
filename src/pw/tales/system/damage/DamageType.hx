package pw.tales.system.damage;

enum abstract DamageType(String) {
    var BASHING;
    var LETHAL;
    var AGGRAVATED;

    public static var ORDER = [DamageType.BASHING, DamageType.LETHAL, DamageType.AGGRAVATED];

    public static function isMoreSevere(damageType:DamageType, otherDamageType:DamageType):Bool {
        return ORDER.indexOf(damageType) >= ORDER.indexOf(otherDamageType);
    }
}