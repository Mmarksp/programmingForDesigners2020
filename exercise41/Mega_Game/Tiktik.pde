//Enemy Child Class
class Tiktik extends Enemy {
  float speed = 1.5, rotationAmount = 0;
  int switchTimer = 0;
  boolean isSwitchingSurface = false;
  PImage sprite;
  
  Tiktik(float x, float y, float e_width, float e_height, int hitPoints, int leakAmount) {
    hp = hitPoints;
    soul_leak = leakAmount;
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    w = e_width;
    h = e_height;
  }
  
  void update() {
    if(isSwitchingSurface == true) {
      switchSurface();
    }
    if(isSwitchingSurface == false) {
      setMovement();
      applyForces();
    }
    display();
  }
  
  void setMovement() {
    if(rotationAmount == 0) {
      vel.y = 0;
      vel.x = speed;
    }
    if(rotationAmount == 90) {
      vel.x = 0;
      vel.y = speed;
    }
    if(rotationAmount == 180) {
      vel.y = 0;
      vel.x = -speed;
    }
    if(rotationAmount == 270) {
      vel.x = 0;
      vel.y = -speed;
    }
  }
  
  void applyForces() {
    vel.x += vel.x * deltaTime * 0.001;
    vel.y += vel.y * deltaTime * 0.001;
    pos.add(vel);
  }
  
  void switchSurface() {
    switchTimer++;
    if(switchTimer++ >= 30) {
      isSwitchingSurface = false;
      switchTimer = 0;
      return;
    }
    
    rotationAmount += 6;
    if(rotationAmount == 360) {
      rotationAmount = 0;
    }
  }
  
  void colliding(float p_posX, float p_posY, float p_width, float p_height) {      
    if (pos.x + w * 0.25 >= p_posX + p_width - 1 && pos.y + h <= p_posY) { //turning upper right corner
      pos.x = p_posX + p_width - w * 0.25;
      isSwitchingSurface = true;
    } else if (pos.x + w * 0.25 >= p_posX + p_width && pos.y >= p_posY + p_height - 1) { //turning lower right corner
      pos.y = p_posY + p_height;
      isSwitchingSurface = true;
    } else if (pos.x + w - w * 0.25 <= p_posX + 1 && pos.y >= p_posY + p_height) { //turning lower left corner
      pos.x = p_posX - (w - w * 0.25);
      isSwitchingSurface = true;
    } else if (pos.x + w - w * 0.25 <= p_posX + 1 && pos.y + h <= p_posY + 1) { //turning upper left corner
      pos.y = p_posY - h;
      isSwitchingSurface = true;
    }
  }
  
  
  
  void display() {
    push();
    translate(pos.x + w * 0.5, pos.y + h * 0.5);
    rotate(radians(rotationAmount));
    if(displayingEnemyWasHit == true) {
      tint(220, 100, 50, 120);
      hitTimer++;
      if(hitTimer >= hitTimerDuration) {
        displayingEnemyWasHit = false;
      }
    } else {
      tint(255,255,255,255);
    }
    image(sprite, 0, 0, w, h + 5);
    pop();
  }
}
