class ThisPlayer extends Player {

  PVector velocity, acceleration;
  float rotateDist = 80;
  int health;
  float tempID;

  ThisPlayer(float i_x, float i_y, float w, float h, int weaponType, int round) {
    super(i_x, i_y, w, h, weaponType, round);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    health = 1000;
    rotateDist = 80;
  }

  public void update() {
    updateAngle();
    updateVelocity();
    updatePosition();
    updateLife();
    if (input.mouseLeft) world.addBullets(this);
    if (input.mouseRight) changeGun();
    dispPos.set(gui.PdispPos());
  }

  private void changeGun() {
    if (millis()-world.mouseRightTime>500 && weaponType != 0) {
      world.addDroppedWeapon(world.thisPlayer);
      weaponType = 0;
      world.mouseRightTime = millis();
    }
  }

  private void updateLife() {
    if (health <= 0) {
      health = 0;
      state = false;
    }
  }

  private void updatePosition() {
    position.add(velocity);
  }

  private void updateAngle() {
    orientation = atan2(gui.cursor.y-dispPos.y, gui.cursor.x-dispPos.x);
  }

  private void updateVelocity() {
    int s = 8; //speed is based on framerate so it remains constant
    float dx = size.x*.3;
    float dy = size.y*.3;

    if (input.keyLeft && input.keyRight) velocity.x = 0;
    else if (input.keyRight && !world.collideTile(position.x+size.x/2, position.y) 
      && !world.collideTile(position.x+size.x/2, position.y+dy)
      && !world.collideTile(position.x+size.x/2, position.y-dy)) velocity.x = s;
    else if (input.keyLeft  && !world.collideTile(position.x-size.x/2, position.y) 
      && !world.collideTile(position.x-size.x/2, position.y+dy) 
      && !world.collideTile(position.x-size.x/2, position.y-dy)) velocity.x = -s;
    else velocity.x = 0;

    if (input.keyUp && input.keyDown) velocity.y = 0;
    else if (input.keyDown && !world.collideTile(position.x, position.y+size.y/2) 
      && !world.collideTile(position.x+dx, position.y+size.y/2) 
      && !world.collideTile(position.x-dx, position.y+size.y/2)) velocity.y = s;
    else if (input.keyUp && !world.collideTile(position.x, position.y-size.y/2) 
      && !world.collideTile(position.x+dx, position.y-size.y/2) 
      && !world.collideTile(position.x-dx, position.y-size.y/2)) velocity.y = -s;
    else velocity.y = 0;
  }
}

