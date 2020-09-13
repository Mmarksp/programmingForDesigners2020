/*
Title: Exercise20&21&22
Author: Mark Staun Poulsen
Date: 10/09 2020
*/

void setup()
{
  size(800, 600);
  
  for(int i = 0; i <= 100; i++)
  {
    drawAppliance(random(0, width - 50), random(0, height - 50), 2, false, 230);
  }
}

void drawAppliance(float xPos, float yPos, int edge, boolean appType, int colour)
{
  drawShape(xPos, yPos, edge, colour);
  
  if(appType == false) //fridge
  {
    drawKnob(xPos, yPos);
    drawFreezer(xPos, yPos);
  } else if (appType == true) //oven
  {
    drawOvenLid(xPos, yPos);
  }
}

void drawShape(float xPos, float yPos, int edge, int colour)
{
  fill(colour);
  stroke(edge);
  rect(xPos, yPos, 50, 60);
}

void drawKnob(float xPos, float yPos)
{
  line(xPos + 10, yPos + 20, xPos + 15, yPos + 20);
}

void drawFreezer(float xPos, float yPos)
{
  line(xPos, yPos + 40, xPos + 50, yPos + 40);
}

void drawOvenLid(float xPos, float yPos)
{
  fill(0);
  rect(xPos + 5, yPos + 20, 40, 30);
}
