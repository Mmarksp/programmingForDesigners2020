/* 
Title: Exercise12
Author: Mark Staun Poulsen
Date: 05/09 2020
*/

void setup() 
{
  size(400, 400);
  background(230);
}

void draw()
{
  drawHorizontalLines();
  drawVerticalLines();
}

void drawHorizontalLines()
{
  int determinator = 10;
  for(int yPos = 0; yPos <= 400; yPos++)
  {
    if(yPos == determinator)
    {
      for(int xPos = 0; xPos <= 400; xPos++)
      {
        point(xPos, yPos);
      }
      determinator = determinator + 10;
    }
  }
}

void drawVerticalLines()
{
  int determinator = 10;
  for(int xPos = 0; xPos <= 400; xPos++)
  {
    if(xPos == determinator)
    {
      for(int yPos = 0; yPos <= 400; yPos++)
      {
        point(xPos, yPos);
      }
      determinator = determinator + 10;
    }
  }
}
