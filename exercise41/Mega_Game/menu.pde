class Menu {
  PImage background_img;
  int line = 50;
  int x = 380;
  int y = 500;

  void display() {
    imageMode(CENTER);
    float aspect = float(background_img.height)/float(height);
    image(background_img, 400, 400, float(background_img.width)/aspect, height);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    text("Hollow Knight", 400, 200);
    text("Coloseum of Fools", 400, 300);
    textSize(32);
    text("Play", 400, 500+line);
    text("High Scores", 400, 500+2*line);
    text("Controls", 400, 500+3*line);
    //text("Credits", 400, 500+4*line);
  }

  void select() {
    if (mouseX > 360 && mouseX < 440 && mouseY > 510 && mouseY < 500 + line) {
      level = 1;
      wave = 1;
      buildLevel();
      gameState = "game";
    } else if (mouseX > 300 && mouseX < 500 && mouseY > 500 + line && mouseY < 500 + 2*line) {
      gameState = "highscore";
    } else if (mouseX > 320 && mouseX < 480 && mouseY > 500 + 2*line && mouseY < 500 + 3*line) {
      gameState = "controls";
    } /*else if (mouseX > 380 && mouseX < 420 && mouseY > 500 + 3*line && mouseY < 500 + 4*line){
     gameState = "credits";
     }*/
  }
  
  void menu(){
    fill(255, 255, 255, 60);
    noStroke();
    if (mouseX > 360 && mouseX < 440 && mouseY > 510 && mouseY < 500 + line) {
      rect(360, y+10, 440-360, line-10);
    } else if (mouseX > 300 && mouseX < 500 && mouseY > 500 + line+10 && mouseY < 500 + 2*line) {
      rect(300, 560, 200, 40);
    } else if (mouseX > 320 && mouseX < 480 && mouseY > 500 + 2*line+10 && mouseY < 500 + 3*line) {
      rect(320, 610, 480-320, 40);
    }
  }
}
