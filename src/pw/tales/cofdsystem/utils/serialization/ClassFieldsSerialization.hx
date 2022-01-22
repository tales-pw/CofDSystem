package pw.tales.cofdsystem.utils.serialization;

import datetime.DateTime;
import haxe.rtti.CType;
import haxe.rtti.Rtti;

class ClassFieldsSerialization
{
    private final clazz:Class<Dynamic>;
    private var fieldTypes = new Map<String, CType>();

    public function new(clazz:Class<Dynamic>)
    {
        this.clazz = clazz;
    }

    public function init():ClassFieldsSerialization
    {
        if (!Rtti.hasRtti(clazz))
            return this;

        var rtti = Rtti.getRtti(this.clazz);

        for (field in rtti.fields)
        {
            this.fieldTypes.set(field.name, field.type);
        }

        return this;
    }

    private function serializeValue(value:Dynamic, type:CType):Dynamic
    {
        switch (type)
        {
            case CAbstract(name, params):
                if (name == "Null")
                    return this.serializeValue(value, params[0]);
                if (name == "datetime.DateTime")
                {
                    var datetime:DateTime = value;
                    return datetime.toString();
                }
                return value;
            default:
                return value;
        }
    }

    public function serialize(fieldName:String, value:Dynamic):Dynamic
    {
        var type = this.fieldTypes.get(fieldName);

        if (type == null)
            return value;

        return this.serializeValue(value, type);
    }

    private function deserializeValue(value:Dynamic, type:CType):Dynamic
    {
        switch (type)
        {
            case CAbstract(name, params):
                if (name == "Null")
                    return this.deserializeValue(value, params[0]);
                if (name == "datetime.DateTime")
                    return DateTime.fromString(value);
                return value;
            default:
                return value;
        }
    }

    public function deserialize(fieldName:String, value:Dynamic):Dynamic
    {
        var type = this.fieldTypes.get(fieldName);

        if (type == null)
            return value;

        return this.deserializeValue(value, type);
    }
}
