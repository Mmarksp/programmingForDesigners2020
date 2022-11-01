class Spit {
  int w = 40, h = 40, speed;
  float angle;
  PVector pos, vel;
  boolean initialShot = true;
  
  Spit(float m_angle, int m_shootSpeed, float m_posX, float m_posY, float m_width) {
    angle = m_angle;
    speed = m_shootSpeed;
    pos = new PVector(m_posX + m_width * 0.5, m_posY);
    vel = new PVector(0, 0);
  }
  
  void update() {
    if(initialShot == true) {
      setMovement();
      initialShot = false;
    }
    applyForces();
    display();
  }
  
  void setMovement() {
    vel.x = speed * cos(angle);
    vel.y = speed * sin(angle);
  }
  
  void applyForces() {
    setGravity();
    vel.x += vel.x * deltaTime * 0.001;
    vel.y += vel.x * deltaTime * 0.001;
    pos.add(vel);
  }
  
  void setGravity() {
    vel.add(0, gravity + 0.11);
  }
  
  void colliding() {
    spit = null;
  }
  
  void display() {
    push();
    stroke(211, 102, 81);
    fill(255, 196, 129);
    ellipse(this.pos.x, this.pos.y, this.w, this.h);
    pop();
  }
}
