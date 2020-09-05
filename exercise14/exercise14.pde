/*
Title: Exercise14
Author: Mark Staun Poulsen
Date: 05/09 2020
*/

//I have copied the code from exercise13 and modified it here

void setup()
{
  size(1000, 1000);
  
  //for future reference ensure consistency among backlayer colours by setting variables to be used in both functions
  //or create a background colour and double transposition of backlayer rectangle now only containing one colour.
  
  determineOnYAxis();
  determineOnXAxis();
}

void determineOnYAxis() //the two determineOn_Axis-functions are identical save for the switch to the other axis
{
  int yHeight = height / 6; //yHeight or xWidth is used as the common denominator to ensure that every drawing contains the same ratio among the drawn shapes. Try changing the number.
  int backLayerDeterminator = 0; //There are three layers to the drawing on each axis, each containing their own drawn shape, colour and a determinator variable
  int middleLayerDeterminator = backLayerDeterminator + yHeight / 4;
  int frontLayerDeterminator = backLayerDeterminator + yHeight / 2;
  
  int transCol = 140;
  color back = color(random(0,255), random(0,255), random(0, 255), transCol);
  color back2 = color(random(0,255), random(0,255), random(0, 255), transCol);
  color backs[] = {back, back2};
  
  color middle = color(random(0,255), random(0,255), random(0, 255), transCol);
  color front = color(random(0,255), random(0,255), random(0, 255), transCol);
  
  int yPos = 0;
  while(yPos <= height)
  {
    noStroke();
    if(yPos == backLayerDeterminator)
    { 
      int rand = (int) random(0,2);
      drawRectangle(0, yPos, width, yHeight, backs[rand]);
      backLayerDeterminator += yHeight;
    }
    if(yPos == middleLayerDeterminator)
    {
      drawRectangle(0, yPos, width, yHeight / 2, middle);
      middleLayerDeterminator += yHeight * 2;
    }
    if(yPos == frontLayerDeterminator)
    {
      rectMode(CENTER);
      drawRectangle(width / 2, yPos, width, yHeight / 10, front);
      frontLayerDeterminator += yHeight / 2;
    }
    rectMode(CORNER);
    yPos++;
  }
}

void determineOnXAxis()
{
  int xWidth = width / 4;
  int backLayerDeterminator = 0;
  int middleLayerDeterminator = backLayerDeterminator + xWidth / 4;
  int frontLayerDeterminator = backLayerDeterminator + xWidth / 2;
  
  int transCol = 70;
  color back = color(random(0,255), random(0,255), random(0, 255), transCol);
  color back2 = color(random(0,255), random(0,255), random(0, 255), transCol);
  color backs[] = {back, back2};
  
  color middle = color(random(0,255), random(0,255), random(0, 255), transCol);
  color front = color(random(0,255), random(0,255), random(0, 255), transCol);
  
  int xPos = 0;
  while(xPos <= width)
  {
    noStroke();
    if(xPos == backLayerDeterminator)
    { 
      int rand = (int) random(0,2);
      drawRectangle(xPos, 0, xWidth, height, backs[rand]);
      backLayerDeterminator += xWidth;
    }
    if(xPos == middleLayerDeterminator)
    {
      drawRectangle(xPos, 0, xWidth / 2, height, middle);
      middleLayerDeterminator += xWidth * 2;
    }
    if(xPos == frontLayerDeterminator)
    {
      rectMode(CENTER);
      drawRectangle(xPos, height / 2, xWidth / 10, height, front);
      frontLayerDeterminator += xWidth / 2;
    }
    rectMode(CORNER);
    xPos++;
  }
}

void drawRectangle(int xPos, int yPos, int widthHorizontal, int heightVertical, color colour)
{
  fill(colour);
  rect(xPos, yPos, widthHorizontal, heightVertical);
}
