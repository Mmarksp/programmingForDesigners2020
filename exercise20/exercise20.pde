/*
Title: Exercise20
Author: Mark Staun Poulsen
Date: 10/09 2020
*/

void setup()
{
  size(800, 600);
  background(210);
  drawFork(10, 10);
}

void drawFork(int xPos, int yPos)
{
    noStroke();
    rect(xPos, yPos + 30, 40, 10);
    rect(xPos, yPos, 10, 40);
    rect(xPos + 15, yPos + 5, 10, 35);
    rect(xPos + 30, yPos, 10, 40);
    rect(xPos + 15, yPos + 40, 10, 40);
}
