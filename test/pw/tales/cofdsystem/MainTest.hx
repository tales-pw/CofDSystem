package pw.tales.cofdsystem;

import pw.tales.cofdsystem.utils.Utility;
import haxe.unit.TestRunner;
import haxe.unit.TestCase;

class MainTest
{
    static public function shouldSkip(test:TestCase):Bool
    {
        var testSkip = Utility.downcast(test, WithBaseTest);

        if (testSkip == null)
        {
            return false;
        }

        return testSkip.getBaseTest() == Type.getClass(test);
    }

    static public function main():Void
    {
        var r = new TestRunner();

        var testClasses = CompileTime.getAllClasses(
            "pw.tales.cofdsystem",
            true,
            TestCase
        );

        for (clazz in testClasses)
        {
            var test = Type.createInstance(clazz, []);

            if (!shouldSkip(test))
            {
                r.add(test);
            }
        }

        r.run();
    }
}
