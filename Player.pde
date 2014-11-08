class Player extends Entity
{
  String username,id;
  int textureID;
  boolean valid;
  int weaponType, round;

  Player(float i_x, float i_y, float w, float h, int weaponType, int round) {
    super(i_x, i_y, w, h);
    this.weaponType = weaponType;
    this.round = round;
  }

  void update() {
    updateDispPos();
  }

  void render() {
    pushMatrix();
    translate(dispPos.x, dispPos.y);
    rotate(orientation);   
    if (weaponType != 0) {
      fill(0);
      noStroke();
      strokeWeight(1);
      rectMode(CORNER);
      rect(0, -4, 40, 8);
      rectMode(CENTER);
    }
    strokeWeight(1);
    fill(#26DEB7);
    stroke(0);
    rect(0, 0, size.x*.6, size.y);   
    popMatrix();
  }
}

