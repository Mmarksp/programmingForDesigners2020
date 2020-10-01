/*
Title: exercise29
Author: Mark Staun Poulsen
Date: 28/09 2020
*/

PVector ball, ball2, velocity;
int ballWidth;
int[] cushions = new int[0]; 

void setup()
{
  ballWidth = 75;
  initiateBalls();
  
  size(400, 800);
}

void initiateBalls()
{
  ball = new PVector(width/2, height - height/3);
  ball2 = new PVector(random(0, width), random(0, height));
  velocity = new PVector(random(-1,1) * 5, random(-1, 1) * 5);
}

void applyForce()
{
  ball.add(velocity);
}

void onCollision()
{
  if(ball.x + ballWidth/2 > width || ball.x - ballWidth/2 < 0)
  {
    velocity.x *= -1;
  }
  if(ball.y + ballWidth/2 > height || ball.y - ballWidth/2 < 0)
  {
    velocity.y *= -1;
  }
  
  float distance = dist(ball.x, ball.y, ball2.x, ball2.y);
  if(distance < ballWidth)
  {
    updateScore();
    initiateBalls();
  }
}

void updateScore()
{
  int aVariable = 1;
  cushions = append(cushions, aVariable); //Value is unnecessary since I only use it as counter
  print(cushions.length);
}

void displayBalls()
{
  fill(0, 0, 0);
  ellipse(ball.x, ball.y, ballWidth, ballWidth);
  
  fill(255, 0, 0);
  ellipse(ball2.x, ball2.y, ballWidth, ballWidth);
  
  textSize(20);
  textAlign(CENTER);
  text(round(ball.x)+","+round(ball.y), ball.x, ball.y - 15);
}

void displayScoreCushions()
{
  fill(0,0,120);
  for(int i = 0; i < cushions.length; i++)
  {
    rect(5, 50 * i, 40, 40);
  }
}

void draw()
{
  background(40, 255, 0);
  
  displayBalls();
  displayScoreCushions();
  
  applyForce();
  onCollision();
}
