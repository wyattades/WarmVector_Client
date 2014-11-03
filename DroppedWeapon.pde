class DroppedWeapon extends Entity {
  
  int type,rounds;
  
  DroppedWeapon(float i_x, float i_y, float w, float h, int type, int i_rounds) {
    super(i_x,i_y,w,h);
    this.type = type;
    rounds = i_rounds;
  }
  
  public void render() {
    fill(0);
    noStroke();
    rect(dispPos.x,dispPos.y,size.x,size.y);
  }
  
  public void update() {
    checkPickUp();
    updateDispPos();
  }
  
  private void checkPickUp() {
    if (input.mouseRight && world.thisPlayer.weaponType == 0 && collideRects(world.thisPlayer.position,world.thisPlayer.size,position,size)) {
      if (millis()-world.mouseRightTime>500) {
        world.mouseRightTime = millis();
        world.thisPlayer.weaponType = type;
        world.thisPlayer.round = rounds;
        state = false;
      }
    }
  }

}
