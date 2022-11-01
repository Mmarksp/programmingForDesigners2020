class Particle_system {
  float posX = 0;
  float posY = 0;
  float r = 10;
  float velocityX = 0;
  float velocityY = 0;
  int time0;
  int deltaTime;
  int alpha = 40;
  //color c=color(int(random(128, 256)), int(random(128, 256)), int(random(128, 256)));
  //float gravity = 0.3;

  //constructor gets position in pixels and x and y velocities, and sets the class variables accordingly
  Particle_system(float x, float y, float vX, float vY) {
    posX = x;
    posY = y;
    velocityX = vX;
    velocityY = vY;
  }
  void display() {
    strokeWeight(2);
    noStroke();
    if (player.playerWasHit) {
      fill(0, 0, 0, alpha);
    } else {
      fill(220, 100, 50, alpha);
    }
    ellipse(posX, posY, r, r);
    alpha--;
  }
  void move() {
    //println(velocityX, velocityY);
    posX += velocityX;
    posY += velocityY;
    //velocityY += gravity;
  }
}
