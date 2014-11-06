class Projectile extends Entity {

  PVector velocity;
  int damage;

  Projectile(float i_x, float i_y, float w, float h, PVector i_v, int damage) {
    super(i_x, i_y, w, h);
    velocity = i_v.get();
    this.damage = damage;
  }

  void render() {
    fill(0);
    ellipse(dispPos.x, dispPos.y, size.x, size.y);
  }

  void update() {
    position.add(velocity);
    updateDispPos();
  }
}

