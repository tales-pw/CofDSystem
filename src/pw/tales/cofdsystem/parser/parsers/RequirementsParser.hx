package pw.tales.cofdsystem.parser.parsers;

import parsihax.ParseObject;
import parsihax.Parser;
import parsihax.ParseResult;
import parsihax.ParseUtil;
import pw.tales.cofdsystem.parser.nodes.INodeCheck;
import pw.tales.cofdsystem.parser.nodes.NodeAnd;
import pw.tales.cofdsystem.parser.nodes.NodeDots;
import pw.tales.cofdsystem.parser.nodes.NodeGroup;
import pw.tales.cofdsystem.parser.nodes.NodeOr;
import pw.tales.cofdsystem.parser.nodes.NodeString;
import pw.tales.cofdsystem.parser.nodes.NodeTrait;
import pw.tales.cofdsystem.parser.nodes.NodeTraitRequirement;
import pw.tales.cofdsystem.parser.ParserHelper;

using parsihax.Parser;

@:expose
@:expose("RequirementsParser")
class RequirementsParser extends Parser
{
    private static final AND_LITERAL = [" и ".string(), ", ".string()].alt().as("separator");
    private static final OR_LITERAL = " или ".string().as("separator");

    private static final LB_GROUP = "(".string();
    private static final RB_GROUP = ")".string();

    private static final LB_STRING = "{".string();
    private static final RB_STRING = "}".string();

    public static final STATEMENT_END:ParseObject<Dynamic> = [OR_LITERAL, AND_LITERAL, Parser.eof()].alt();

    public static final FULL_PARSER:ParseObject<INodeCheck> = (function()
    {
        var andReqC:ParseObject<Dynamic> = AND;
        var orReqC:ParseObject<Dynamic> = OR;
        var a:Array<ParseObject<Dynamic>> = [GROUP, Parser.or(andReqC, orReqC), STATEMENT];
        return a.alt();
    }).lazy();

    public static final STATEMENT:ParseObject<INodeCheck> = (function()
    {
        var a:Array<ParseObject<Dynamic>> = [TRAIT_STATEMENT, STRING_STATEMENT];
        return ParserHelper.inBondaries(a.alt(), STATEMENT_END);
    }).lazy();

    public static final TRAIT_VALUE:ParseObject<NodeDots> = DotsLevelsParser.DOTS.as("trait value");
    public static final TRAIT_DN:ParseObject<NodeTrait> = ParserHelper.takeWhileNo(Parser.whitespace().then(TRAIT_VALUE))
        .map(function(v) return new NodeTrait(v))
        .as("trait dn");

    private static final ARRAY1:Array<ParseObject<Dynamic>> = [TRAIT_DN.skip(Parser.whitespace()), TRAIT_VALUE];
    public static final TRAIT_STATEMENT:ParseObject<NodeTraitRequirement> = ARRAY1.seq().map(function(values)
    {
        var dn:NodeTrait = cast(values[0]);
        var dots:NodeDots = cast(values[1]);
        return new NodeTraitRequirement(dn, dots);
    });

    public static final STRING_STATEMENT:ParseObject<NodeString> = ParserHelper.inBondaries(Parser.all(), STATEMENT_END).map(function(value)
    {
        return new NodeString(value);
    }).as("string");

    private static final ARRAY2:Array<ParseObject<Dynamic>> = [STATEMENT, AND_LITERAL, FULL_PARSER];
    public static final AND:ParseObject<NodeAnd> = ARRAY2.seq().map(function(values)
    {
        var castedResult = cast(values, Array<Dynamic>);
        var node1 = cast(castedResult[0], INodeCheck);
        var node2 = cast(castedResult[2], INodeCheck);
        var separator:String = values[1];
        return new NodeAnd(node1, node2, separator);
    });

    private static final ARRAY3:Array<ParseObject<Dynamic>> = [STATEMENT, OR_LITERAL, FULL_PARSER];
    public static final OR:ParseObject<NodeOr> = ARRAY3.seq().map(function(values)
    {
        var castedResult = cast(values, Array<Dynamic>);
        var node1 = cast(castedResult[0], INodeCheck);
        var node2 = cast(castedResult[2], INodeCheck);
        var separator:String = values[1];
        return new NodeOr(node1, node2, separator);
    });

    private static final ARRAY4:Array<ParseObject<Dynamic>> = [LB_GROUP, FULL_PARSER, RB_GROUP];
    public static final GROUP:ParseObject<NodeGroup> = ARRAY4.seq().map(function(values)
    {
        return new NodeGroup(values[1]);
    });

    public function new() {}

    public function parse(data:String):INodeCheck
    {
        var result:ParseResult<INodeCheck> = FULL_PARSER.apply(data);
        if (!result.status)
            throw ParseUtil.formatError(result, data);
        return result.value;
    }
}
