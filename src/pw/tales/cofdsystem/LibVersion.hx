package pw.tales.cofdsystem;

import thx.semver.Version;

class LibVersion
{
    public static macro function get():haxe.macro.Expr.ExprOf<String>
    {
        var version = Sys.getEnv("RELEASE_VERSION");
        return macro $v{version};
    }

    public static macro function shouldCheck():haxe.macro.Expr.ExprOf<Bool>
    {
        var version:Version = Sys.getEnv("RELEASE_VERSION");

        if (version.hasPre)
            return macro false;

        return macro true;
    }
}
