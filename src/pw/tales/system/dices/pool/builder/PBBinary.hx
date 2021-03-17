package pw.tales.system.dices.pool.builder;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;

typedef BinaryProducer = (IMathOperation<Int>, IMathOperation<Int>) -> IMathOperation<Int>;

class PBBinary extends PoolBuilder {
    private final producer:BinaryProducer;
    private final operand1:IPoolBuilder;
    private final operand2:IPoolBuilder;

    public function new(producer:BinaryProducer, operand1:IPoolBuilder, operand2:IPoolBuilder) {
        super();
        this.producer = producer;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    override public function build(gameObject:GameObject):IMathOperation<Int> {
        return producer(this.operand1.build(gameObject), this.operand2.build(gameObject));
    }
}
