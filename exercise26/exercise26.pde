/*
Title: exercise26
Author: Mark Staun Poulsen
Date 13/09 2020
*/

void setup()
{
  size(700, 900);
  background(30);
  
  color r = color(255, 0, 0);
  color g = color(0, 255, 0);
  color b = color(0, 0, 255);
  
  for(int i = 0; i <= width; i = i + 100)
  {
    for(int j = 0; j <= height; j = j + 200)
    {
      myOwnRect(i, j, i + 100, j + 200, 10, r);
      myOwnRect(i + round(random(-50, 50)), j + round(random(-50, 50)), i + round(random(50, 100)), j + round(random(50, 100)), 20, b);
      if(i == j)
      {
        for(int p = 0; p <= height; p = p + 30)
        {
          myOwnRect(i, p, i + 100, p + 20, round(random(5, 10)), r);
        }
      }
      if(j / 1 == i || j / 2 == i || j / 4 == i || height / 1 == i || height / 2 == i || height / 4 == i)
      {
        myOwnRect(i + 50, j + 50, i + 150, j + 150, 20, g);
      }
    }
  }
  
  //myOwnRect(100, 100, 200, 400, 20, r);
}

void myOwnRect(int topLeftX, int topLeftY, int bottomRightX, int bottomRightY, float lineThickness, int colour)
{
  stroke(colour, 20);
  strokeWeight(lineThickness);
  for(int i = topLeftX; i <= bottomRightX; i++)
  {
    point(i, topLeftY);
    point(i, bottomRightY);
    if(i == topLeftX || i == bottomRightX)
    {
      for(int j = topLeftY; j <= bottomRightY; j++)
      {
        point(i, j);
      }
    }
  }
}
