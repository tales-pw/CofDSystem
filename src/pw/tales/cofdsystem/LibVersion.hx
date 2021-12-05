package pw.tales.cofdsystem;

import thx.semver.Version;

class LibVersion
{
    #if macro
    private static function getVersionFromEnv(): String {
        return Sys.getEnv("RELEASE_VERSION");
    }
    #end

    public static macro function get():haxe.macro.Expr.ExprOf<String>
    {
        var version = LibVersion.getVersionFromEnv();
        return macro $v{version};
    }

    public static macro function shouldCheck():haxe.macro.Expr.ExprOf<Bool>
    {
        var version:Version = LibVersion.getVersionFromEnv();

        if (version.hasPre)
            return macro false;

        return macro true;
    }
}
