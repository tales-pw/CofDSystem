package pw.tales.system.parser.parsers;

import Array;
import parsihax.ParseObject;
import parsihax.ParseResult;
import pw.tales.system.parser.nodes.INodeLevels;
import pw.tales.system.parser.nodes.NodeDots;
import pw.tales.system.parser.nodes.NodeDotsOr;
import pw.tales.system.parser.nodes.NodeDotsRange;
using parsihax.Parser;

@SuppressWarnings("checkstyle:Type")
class DotsLevelsParser {
    private static final OR_LITERAL = " или ".string();
    private static final FROM_LITER = "от ".string();
    private static final TO_LITERAL = " до ".string();
    private static final NUMBER_LITERAL = ~/-?(0|[1-9][0-9]*)/.regexp();

    public function new() {}

    public static final FULL_PARSER:ParseObject<INodeLevels> = (function() {
        var a:Array<ParseObject<Dynamic>> = [DOTS_RANGEs, DOTS_OR, DOTS];
        return a.alt();
    }).lazy();

    public static final DOTS:ParseObject<NodeDots> = NUMBER_LITERAL.map(function(result) {
        var value = Std.parseInt(result);
        if (value == null) throw "Cannot parse int";
        return new NodeDots(value);
    });

    private static final ARRAY1:Array<ParseObject<Dynamic>> = [FROM_LITER, DOTS, TO_LITERAL, DOTS];
    public static final DOTS_RANGEs:ParseObject<NodeDotsRange> = ARRAY1.seq().map(function(values) {
        return new NodeDotsRange(values[1], values[3]);
    });

    private static final ARRAY2:Array<ParseObject<Dynamic>> = [DOTS.skip(OR_LITERAL), FULL_PARSER];
    public static final DOTS_OR:ParseObject<NodeDotsOr> = ARRAY2.seq().map(function(values) {
        return new NodeDotsOr(values[0], values[1]);
    });

    public function parse(data:String):INodeLevels {
        var result:ParseResult<INodeLevels> = FULL_PARSER.apply(data);
        if (!result.status) throw 'Parsing error: ${result.expected.toString()}';
        return result.value;
    }
}
