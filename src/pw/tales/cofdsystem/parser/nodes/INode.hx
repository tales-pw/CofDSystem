package pw.tales.cofdsystem.parser.nodes;

interface INode
{
    function getHumanReadable():String;

    function serialize():String;
}
