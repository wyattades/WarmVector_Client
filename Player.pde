class Player extends Entity
{
  String username;
  int textureID;
  boolean valid;
  int weaponType, round,id,bulletTime;
  PVector prevPos,vel;

  Player(float i_x, float i_y, float w, float h, int weaponType, int round) {
    super(i_x, i_y, w, h);
    username = "Enemy";
    bulletTime = millis();
    this.weaponType = weaponType;
    this.round = round;
    prevPos = new PVector(position.x,position.y);
    vel = new PVector(0,0);
  }

  void update() {
    updateDispPos();
    vel = position.get();
    vel.sub(prevPos);
  }

  void render() {
    pushMatrix();
    translate(dispPos.x, dispPos.y);
    textSize(12);
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
    rotate(-orientation);
    textSize(12);
    textAlign(CENTER);
    text(username, 0, -15);
    popMatrix();
  }
  
  void updatePrevPos() {
    prevPos.set(position);
  }
  
}

