package pw.tales.system.utils.math;

class MathMore implements IMathOperation<Bool> {
    private var operand1:IMathOperation<Int>;
    private var operand2:IMathOperation<Int>;

    public function new(arg1:IMathOperation<Int>, arg2:IMathOperation<Int>) {
        this.operand1 = arg1;
        this.operand2 = arg2;
    }

    public function getOperands():Array<IMathOperation<Dynamic>> {
        return [this.operand1, this.operand2];
    }

    public function calculate():Bool {
        return this.operand1.calculate() > this.operand2.calculate();
    }
}
