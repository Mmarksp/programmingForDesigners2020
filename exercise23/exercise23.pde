/*
Title: exercise23
Author: Mark Staun Poulsen
Date: 12/08 2020
*/

void setup()
{
  size(400, 400);
  background(180);
  
  mySquare(100, 100, 100); //if it does not work (white background), try commenting out mySquare(); and uncomment again after running the program once. Something with running the code.
}

void mySquare(int xPos, int yPos, int size)
{
  strokeWeight(2);
  for(int i = 0; i <= size; i =+ size)
  {
    stroke(random(0, 255), random(0, 255), random(0, 255));
    line(xPos + i, yPos, xPos + i, yPos + size);
    stroke(random(0, 255), random(0, 255), random(0, 255));
    line(xPos, yPos + i, xPos + size, yPos + i);
  }
}
