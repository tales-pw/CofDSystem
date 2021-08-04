package pw.tales.cofdsystem.utils.serialization;

import haxe.DynamicAccess;
import haxe.rtti.Meta;

typedef SerializationOptions = {
    serializeKey:String,
    optional:Bool
}

@:nullSafety(Off)
class AnnotationSerialization
{
    public static final SERIALIZE_ANNOTATION:String = "Serialize";
    public static final OPTIONAL_ANNOTATION:String = "Optional";

    public static function apply(base:DynamicAccess<Dynamic>, ext:DynamicAccess<Dynamic>):DynamicAccess<Dynamic>
    {
        for (f in ext.keys())
            base.set(f, ext.get(f));
        return base;
    }

    public static function gatherMetadata(o:Dynamic):DynamicAccess<Dynamic>
    {
        var clazz = Type.getClass(o);
        var metadata:DynamicAccess<Dynamic> = {};
        while (clazz != null)
        {
            metadata = apply(metadata, Meta.getFields(clazz));
            clazz = Type.getSuperClass(clazz);
        }

        return metadata;
    }

    private static function getSerializeKey(field:String, annotations:DynamicAccess<Dynamic>):String
    {
        var serializeKey = field;
        var args:Array<Dynamic> = cast(annotations.get(SERIALIZE_ANNOTATION));
        if (args.length > 0)
            serializeKey = args[0];
        return serializeKey;
    }

    private static function parseAnnotations(field:String, annotations:DynamicAccess<Dynamic>):SerializationOptions
    {
        if (!annotations.exists(SERIALIZE_ANNOTATION))
            return null;

        return {
            serializeKey: getSerializeKey(field, annotations),
            optional: annotations.exists(OPTIONAL_ANNOTATION)
        };
    }

    public static function serialize(object:Dynamic):Dynamic
    {
        var metadata:DynamicAccess<Dynamic> = gatherMetadata(object);

        var access:DynamicAccess<Dynamic> = object;
        var data:DynamicAccess<Dynamic> = {};

        for (keyvalue in metadata.keyValueIterator())
        {
            var field:String = keyvalue.key;
            var annotations:DynamicAccess<Dynamic> = cast(keyvalue.value);
            var options = parseAnnotations(field, annotations);

            if (options != null)
            {
                var serializeKey = options.serializeKey;
                var serialzeValue:Dynamic = access.get(field);
                data.set(serializeKey, serialzeValue);
            }
        }

        return data;
    }

    public static function deserialize(object:Dynamic, data:DynamicAccess<Dynamic>):Dynamic
    {
        var metadata:DynamicAccess<Dynamic> = gatherMetadata(object);

        for (keyvalue in metadata.keyValueIterator())
        {
            var field:String = keyvalue.key;
            var annotations:DynamicAccess<Dynamic> = cast(keyvalue.value);
            var options = parseAnnotations(field, annotations);

            if (options == null)
                continue;

            var serializeKey = options.serializeKey;

            if (data.exists(serializeKey))
            {
                var value:Dynamic = data.get(serializeKey);
                Reflect.setField(object, field, value);
            } else
            {
                if (!options.optional)
                {
                    throw new DeserializationException(data, field);
                }
            }
        }

        return data;
    }
}
