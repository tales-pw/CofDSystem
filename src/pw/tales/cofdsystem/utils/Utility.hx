package pw.tales.cofdsystem.utils;

typedef Item<K, V> = {
    key:K,
    value:V
}

class Utility
{
    public inline static function values<K, V>(map:Map<K, V>):Array<V>
    {
        return [for (item in map.keyValueIterator()) item.value];
    }

    public inline static function items<K, V>(map:Map<K, V>):Array<Item<K, V>>
    {
        return [for (item in map.keyValueIterator()) item];
    }

    public inline static function sortedItems<K, V:Int>(map:Map<K, V>):Array<Item<K, V>>
    {
        var array = Utility.items(map);
        array.sort((a:Item<K, V>, b:Item<K, V>) -> b.value - a.value);
        return array;
    }

    public inline static function replace<T>(array:Array<T>, value:T, replaceWith:T)
    {
        return [for (arrayValue in array) if (arrayValue == value) replaceWith else arrayValue];
    }

    @:nullSafety(Off)
    public static function downcast<S>(value:Null<Dynamic>, c:Class<S>):Null<S>
    {
        return cast Std.downcast(value, cast(c));
    }

    public static function getClassName(clazz:Class<Dynamic>):String
    {
        var name = Type.getClassName(clazz);
        var parts = name.split(".");
        return parts[parts.length - 1];
    }
}
