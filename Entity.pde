abstract class Entity {

  PVector position, size, dispPos;
  float orientation;
  boolean state;
  Rectangle2D collideBox;

  Entity(float x, float y) {
    x = x;
    y = y;
  }

  Entity(float i_x, float i_y, float w, float h) {
    position = new PVector(i_x, i_y);
    size = new PVector(w, h);
    dispPos = new PVector(0, 0);
    state = true;
    collideBox = new Rectangle2D.Float(position.x, position.y, size.x, size.y);
  }

  abstract void render();

  abstract void update();

  void updateDispPos() {
    dispPos.set(gui.dispPos(position));
  }
}

