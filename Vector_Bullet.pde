class Vector_Bullet {

  PVector position, adder, shot, disp_i_pos, disp_f_pos, bulletLine, disp_trail_pos;
  float angle, spread, BPS, amount, damage, maxAdd;
  ArrayList<PVector> points;
  boolean state;
  int add;

  Vector_Bullet(float i_x, float i_y, float angle, float spread, float damage) {
    add = 2;
    position = new PVector(i_x, i_y);
    disp_i_pos = new PVector(0, 0);
    disp_f_pos = new PVector(0, 0);
    disp_trail_pos = new PVector(0, 0);
    adder = new PVector(0, 0);
    state = true;
    this.angle = angle;
    this.spread = spread;
    this.amount = amount;
    this.damage = damage;
    shot = new PVector(1000000, 0);
    shot.rotate(angle);
    shot.rotate(random(-1*spread, spread));
    points = new ArrayList<PVector>();
    for (int j = 0; j < world.tiles.size (); j++) {
      Tile t = world.tiles.get(j);
      if (t.collideBox.intersectsLine(position.x, position.y, position.x+shot.x, position.y+shot.y)==true && t.type == world.TILE_SOLID) { //if bulletline intersects with tile 
        points.add(new PVector(t.position.x, t.position.y)); //add all points of intersection with tile
      }
    }
//    for (int k = 0; k < world.players.size (); k++) {
//      Player p = world.players.get(k);
//      if (p.collideBox.intersectsLine(position.x, position.y, position.x+shot.x, position.y+shot.y)==true) {
//        points.add(new PVector(p.position.x, p.position.y));
//      }
//    }
    float previousDist = 1000000;
    for (int k = 0; k < points.size (); k++) {
      PVector p = points.get(k);
      float dist = dist(p.x, p.y, position.x, position.y);
      if (dist < previousDist) previousDist = dist;
    }
    shot.setMag(previousDist+world.tileSize/2);
    bulletLine = shot.get();
    bulletLine.setMag(40);
    maxAdd = shot.mag()-bulletLine.mag();
  }

  void update() {
    adder.set(shot);
    adder.setMag(add);

    PVector i_pos = position.get();
    i_pos.add(adder);
    disp_i_pos = gui.dispPos(i_pos).get();

    PVector f_pos = i_pos.get();
    f_pos.add(bulletLine);
    disp_f_pos = gui.dispPos(f_pos).get();   

    PVector trail = adder.get();
    trail.mult(0.5);
    PVector trail_pos = f_pos.get();
    trail_pos.sub(trail);
    disp_trail_pos.set(gui.dispPos(trail_pos));

    if (add >= maxAdd) {
      //shot.setMag(0);
      state = false;
    } else {
      state = true;
    }
    add+=50.0;
  }

  void render() {
    strokeWeight(2);
    stroke(100, 255*(maxAdd-add)/maxAdd);
    line(disp_trail_pos.x, disp_trail_pos.y, disp_f_pos.x, disp_f_pos.y);
    stroke(#F2E702);
    strokeWeight(4);
    line(disp_i_pos.x, disp_i_pos.y, disp_f_pos.x, disp_f_pos.y);
  }
}

