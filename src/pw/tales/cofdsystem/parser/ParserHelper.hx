package pw.tales.cofdsystem.parser;

import parsihax.ParseObject;
import parsihax.Parser;
import parsihax.ParseResult;
import parsihax.ParseUtil;

typedef SearchResult = {
    status:Bool,
    index:Null<Int>,
    furthest:Null<Int>
}

@:nullSafety(Off)
class ParserHelper extends Parser
{
    private static function find(parser:ParseObject<Dynamic>, stream:String, i:Int):SearchResult
    {
        var furthest:Int = i;

        for (v in i...stream.length)
        {
            var endResult:ParseResult<Dynamic> = parser.apply(stream, v);
            if (endResult.status)
                return {status: true, index: v, furthest: null};
        }

        return {status: false, index: null, furthest: furthest};
    }

    public static function inBondaries<A>(parser:ParseObject<A>, endTerm:ParseObject<Dynamic>):ParseObject<A>
    {
        return function(stream:String, i:Int = 0)
        {
            var toProcess = stream;

            var end = ParserHelper.find(endTerm, stream, i);
            if (end.status)
                toProcess = stream.substring(0, end.index);

            return parser.apply(toProcess, i);
        }
    }

    public static function takeWhileNo<A>(parser:ParseObject<A>):ParseObject<String>
    {
        return function(stream:String, i:Int = 0)
        {
            var end = ParserHelper.find(parser, stream, i);

            if (end.status)
                return ParseUtil.makeSuccess(end.index, stream.substring(i, end.index));

            return ParseUtil.makeFailure(end.furthest, Std.string(parser));
        };
    }
}
