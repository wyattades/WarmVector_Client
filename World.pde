
public class World {

  ArrayList<Entity> ents;
  ArrayList<Tile> tiles;
  ArrayList<Vector_Bullet> bullets;
  ArrayList<Player> players;
  int[][] tilesArray;

  float dispW, dispH, mapW, mapH;
  int gridW, gridH, bulletTime, mouseRightTime;

  static final int tileSize = 16;
  static final int TILE_EMPTY = 0;
  static final int TILE_SOLID = 1;
  static final int TILE_WINDOW = 2;
  // {frequency,spread,amount,cartridge,damage};
  float[][] weaponInfo = {
    {
      0, 0, 0, 0, 0
    }
    , {
      50, .06, 1, 60, 100
    }
    , {
      500, .01, 1, 12, 400
    }
    , {
      20, .12, 1, 200, 50
    }
    , {
      750, .20, 6, 12, 150
    }
  };
  String[] weaponName = {
    "None", "M4 Rifle", "Barret 50Cal", "LMG", "Remington"
  };

  P_Player thisPlayer;

  World() {
    ents = new ArrayList<Entity>();
    tiles = new ArrayList<Tile>();
    bullets = new ArrayList<Vector_Bullet>();
    players = new ArrayList<Player>();
    gridW = image[0].width;
    gridH = image[0].height;
    mapW = gridW*tileSize;
    mapH = gridH*tileSize;
    dispW = width;
    dispH = height;
    bulletTime = mouseRightTime = 0;
    tilesArray = getLevelArray();
    addTiles();
    thisPlayer = new P_Player(mapW/2, mapH/2, 48, 48, 1, 60);
    players.add(thisPlayer);
    for (int i = 0; i < tiles.size (); i++) {
      Tile t = tiles.get(i);
      ents.add(t);
    }
    ents.add(thisPlayer);
  }

  public void update() {
    if (thisPlayer.state == false && thisPlayer.weaponType != 0) {
      addDroppedWeapon(thisPlayer);
    }
    for (int i = 0; i < ents.size (); i++) {
      Entity e = ents.get(i);
      e.update();
    }
    for (int i = 0; i < bullets.size (); i++) {
      Vector_Bullet b = bullets.get(i);
      b.update();
    }    
    for (int i = ents.size ()-1; i >= 0; i--) {
      Entity e = ents.get(i);
      if (e.state == false) {
        ents.remove(e);
      }
    }
    for (int i = players.size ()-1; i >= 0; i--) {
      Player p = players.get(i);
      if (p.state == false) {
        players.remove(p);
      }
    }
    for (int i = bullets.size ()-1; i >= 0; i--) {
      Vector_Bullet b = bullets.get(i);
      if (b.state == false) {
        bullets.remove(b);
      }
    }
  }

  public void render() {
    displayBackgroundImage();
    for (int i = 0; i < bullets.size (); i++) {
      Vector_Bullet b = bullets.get(i);
      b.render();
    }
    for (int i = 0; i < playerManager.playerList.size (); i++) {
      Player p = playerManager.playerList.get(i);
      p.render();
    }
    //println("People: "+playerManager.playerList.size());
    for (int i = 0; i < ents.size (); i++) {
      Entity e = ents.get(i);
      e.render();
    }
    displayWords();
  }

  void addDroppedWeapon(Player p) {
    ents.add(1, new DroppedWeapon(p.position.x, p.position.y, 40, 7, p.weaponType, p.round));
  }

  private void displayWords() {
    textAlign(LEFT);
    textSize(30);
    fill(0);
    String displayAmmo = nf(thisPlayer.round, 2, 0);
    if (weaponInfo[thisPlayer.weaponType][3] == -1) displayAmmo = "Inf";
    if (thisPlayer.weaponType == 0) displayAmmo = "NA";

    text("Weapon: "+weaponName[thisPlayer.weaponType], 30, 60);
    text("Ammo: "+displayAmmo, 30, 90);
  }

  private void addBullets() {
    if (thisPlayer.weaponType != 0 && millis()-bulletTime>weaponInfo[thisPlayer.weaponType][0] && thisPlayer.round > 0) {
      for (int i = 0; i < weaponInfo[thisPlayer.weaponType][2]; i++) {
        bullets.add(new Vector_Bullet(thisPlayer.position.x, thisPlayer.position.y, thisPlayer.orientation, weaponInfo[thisPlayer.weaponType][1], weaponInfo[thisPlayer.weaponType][4]));
      }
      bulletTime = millis();
      thisPlayer.round--;
    }
  }

  private void addTiles() {
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        if (tilesArray[i][j] == TILE_SOLID) tiles.add(new Tile((i+.5)*tileSize, (j+.5)*tileSize, tileSize, tileSize, TILE_SOLID));
        else if (tilesArray[i][j] == TILE_WINDOW) tiles.add(new Tile((i+.5)*tileSize, (j+.5)*tileSize, tileSize, tileSize, TILE_WINDOW));
      }
    }
  }

  int[][] getLevelArray() {
    int[][] values = new int[gridW][gridH];
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        values[i][j] = image[level].get(i, j);
        if (values[i][j] == color(0)) values[i][j] = TILE_SOLID;
        else if (values[i][j] == color(0, 0, 255)) values[i][j] = TILE_WINDOW;
        else values[i][j] = TILE_EMPTY;
        if (i==0||i==gridW-1||j==0||j==gridH-1) values[i][j] = TILE_SOLID;
      }
    }
    return values;
  }

  public boolean collideTile(float x, float y) {
    x/=tileSize;
    y/=tileSize;
    if (tilesArray[int(x)][int(y)] != TILE_EMPTY) return true;
    return false;
  }

  private void displayBackgroundImage() {
    PVector p = thisPlayer.position.get();
    p.sub(mapW/2, mapH/2, 0);
    p.mult(-1);
    p.add(gui.PdispPos());
    //p.add(world.dispW/2,world.dispH/2,0);
    image(image[1], p.x, p.y, mapW, mapH);
  }
}

