package pw.tales.cofdsystem.serialization.system;

typedef DnData = {
    dn: String
}

typedef SimpleData = {
    > DnData,
    name:Null<String>
}

typedef AbilityData = {
    > DnData,
    name:Null<String>,
    cost:Null<Int>,
    levels:String,
    requirements:Array<String>
}

typedef WeaponData = {
    > DnData,
    name:Null<String>,
    damage:Int,
    initiative:Int,
    strength:Int,
    size:Int,
    tags:Array<String>
}

typedef ArmorData = {
    > DnData,
    name:Null<String>,
    strength:Int,
    speed:Int,
    general_armor:Int,
    ballistic_armor:Int,
    defence:Int,
    availability:String
}

typedef SystemData = {
    version:String,
    conditions:Map<String, SimpleData>,
    tilts:Map<String, SimpleData>,
    abilities:Map<String, AbilityData>,
    melee_weapons:Map<String, WeaponData>,
    ranged_weapons:Map<String, WeaponData>,
    armor:Map<String, ArmorData>,
    weapon_tags:Map<String, SimpleData>
}