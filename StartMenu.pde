class StartMenu {

  ArrayList<Button> buttons;

  StartMenu() {
    buttons = new ArrayList<Button>();
    buttons.add(new Button(width/2, height/2+100, 300, 80, color(100), color(255, 0, 0), "MULTIPLAYER", "MULTIPLAYER"));
    buttons.add(new Button(width/2, height/2-100, 300, 80, color(100), color(255, 0, 0), "SINGLEPLAYER", "SINGLEPLAYER"));
  }

  void render() {
    cursor(ARROW);
    for (int i = 0; i < buttons.size (); i++) {
      Button b = buttons.get(i);
      b.render();
      //if (b.checkClick())
    }
  }
}

class Button {

  PVector pos, size;
  String text, send;
  color f, s;

  Button(float x, float y, float w, float h, color f, color s, String text, String send) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    this.text = text;
    this.send = send;
    this.f = f;
    this.s = s;
  }
  boolean checkOver(int x, int y) {
    if (x > pos.x-size.x/2 && x < pos.x+size.x/2 && y > pos.y-size.y/2 && y < pos.y+size.y/2)
      return true;
    return false;
  }

  boolean checkClick() {
    if (checkOver(mouseX, mouseY) && input.mouseLeft == true) 
      return true;
    return false;
  }

  void render() {
    if (checkOver(mouseX, mouseY)) {
      fill(f);
      stroke(s);
    } else {
      fill(s);
      stroke(f);
    }
    strokeWeight(1);
    rect(pos.x, pos.y, size.x, size.y);
    textSize(30);
    fill(0);
    text(text, pos.x, pos.y);
  }
}

