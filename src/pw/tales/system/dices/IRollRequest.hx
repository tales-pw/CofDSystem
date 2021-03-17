package pw.tales.system.dices;

interface IRollRequest {
    function getThreshold():Int;

    function getExplode():EnumExplode;

    function getPoolSize():Int;
}
