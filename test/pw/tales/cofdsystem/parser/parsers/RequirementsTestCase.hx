package pw.tales.cofdsystem.parser.parsers;

class RequirementsTestCase extends haxe.unit.TestCase {
    public static var parser = new RequirementsParser();

    public function testSimpleGrammar() {
        var result = parser.parse("Выносливость 3");
        assertEquals("[[Выносливость]] •••", result.getHumanReadable());
    }

    public function testAndGrammar() {
        var result = parser.parse("Внимательность 3, Выносливость 4, Сила 5");
        assertEquals("[[Внимательность]] •••, [[Выносливость]] ••••, [[Сила]] •••••", result.getHumanReadable());
    }

    public function testOrGrammar() {
        var result = parser.parse("Внимательность 3 или Выносливость 4");
        assertEquals("[[Внимательность]] ••• или [[Выносливость]] ••••", result.getHumanReadable());
    }

    public function testMixedGrammar() {
        var result = parser.parse("Внимательность 2 или Внимательность 1 и Выносливость 3");
        assertEquals("[[Внимательность]] •• или [[Внимательность]] • и [[Выносливость]] •••", result.getHumanReadable());
    }

    public function testParenthesesGrammar() {
        var result = parser.parse("Внимательность 2 или (Внимательность 1 и Выносливость 3)");
        assertEquals("[[Внимательность]] •• или ([[Внимательность]] • и [[Выносливость]] •••)", result.getHumanReadable());
    }

    public function testTraitDnWithSpaceGrammar() {
        var result = parser.parse("Холодное оружие 2");
        assertEquals("[[Холодное оружие]] ••", result.getHumanReadable());
    }

    public function testParserRespectWhatSymoblsUserUse() {
        var result = parser.parse("Внимательность 2 и Внимательность 2, Внимательность 2 и Внимательность 2");
        assertEquals(
            "[[Внимательность]] •• и [[Внимательность]] ••, [[Внимательность]] •• и [[Внимательность]] ••",
            result.getHumanReadable()
        );
    }

    public function testCustomString() {
        var result = parser.parse("текст текст текст и Сила 2");
        assertEquals("текст текст текст и [[Сила]] ••", result.getHumanReadable());

        var result = parser.parse("текст текст текст");
        assertEquals("текст текст текст", result.getHumanReadable());

        var result = parser.parse("Внимательность 2 и текст текст текст");
        assertEquals("[[Внимательность]] •• и текст текст текст", result.getHumanReadable());

        var result = parser.parse("Внимательность 2 и текст текст текст и Сила 2");
        assertEquals("[[Внимательность]] •• и текст текст текст и [[Сила]] ••", result.getHumanReadable());
    }
}
