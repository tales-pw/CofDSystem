package pw.tales.cofdsystem.dices;

interface IRollRequest {
    function getThreshold():Int;

    function getExplode():EnumExplode;

    function getPoolSize():Int;
}
