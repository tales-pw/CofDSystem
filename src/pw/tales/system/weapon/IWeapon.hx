package pw.tales.system.weapon;

import pw.tales.system.game_object.traits.TraitType;

interface IWeapon {
    function getInitiativeMod():Int;

    function getDamageMod():Int;

    function getWeaponTags():Array<TraitType<Dynamic>>;
}
