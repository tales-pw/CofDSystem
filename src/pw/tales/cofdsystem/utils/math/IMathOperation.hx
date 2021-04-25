package pw.tales.cofdsystem.utils.math;

interface IMathOperation<T:Dynamic> {
    function getOperands():Array<IMathOperation<Dynamic>>;

    function calculate():T;
}
