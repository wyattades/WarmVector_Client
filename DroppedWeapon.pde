class DroppedWeapon extends Entity {

  int type, rounds;

  DroppedWeapon(float i_x, float i_y, float w, float h, int type, int i_rounds) {
    super(i_x, i_y, w, h);
    this.type = type;
    rounds = i_rounds;
  }

  public void render() {
    fill(0);
    noStroke();
    rect(dispPos.x, dispPos.y, size.x, size.y);
  }

  public void update() {
    updateDispPos();
  }

  public boolean checkPickUp(Player p) {
    if (input.mouseRight && p.weaponType == 0 && collideBox.intersects(p.position.x, p.position.y, p.size.x, p.size.y)) {
      if (millis()-world.mouseRightTime>500) {
        world.mouseRightTime = millis();
        p.weaponType = type;
        p.round = rounds;
        return true;
      }
    }
    return false;
  }
}

