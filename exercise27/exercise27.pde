/*
Title: exercise27
Author: Mark Staun Poulsen
Date: 28/09 2020
*/


//I wanted to make a proper printing press with both paper and presser 
//on sinewave and coswave respectively. However, I wasn't able to create conditionals
//checking for position of paper to be at the right spot for the presser to press.
//Right spot would be xPos == 175

void setup()
{
  size(400, 400);
  drawPrintingPress(50, 50); //leftmost X coordinate, topmost Y coordinate
}

void drawPrintingPress(float xPos, float yPos)
{
   rect(xPos, yPos + 150, 300, 10);
   rect(xPos + 170, yPos, 10, 250);
   rect(xPos, yPos + 150, 10, 100);
   rect(xPos + 300, yPos + 150, 10, 100);
}

void drawMovingParts(float xPos, float yPos)
{
    xPos += sin(millis() * 0.0002) * 280;
 
    rect(xPos, yPos + 140, 40, 10);  
}

void draw()
{
  float xPos = 50;
  float yPos = 50;
  
  background(240);
  drawMovingParts(xPos, yPos);
  drawPrintingPress(xPos, yPos);
}
