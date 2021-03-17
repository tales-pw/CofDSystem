package pw.tales.system.utils.math;

class MathBinaryOperation<T:Dynamic> implements IMathOperation<T> {
    private var operand1:IMathOperation<T>;
    private var operand2:IMathOperation<T>;

    public function new(operand1:IMathOperation<T>, operand2:IMathOperation<T>) {
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    public function getOperands():Array<IMathOperation<Dynamic>> {
        return [this.operand1, this.operand2];
    }

    public function calculate():T {
        throw "Unimplemented";
    }
}
