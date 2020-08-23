/*
  Title: Exercise00
  Author: Mark Staun Poulsen
  Date: 23/08 2020
*/

void setup()
{
  size(320, 200);
  background(60, 120, 180);
}

void draw()
{
  drawCastle(10, 180, 100, 90);
}

void drawCastle(int x, int y, int X, int Y)
{
  int startPosX = x;
  int startPosY = y;
  int xWidth = X;
  int yWidth = Y;
  
  //gate
  arc(startPosX + 150, startPosY, xWidth + 20, 200, PI, TWO_PI, OPEN);
  push();
  fill(60, 120, 180);
  arc(startPosX + 150, startPosY, xWidth/2, yWidth, PI, TWO_PI, OPEN);
  pop();
  
  //towers
  rect(startPosX, startPosY, xWidth, -yWidth);
  int tempStartPosX = startPosX + 300;
  rect(tempStartPosX, startPosY, -xWidth, -yWidth);
  
  //spires
  triangle(startPosX + 10, startPosY - yWidth, startPosX + 90, startPosY - yWidth, startPosX + 45, startPosY - yWidth - 45);
  triangle(tempStartPosX - 10, startPosY - yWidth, tempStartPosX - 90, startPosY - yWidth, tempStartPosX - 45, startPosY - yWidth - 45);
}
