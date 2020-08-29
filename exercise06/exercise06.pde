/*
Title: Exercise06
Author: Mark Staun Poulsen
Date: 29/08 2020
*/

int xPos;
int yPos;
int xWidth;
int yWidth;

void setup() 
{
  size(200, 200);
  drawEllipse();
  drawRectangle();
}

void drawEllipse()
{
  xPos = 50;
  yPos = 40;
  xWidth = 70;
  yWidth = 50;
  
  ellipse(xPos, yPos, xWidth, yWidth);
}

void drawRectangle()
{
  xPos = 100;
  yPos = 100;
  xWidth = 50;
  yWidth = 70;
  
  rect(xPos, yPos, xWidth, yWidth);
}
