package pw.tales.cofdsystem.parser.parsers;

import parsihax.ParseObject;
import parsihax.ParseResult;
import pw.tales.cofdsystem.parser.exception.ParsingException;
import pw.tales.cofdsystem.parser.nodes.INodePoolBuilder;
import pw.tales.cofdsystem.parser.nodes.NodeInversion;
import pw.tales.cofdsystem.parser.nodes.NodeNumber;
import pw.tales.cofdsystem.parser.nodes.NodePoolSum;
import pw.tales.cofdsystem.parser.nodes.NodeTrait;

using parsihax.Parser;

@:expose("ParserPool")
class ParserPool
{
    public static final FULL_PARSER:ParseObject<INodePoolBuilder> = (function()
    {
        var a:Array<ParseObject<Dynamic>> = [PLUS, MINUS, TRAIT];
        return a.alt();
    }).lazy();

    private static final PLUS_LITERAL = "+".string().as("plus");
    private static final MINUS_LITERAL = "-".string().as("minus");

    private static final TRAIT = ParserHelper.takeWhileNo([PLUS_LITERAL, MINUS_LITERAL, Parser.eof()].alt()).map(function(value)
    {
        return new NodeTrait(value);
    });

    private static final NUMBER = Parser.digits().map(function(result)
    {
        var parsedInt = Std.parseInt(result);
        if (parsedInt == null)
            parsedInt = 0;
        return new NodeNumber(parsedInt);
    }).as("number");

    private static final ARRAY2:Array<ParseObject<Dynamic>> = [TRAIT.skip(PLUS_LITERAL), FULL_PARSER];
    public static final PLUS:ParseObject<Dynamic> = ARRAY2.seq().map(function(values)
    {
        return new NodePoolSum(values[0], values[1]);
    });

    private static final ARRAY3:Array<ParseObject<Dynamic>> = [TRAIT.skip(MINUS_LITERAL), FULL_PARSER];
    public static final MINUS:ParseObject<Dynamic> = ARRAY3.seq().map(function(values)
    {
        return new NodePoolSum(values[0], new NodeInversion(values[1]));
    });

    public function new() {}

    public function parse(data:String):INodePoolBuilder
    {
        var result:ParseResult<INodePoolBuilder> = FULL_PARSER.apply(data);
        if (!result.status)
            throw new ParsingException(result.expected.toString());
        return result.value;
    }
}
