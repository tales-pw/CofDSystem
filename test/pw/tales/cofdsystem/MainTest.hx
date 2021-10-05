package pw.tales.cofdsystem;

import pw.tales.cofdsystem.utils.Utility;
import haxe.unit.TestRunner;

class MainTest
{
    static public function shouldSkip(test:haxe.unit.TestCase):Bool
    {
        var testSkip = Utility.downcast(test, WithBaseTest);

        if (testSkip == null)
        {
            return false;
        }

        return testSkip.getBaseTest() == Type.getClass(test);
    }

    static public function main()
    {
        var r = new TestRunner();

        var testClasses = CompileTime.getAllClasses("pw.tales.cofdsystem", true, haxe.unit.TestCase);

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
