//Enemy Child Class
class Gruzzer extends Enemy {
  float horiz_speed = random(2, 2.5);
  float verti_speed = random(2, 2.5);
  int[] flipACoin = {-1, 1};
  PImage sprite [] = new PImage[2];
  boolean isLookingRight = true;
  
  Gruzzer(float x, float y, float e_width, float e_height, int hitPoints, int leakAmount){
    hp = hitPoints;
    soul_leak = leakAmount;
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    w = e_width;
    h = e_height;
    
    int rand = (int)random(flipACoin.length);
    horiz_speed *= flipACoin[rand];
    verti_speed *= flipACoin[rand];
  }
  
  void update() {
    setMovement();
    applyForces();
    display();
  }
  
  void setMovement() {
    vel.x = horiz_speed;
    vel.y = verti_speed;
  }
  
  void applyForces() {
    vel.x += vel.x * deltaTime * 0.001;
    vel.y += vel.y * deltaTime * 0.001;
    pos.add(vel);
  }
  
  void colliding(String whichSide) {
    if(whichSide == "onTopOf") {
      verti_speed *= -1;
    }
    if(whichSide == "underneath") {
      verti_speed *= -1;
    }
    if(whichSide == "right") {
      horiz_speed *= -1;
      isLookingRight = true;
    }
    if(whichSide == "left") {
      horiz_speed *= -1;
      isLookingRight = false;
    }
  }
  
  void display() {
    push();
    if(displayingEnemyWasHit == true) {
      tint(220, 100, 50, 120);
      hitTimer++;
      if(hitTimer >= hitTimerDuration) {
        displayingEnemyWasHit = false;
      }
    } else {
      tint(255, 255, 255, 255);
    }
    if(isLookingRight) {
      image(sprite[1], pos.x + w * 0.5, pos.y + h * 0.5, 80 * 0.8, GruzzerSpritesheet.height * 0.75);
    } else if (!isLookingRight) {
      image(sprite[0], pos.x + w * 0.5, pos.y + h * 0.5, 80 * 0.8, GruzzerSpritesheet.height * 0.75);
    }
    pop();
  }
}
