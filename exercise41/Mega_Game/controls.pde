class Controls {
  PImage background_img;
  int line = 50;
  int leftSide = 260;

  void display() {
    imageMode(CENTER);
    float aspect = float(background_img.height)/float(height);
    image(background_img, 400, 400, float(background_img.width)/aspect, height);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    text("Controls", 400, 200);
    textSize(24);
    textAlign(LEFT);
    text("Movement: w or SPACE, a, s, d", leftSide, 300+line);
    text("Attack: UP, DOWN, LEFT, RIGHT", leftSide, 300+2*line);
    text("Heal: hold SHIFT", leftSide, 300+3*line);
    textSize(32);
    textAlign(CENTER);
    text("Back to menu", 400, 600+line);
  }

  void select() {
    if (mouseX > 280 && mouseX < 520 && mouseY > 500 + 2*line && mouseY < 500 + 3*line) {
      gameState = "menu";
    }
  }
  
  void menu(){
    fill(255, 255, 255, 60);
    noStroke();
    if (mouseX > 280 && mouseX < 520 && mouseY > 500 + 2*line+10 && mouseY < 500 + 3*line) {
      rect(280, 610, 520-280, 40);
    }
  }
}
