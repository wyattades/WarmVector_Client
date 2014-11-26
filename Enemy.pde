class Enemy extends Player {
  
  Enemy(float i_x, float i_y, float w, float h, int weaponType, int round) {
    super(i_x, i_y, w, h, weaponType, round);
  }

  void followPlayer(Player p) {
  }

  void orientToPlayer(Player p, float speed) {
    if (angle_Between(p) >= PI/2) {
      orientation += speed;
    } else if (angle_Between(p) < PI/2) {
      orientation -= speed;
    }
  }
  
  float angle_Between(Player p) {
    PVector o = new PVector(0, -1);
    o.rotate(orientation);
    return PVector.angleBetween(o, distBetween(p));
  }

  PVector distBetween(Player p) {
    PVector d = p.position.get();
    d.sub(position);
    return d;
  }

  boolean lineOfSight(Player p, ArrayList<Tile> tiles) {
    for (int i = 0; i < tiles.size(); i++) {
      Tile t = tiles.get(i);
      if (t.collideBox.intersectsLine(position.x, position.y, p.position.x, p.position.y) && t.type == world.TILE_SOLID) { //if bulletline intersects with solid tile 
        return false;
      }
    }
    return true;
  }

  boolean lookingAt(Player p, float tolerance) {
    if (angle_Between(p) < tolerance) {
      return true;
    }
    return false;
  }
}

