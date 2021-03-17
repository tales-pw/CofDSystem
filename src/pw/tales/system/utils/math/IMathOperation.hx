package pw.tales.system.utils.math;

interface IMathOperation<T:Dynamic> {
    function getOperands():Array<IMathOperation<Dynamic>>;

    function calculate():T;
}
