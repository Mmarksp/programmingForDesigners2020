/* 
Title: Exercise08
Author: Mark Staun Poulsen
Date: 29/08 2020
*/

int xPos = 0;

void setup() 
{
  size(1190, 100);
  while(xPos <= width)
  {
    fill(random(0,255), random(0,255), random(0,255), 30);
    rect(xPos, 25, 50, 50);
    xPos += 60;
  }
}
