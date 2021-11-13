package pw.tales.cofdsystem.character.traits.position;

import thx.error.AbstractMethod;

@:expose("PositionProvider")
class PositionProvider
{
    public function new() {}

    public function getPos():Position
        throw new AbstractMethod();
}
