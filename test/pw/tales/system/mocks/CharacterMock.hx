package pw.tales.system.mocks;

import pw.tales.system.game_object.GameObject;
import thx.Uuid;

class CharacterMock extends GameObject {
    public function new(system:CofDSystem) {
        super(Uuid.create(), system);
    }
}
