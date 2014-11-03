class StartMenu {
  
  ArrayList<Button> buttons;
  
  StartMenu() {
    buttons = new ArrayList<Button>();
  }
  
  Button newButton(float x, float y, float w, float h, String text, String send) {
    return new Button(x,y,w,h,text,send);
  }
  
  void render() {
    for(int i = 0; i < buttons.size(); i++) {
      Button b = buttons.get(i);
      b.checkOver(mouseX,mouseY);
      b.checkClick();
      b.render();
    }
  }
}

class Button {
  
  PVector pos,size;
  String text, send;
  
  Button(float x, float y, float w, float h, String text, String send) {
    pos = new PVector(x,y);
    size = new PVector(w,h);
    this.text = text;
    this.send = send;
  }
  void checkOver(int x, int y) {
    
  }
  void checkClick() {
    
  }
  
  void render() {
    
  }
  
  
}
