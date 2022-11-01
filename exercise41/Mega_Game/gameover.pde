class GameOver {
  PImage background_img;
  int line = 50;
  boolean input = false;

  void display() {
    imageMode(CENTER);
    float aspect = float(background_img.height)/float(height);
    image(background_img, 400, 400, float(background_img.width)/aspect, height);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    text("Game Over", 400, 200);
    textSize(32);
    text("Your Score: "+score, 400, 300);
    text("Your Name? (3 characters)", 400, 300+line);
    text(playerName, 400, 300+3*line);
    if (highscore.checkScore() && !input) {
      text("Click here to input name", 400, 500-line);
    } else if (highscore.checkScore() && input){
      text("___", 400, 500-line);
    }
    text("Play Again?", 400, 500+line);
    text("High Scores", 400, 500+2*line);
    text("Main Menu", 400, 500+3*line);
  }

  void select() {
    if (highscore.checkScore() && mouseX > 280 && mouseX < 520 && mouseY > 500-2*line+10 && mouseY < 500) {
      input = true;
    } else if (mouseX > 310 && mouseX < 490 && mouseY > 510 && mouseY < 500 + line) {
      level = 1;
      wave = 1;
      buildLevel();
      gameState = "game";
    } else if (mouseX > 300 && mouseX < 500 && mouseY > 500 + line && mouseY < 500 + 2*line) {
      gameState = "highscore";
    } else if (mouseX > 310 && mouseX < 490 && mouseY > 500 + 2*line && mouseY < 500 + 3*line) {
      gameState = "menu";
    }
  }

  void menu() {
    fill(255, 255, 255, 60);
    noStroke();
    if (highscore.checkScore() && mouseX > 200 && mouseX < 600 && mouseY > 500-2*line+10 && mouseY < 500) {
      rect(200, 410, 600-200, 40);
    } else if (mouseX > 310 && mouseX < 490 && mouseY > 510 && mouseY < 500 + line) {
      rect(310, 510, 490-310, line-10);
    } else if (mouseX > 300 && mouseX < 500 && mouseY > 500 + line+10 && mouseY < 500 + 2*line) {
      rect(300, 560, 200, 40);
    } else if (mouseX > 310 && mouseX < 490 && mouseY > 500 + 2*line+10 && mouseY < 500 + 3*line) {
      rect(310, 610, 490-310, 40);
    }
  }
}
