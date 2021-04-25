package pw.tales.cofdsystem;

class Version {
    public static macro function get():haxe.macro.Expr.ExprOf<String> {
        var version = Sys.getEnv("RELEASE_VERSION");
        if (version == null) return macro "dev";
        return macro $v{version};
    }

    public static macro function shouldCheck():haxe.macro.Expr.ExprOf<Bool> {
        var version = Sys.getEnv("RELEASE_VERSION");
        if (version == null) return macro false;
        return macro true;
    }
}
