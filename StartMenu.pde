class StartMenu {

  ArrayList<Button> buttons;

  StartMenu() {
    buttons = new ArrayList<Button>();
    buttons.add(new Button(width/2, height/2+100, 300, 80, color(100), color(255, 0, 0), "MULTIPLAYER", 3));
    buttons.add(new Button(width/2, height/2-100, 300, 80, color(100), color(255, 0, 0), "SINGLEPLAYER", 2));
    buttons.add(new Button(width/2, height/2+200, 200, 80, color(100), color(255, 0, 0), "QUIT", 10));
  }

  void render() {
    cursor(ARROW);
    for (int i = 0; i < buttons.size (); i++) {
      Button b = buttons.get(i);
      b.render();
    }
  }

  void update() {
    for (int i = 0; i < buttons.size (); i++) {
      Button b = buttons.get(i);
      if (b.overClick()) stage = b.send;
    }
  }
}

class Button {

  PVector pos, size;
  String text;
  int send;
  color f, s;

  Button(float x, float y, float w, float h, color f, color s, String text, int send) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    this.text = text;
    this.send = send;
    this.f = f;
    this.s = s;
  }

  boolean overBox() {
    if (mouseX > pos.x-size.x/2 && mouseX < pos.x+size.x/2 && mouseY > pos.y-size.y/2 && mouseY < pos.y+size.y/2)
      return true;
    return false;
  }

  boolean overClick() {
    if (overBox() && input.mouseLeft == true) 
      return true;
    return false;
  }

  void render() {
    if (overBox()) {
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
    text(text, pos.x, pos.y+10);
  }
}

