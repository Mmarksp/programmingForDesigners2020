class Title {
  PImage title_img;
  PImage background_img;
  String dir = "up";
  int alpha;

  void display() {
    imageMode(CENTER);
    float aspect = float(background_img.height)/float(height);
    image(background_img, 400, 400, float(background_img.width)/aspect, height);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    text("Hollow Knight", 400, 200);
    text("Coloseum of Fools", 400, 300);
    textSize(20);
    int f255 = 2*frameCount%255;
    if (dir == "up") {
      alpha = f255;
    } else if (dir == "down") {
      alpha = 255-f255;
    }
    if (f255>252 && dir == "down") { 
      dir = "up";
    } else if (f255>252 && dir == "up") { 
      dir = "down";
    }
    fill(255, 255, 255, alpha);
    text("Press SPACE to play", 400, 720);
  }
}
