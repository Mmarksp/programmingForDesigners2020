/*
Title: exercise28
Author: Mark Staun Poulsen
Date: 28/09 2020
*/

PVector v1, v2, g, end1, end2;

void setup()
{
  size(400, 400);
  end1 = new PVector(100, 100);
  end2 = new PVector(200, 200);
  v1 = new PVector(random(-1,1), random(-1, 1));
  v2 = new PVector(random(-1,1), random(-1, 1));
  g = new PVector(0, 0.01);
}

void onCollision()
{ 
  if(end1.y > height)
  {
    end1.y = height;
    v1.y = v1.y * -1;
  } else if(end1.x > width || end1.x < 0)
  {
    v1.x = v1.x * -1;
  }

  if(end2.y > height)
  {
    end2.y = height;
    v2.y = v2.y * -1;
  }
  else if(end2.x > width || end2.x < 0)
  {
    v2.x = v2.x * -1;
  }
}

void applyForces()
{
  end1.add(v1);
  end2.add(v2);
  v1.add(g);
  v2.add(g);
}

void draw()
{
  background(240);
  line(end1.x, end1.y, end2.x, end2.y);
  
  applyForces();
  onCollision();
}
