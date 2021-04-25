package pw.tales.cofdsystem.mocks;

import pw.tales.cofdsystem.game_object.GameObject;
import thx.Uuid;

class CharacterMock extends GameObject {
    public function new(system:CofDSystem) {
        super(Uuid.create(), system);
    }
}
