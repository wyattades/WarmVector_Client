class GUI {

  PVector cursor, dispVelocity;

  GUI() {
    cursor = new PVector(0, 0);
    dispVelocity = new PVector(0, 0);
  }

  void update() {
    noCursor();
    updateCursor();
  }

  void render() {
    displayMinimap();
    displayCursor();
  }

  private void displayMinimap() {
    fill(255, 0, 0);
    noStroke();
    pushMatrix();
    translate(width-140, 120);
    scale(0.12);
    rect(0, 0, world.mapW+30, world.mapH+30);
    image(image[0], 0, 0, world.mapW, world.mapH);
    strokeWeight(60);
    stroke(255, 0, 0);
    point(world.thisPlayer.position.x-world.mapW/2, world.thisPlayer.position.y-world.mapH/2);
    popMatrix();
  }

  private void displayCursor() {
    float linesize = 24;
    stroke(120);
    strokeWeight(3);
    point(cursor.x, cursor.y);
    line(cursor.x-linesize/2, cursor.y, cursor.x-linesize/4, cursor.y);
    line(cursor.x, cursor.y-linesize/2, cursor.x, cursor.y-linesize/4);
    line(cursor.x+linesize/4, cursor.y, cursor.x+linesize/2, cursor.y);
    line(cursor.x, cursor.y+linesize/4, cursor.x, cursor.y+linesize/2);
  }

  PVector dispPos(PVector Pos) {
    PVector d = Pos.get();
    d.add(WdispPos());
    d.add(PdispPos());
    d.sub(world.mapW/2, world.mapH/2, 0);
    return d;
  }

  PVector WdispPos() {
    PVector d = world.thisPlayer.position.get();
    d.sub(world.mapW/2, world.mapH/2, 0);
    d.mult(-1);
    return d;
  }

  PVector PdispPos() {  
    float rotateDist = 100*dist(gui.cursor.x, gui.cursor.y, world.dispW/2, world.dispH/2)/(world.dispW/2);
    PVector d = new PVector(-rotateDist, 0);
    d.rotate(world.thisPlayer.orientation);
    d.add(world.dispW/2, world.dispH/2, 0);
    float maxspeed = 60, accel = 0.03, neg_accel = accel*0.8;
    if (world.thisPlayer.velocity.x == 0) {
      if (dispVelocity.x < 0) dispVelocity.x += neg_accel;
      if (dispVelocity.x > 0) dispVelocity.x -= neg_accel;
    } else if (world.thisPlayer.velocity.x < 0) {
      if (dispVelocity.x > -maxspeed) dispVelocity.x -= accel;
    } else {
      if (dispVelocity.x < maxspeed) dispVelocity.x += accel;
    }

    if (world.thisPlayer.velocity.y == 0) {
      if (dispVelocity.y < 0) dispVelocity.y += neg_accel;
      if (dispVelocity.y > 0) dispVelocity.y -= neg_accel;
    } else if (world.thisPlayer.velocity.y < 0) {
      if (dispVelocity.y > -maxspeed) dispVelocity.y -= accel;
    } else {
      if (dispVelocity.y < maxspeed) dispVelocity.y += accel;
    }
    //d.add(dispVelocity);
    return d;
  }

  private void updateCursor() {
    cursor.set(mouseX, mouseY, 0);
    PVector p = world.thisPlayer.dispPos.get();
    p.sub(world.dispW/2, world.dispH/2, 0);
    cursor.add(p);
  }
}

