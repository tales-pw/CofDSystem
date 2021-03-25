package pw.tales.system;

class Version {
    public static macro function get():haxe.macro.Expr.ExprOf<String> {
        var version = Sys.getEnv("RELEASE_VERSION");
        if (version == null) return macro "dev";
        return macro $v{version};
    }
}
