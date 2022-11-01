//Enemy Parent Class
class Enemy {
  int hp, soul_leak; //Enemies have hitpoints and leak an amount of soul to the player on being hit
  int hitTimer = 0, hitTimerDuration = 10; //when can enemy be hit again
  boolean displayingEnemyWasHit = false; //for displaying red tint on enemy
  PVector pos, vel;
  float w, h;

  void takeDamage() { 
    createParticles(this.pos.x+w/2, this.pos.y+h/2);
    displayingEnemyWasHit = true;
    this.hp -= player.dmg;
    if (this.hp <= 0) {
      this.die();
    }
  } 

  void die() {   
    for(int g = gruzzers.size() - 1; g >= 0; g--) {
      if(gruzzers.get(g) == this) {
        enemies.remove(this);
        gruzzers.remove(g);
      } 
    }
    for(int t = tiktiks.size() - 1; t >= 0; t--) {
      if(tiktiks.get(t) == this) {
        enemies.remove(this);
        tiktiks.remove(t);
      } 
    }
    if(mawlek == this) {
      enemies.remove(this);
      mawlek = null;
    }
  }
}


/*
class X extends Enemy {
  X(float x, float y, ) {
    
  }
  
  update() {
    move();
    display();
  }
  
  move() {
    
  }
  
  display() {
  
  }
}*/
