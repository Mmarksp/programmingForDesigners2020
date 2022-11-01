class Player {
  /*Player animation (tied to timefix)
   Sprite sheet*/

  PVector pos, vel, sword_pos;
  float w, h, m_speed = 5, j_speed = 12, sword_w = 0, sword_h = 0;
  int dmg = 3, hp = 5, soul = 99, hitZone = 62, alphaValue = 250;
  int attackTimer = 0, attackedTimer = 0, healingTimer = 0;
  boolean detectedGround = false, isGrounded = false, isMoving = false, isLookingRight = true, isJumpingOnce = false, breakJump = false, isAttackingOnce = false, isAttackedOnce = false, isHealing = false, objectWasHit = false, playerWasHit;
  char storedMoveKey;
  int storedAttackKey;

  PImage [] sprite = new PImage[2];

  Player(float x, float y, float p_width, float p_height) {
    pos = new PVector(x, y);
    sword_pos = new PVector();
    vel = new PVector(0, 0);
    w = p_width;
    h = p_height;
  }

  void display() {
    push();
    if(playerWasHit == true) {
      if(alphaValue == 250) {
        alphaValue = 50;
      } else if(alphaValue >= 0) {
        alphaValue += 50;
      }
      tint(255,255,255,alphaValue);
    }
    if(isLookingRight)
    {
      image(sprite[1], pos.x + w * 0.5, pos.y + h * 0.5);
    } else if(!isLookingRight)
    {
      image(sprite[0], pos.x + w * 0.5, pos.y + h * 0.5);
    }
    pop();
  }
  
  void displayUI() {
    //soul
    rect(7, 25, 40, 40);
    push();
    noStroke();
    fill(130);
    float fillingValue = 39 - (soul / 2.475);
    rect(8, 25, 38, fillingValue);
    pop();
    
    //hp
    for(int i = 0; i < hp; i++) {
      push();
      fill(255, 200, 0);
      ellipse(67 + 20*i, 45, 20, 20);
      pop();
    }
  }
  
  void update() {
    player.checkIfMoving();
    player.updateGroundedStatus();
    player.checkIfJumpingOnce();
    player.applyForces();
    player.checkIfAttackedOnce();
    player.checkIfHealing();
    player.checkIfAttackingOnce();
    player.display();
    player.displayUI();
  }

  //---------------- UPDATE ----------------
  void checkIfMoving() {
    if(isMoving == true) {
      move();
    } else {
      vel.x = 0;
    }
  }
  
  void updateGroundedStatus() {
    if(detectedGround) { //detectedGround is used to set isGrounded. isGrounded is used to set gravity
      isGrounded = true;
      breakJump = false;
      detectedGround = false;
    } else {
      isGrounded = false;
    }
  }
  
  void checkIfJumpingOnce() {
    if(isJumpingOnce == true) {
      jump(); 
      isJumpingOnce = false;
    } else if (breakJump == true && vel.y < 0) { //to ensure maneuverability while jumping and releasing the key
      vel.y += 1;
    }
  }
  
  void applyForces() {
    setGravity();
    if(vel.y >= j_speed) { //check for max speed going downwards in order to not exceed collision detection area and ensure maneuverability.
      vel.y = j_speed;
    }
    vel.x += vel.x * deltaTime * 0.001;
    vel.y += vel.y * deltaTime * 0.001;
    pos.add(vel);
  }
  
  void setGravity() { 
    if (isGrounded == false) {
      vel.add(0, gravity);
    }
  }
 
  void checkIfAttackedOnce() {
     if (isAttackedOnce == true) {
       takeDamage();  
     } else {
       attackedTimer = 0;
     }
  }
  
  void checkIfHealing() {
     if(isHealing == true) {
       heal(); 
     } else {
       healingTimer = 0; 
     }
  }
  
  void checkIfAttackingOnce() {
    if(isAttackingOnce == true && isAttackedOnce == false) {
      nailStab();
    } else {
      attackTimer = 0;
    }
  }

 //------------ PLAYER ACTIONS -------------
  void move() {
    if (storedMoveKey == 'd') {
      vel.x = m_speed;
      isLookingRight = true;
    } else if (storedMoveKey == 'a') {
      vel.x = -m_speed;
      isLookingRight = false;
    }
  }

  void jump() {
    if (isGrounded) {
      vel.add(0, -j_speed);
    }
  }
  
  void heal() {
    if (soul > 10 && hp < 5 && healingTimer >= 10) {
      if(healingTimer >= 43) {
        soul -= 33; //Max amount of soul to carry is 99. Thus you can at most heal three times with full soul, not enough for full health
        hp++;
        healingTimer = -23;
      } else {
        healingTimer++;
      }
    } else {
      healingTimer++;
    }
  }
  
  void nailStab() {
   sword_pos.x = this.pos.x + w*0.5;
   sword_pos.y = this.pos.y + h*0.5+15;
   push();
   stroke(160);
   strokeWeight(3);
   rect(sword_pos.x, sword_pos.y, sword_w, sword_h);
   pop();
   
   //Program will iterate over this when isAttackingOnce is set to true and until isAttackingOnce is set to false again after a certain amount of time. 
   //If succesfully hitting an enemy once nothing else can be hit in the remaining duration of the attack because of objectWasHit = true.
   //As such, isAttackingOnce and objectWasHit should both be set to false when done with attack phase.
   
    for(int i = 0; i < enemies.size(); i++) {
      if (storedAttackKey == UP) {
        if(sword_h >= -62) {
          sword_w = 0;
          sword_h -= 20; // sword animation
        }
        if (collider.isColliding(this.pos.x, this.pos.y - hitZone, this.w, hitZone, enemies.get(i).pos.x, enemies.get(i).pos.y, enemies.get(i).w, enemies.get(i).h) &&
        objectWasHit == false) {
          takeSoul(enemies.get(i));
          enemies.get(i).takeDamage();
          objectWasHit = true;
        }
      }
      else if (storedAttackKey == DOWN) {
        if(sword_h <= 62) {
          sword_w = 0;
          sword_h += 20; // sword animation
        }
        if (collider.isColliding(this.pos.x, this.pos.y + this.h, this.w, this.h + hitZone, enemies.get(i).pos.x, enemies.get(i).pos.y, enemies.get(i).w, enemies.get(i).h) &&
        objectWasHit == false) {
          takeSoul(enemies.get(i));
          enemies.get(i).takeDamage();
          objectWasHit = true;
        }
      }
      else if (storedAttackKey == RIGHT) {
        if(sword_w <= 62) {
          sword_h = 0;
          sword_w += 20; // sword animation
        }
        if (collider.isColliding(this.pos.x + this.w, this.pos.y + this.h* 0.25, this.w + hitZone, this.h * 0.5, enemies.get(i).pos.x, enemies.get(i).pos.y, enemies.get(i).w, enemies.get(i).h) &&
        objectWasHit == false) {
          takeSoul(enemies.get(i));
          enemies.get(i).takeDamage();
          objectWasHit = true;
        }
        isLookingRight = true;
      }
      else if (storedAttackKey == LEFT) {
        if(sword_w >= -62) {
          sword_h = 0;
          sword_w -= 20; // sword animation
        }
        if (collider.isColliding(this.pos.x - hitZone, this.pos.y + this.h* 0.25, hitZone, this.h * 0.5, enemies.get(i).pos.x, enemies.get(i).pos.y, enemies.get(i).w, enemies.get(i).h) &&
        objectWasHit == false) {
          takeSoul(enemies.get(i));
          enemies.get(i).takeDamage();
          objectWasHit = true;
        }
        isLookingRight = false;
      }     
    }
   
    attackTimer++;
    if(attackTimer >= 30) {
      objectWasHit = false;
      isAttackingOnce = false;
      sword_w = 0;
      sword_h = 0;
    }
  }
  
  void takeSoul(Enemy enemies) {
    soul += enemies.soul_leak; 
    if(soul >= 99) {
      soul = 99;
    }
  }
  
  
  //---------------- COLLISION EFFECTS ------------------
  void collidingPlatforms(String whichSide, float platformPosX, float platformPosY, float platformWidth, float platformHeight) {
    if (whichSide == "onTopOf") {
      vel.y = 0;
      pos.y = platformPosY - this.h;
    } else if (whichSide == "underneath") {
      vel.y = 0;
      pos.y = platformPosY + platformHeight;
    } else if (whichSide == "right") {
      vel.x = 0;
      pos.x = platformPosX + platformWidth;
    } else if (whichSide == "left") {
      vel.x = 0;
      pos.x = platformPosX - this.w;
    }
  }
  
  void takeDamage() {  
    if(playerWasHit == false) {
      playerWasHit = true;
      createParticles(this.pos.x+w/2, this.pos.y+h/2);
      hp--;
      if (hp <= 0) {
        death();
      }
    }
    
    attackedTimer++;
    if(attackedTimer >= 90) {
      attackedTimer = 0;
      playerWasHit = false; 
      isAttackedOnce = false;
    }
  }
  
  void death()
  {
    score = 0;
    gameState = "gameover";
  }
}
