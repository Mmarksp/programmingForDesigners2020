//Enemy child class
class Mawlek extends Enemy {
  int spitTimer = 0, spitWaitDuration = 120, shootSpeed = 22;
  int stabTimer = 0, stabWaitDuration = 60, stabSpeed = 5;
  int frameTimer = 0, frameSwitchDuration = 10, index = 0;
  float speed = 0.5;
  float pointOfHitDetection, hitDetectionIncrement;
  boolean goingToStab = false, readyingStab = false, switchFrame = false, spitting = false;;
  String stabbing;
  
  int[] flipACoin = {-1, 1};
  PImage [] sprite = new PImage[3];
  
  Mawlek(float x, float y, float e_width, float e_height, int hitPoints, int leakAmount) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    w = e_width;
    h = e_height;
    hp = hitPoints;
    soul_leak = leakAmount;
    
    int rand = (int) random(flipACoin.length);
    speed *= flipACoin[rand];
    pointOfHitDetection = this.pos.x + this.w * 0.5;
  }
  
  void update() {
    checkIfIntendingToStab();
    setMovement();
    applyForces();
    if(goingToStab == true) {
      stab();
    }
    shoot();
    display();
  }
  
  void checkIfIntendingToStab() {
    if(collider.isColliding(player.pos.x, player.pos.y, player.w, player.h, this.pos.x - 200, this.pos.y, 200, this.h * 0.5) && readyingStab == false) {
      goingToStab = true;
      stabbing = "left";
    }
    if(collider.isColliding(player.pos.x, player.pos.y, player.w, player.h, this.pos.x + this.w, this.pos.y, 200, this.h * 0.5) && readyingStab == false) {
      goingToStab = true;
      stabbing = "right";
    }
  }
  
  void setMovement() {
    if(pos.x < 150 || pos.x + w > 650) {
      speed *= -1;
    }
    vel.x = speed;
  }
  
  void applyForces() {
    vel.x += vel.x * deltaTime * 0.001;
    pos.add(vel);
  }
  
  void stab() {
    stabTimer++;
    if(stabTimer >= 0) {
      readyingStab = true;
      if(stabbing == "left") {
        pointOfHitDetection = this.pos.x + this.w * 0.5 - hitDetectionIncrement; //for displaying the cue that it is going to stab
        if(stabTimer >= stabWaitDuration) {
          hitDetectionIncrement += 10; //begin stabbing, pointOfHitDetection helps determine when colliding with player during stabbing motion
          if(collider.isColliding(player.pos.x, player.pos.y, player.w, player.h, this.pointOfHitDetection, this.pos.y, this.pos.x + this.w * 0.5 - pointOfHitDetection, this.h * 0.5)) {
            player.isAttackedOnce = true;
          }
        }
      }
      else if (stabbing == "right") {
        pointOfHitDetection = this.pos.x + this.w * 0.5 + hitDetectionIncrement;
        if(stabTimer >= stabWaitDuration) {
          hitDetectionIncrement += 10;
          if(collider.isColliding(player.pos.x, player.pos.y, player.w, player.h, this.pos.x + this.w * 0.5, this.pos.y, pointOfHitDetection - (this.pos.x + this.w * 0.5), this.h * 0.5)) {
            player.isAttackedOnce = true;
          }
        }
      }
        
      if(pointOfHitDetection >= this.pos.x + this.w * 0.5 + 250 || pointOfHitDetection <= this.pos.x + this.w * 0.5 - 250) { //can stab this far out from this.pos
        goingToStab = false;
        readyingStab = false;
        hitDetectionIncrement = 0;
        pointOfHitDetection = this.pos.x + this.w * 0.5;
        stabTimer = -60;
      }
    }
  }
  
  void shoot() {
    spitTimer++;
    if(spitTimer >= 0) {
      spitting = false; 
    }
 
    float angle = radians(90);
    int rand = (int) random(flipACoin.length);
    if(rand == 0) {
      angle = radians((random(-96, -92))); //determine angle of spitObject
    } else if(rand == 1) {
      angle = radians((random(-88, -84)));
    }
    if(spitTimer >= spitWaitDuration * 0.75) {
      spitting = true; //for displaying a new sprite before...
    }
    if(spitTimer >= spitWaitDuration && spit == null) {
      spitTimer = -0;
      spit = new Spit(angle, shootSpeed, this.pos.x, this.pos.y, this.w); //... spitting
    }
  }
  
  void display() {
    frameTimer++;
    push();
    if(displayingEnemyWasHit == true) { //taking a hit
      tint(220, 100, 50, 120);
      fill(220, 100, 50, 120);
      hitTimer++;
      if(hitTimer >= hitTimerDuration) {
        displayingEnemyWasHit = false;
      }
    } else {
      tint(255, 255, 255, 255);
      fill(68, 76, 94);
    }
    if(readyingStab == true) {
      if(pointOfHitDetection >= this.pos.x - 15 && stabbing == "left") {
        rect(this.pos.x - 15, this.pos.y + this.h * 0.3 - 10, 15, 20);
      } else if(pointOfHitDetection <= this.pos.x - 15 && stabbing == "left") {
        rect(pointOfHitDetection, this.pos.y + this.h * 0.3 - 10, this.pos.x + this.w - pointOfHitDetection, 20);
      } 
      if(pointOfHitDetection <= this.pos.x + w + 15 && stabbing == "right") {
        rect(this.pos.x + this.w, this.pos.y + this.h * 0.3 - 10, 15, 20);
      } else if(pointOfHitDetection >= this.pos.x + this.w + 15 && stabbing == "right") {
        rect(this.pos.x + this.w, this.pos.y + this.h * 0.3 - 10, pointOfHitDetection - (this.pos.x + this.w), 20);
      }
    }

    if(spitting)
    {
      index = 2;
    } else if(frameTimer >= random(30, 40)){
      if(!switchFrame) {
        index = 0;
      } else if(switchFrame) {
        index = 1;
      }
      switchFrame = !switchFrame;
      frameTimer = 0;
    }
    image(sprite[index], pos.x + w * 0.5, pos.y + h * 0.2, 350 * 0.75, MawlekSpritesheet.height * 0.9);
    pop();
  }
}
