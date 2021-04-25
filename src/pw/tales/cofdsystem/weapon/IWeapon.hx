package pw.tales.cofdsystem.weapon;

import pw.tales.cofdsystem.game_object.traits.TraitType;

interface IWeapon {
    function getInitiativeMod():Int;

    function getDamageMod():Int;

    function getWeaponTags():Array<TraitType<Dynamic>>;
}
