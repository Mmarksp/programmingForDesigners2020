/*
  Title: Exercise00
  Author: Mark Staun Poulsen
  Date: 23/08 2020
*/

void setup()
{
  size(320, 200);
  background(60, 120, 180);
  drawCastle(10, 180, 100, 90);
}

void drawCastle(int x, int y, int X, int Y)
{
  int startPosX = x; //variables are containers that (in this case) can contain integer numbers. These variables are stored in the program and may be referenced throughout the writing of code often for the sake of convenience and abstraction
  int startPosY = y;
  int xWidth = X;
  int yWidth = Y;
  
  //gate
  arc(startPosX + 150, startPosY, xWidth + 20, 200, PI, TWO_PI, OPEN);
  push(); //administers that upon writing pop() previously set adjustments to colour filling, strokeWeight and transformations (among other things) should ceize to be active for later written code
  fill(60, 120, 180);
  arc(startPosX + 150, startPosY, xWidth/2, yWidth, PI, TWO_PI, OPEN);
  pop();
  
  //towers
  rect(startPosX, startPosY, xWidth, -yWidth); //Processing contains drawing functionality regarding different shapes and colours, lines and curves. These functions provide a simple and expected answer comparable to any illustration program, but underneath is a lot of prewritten code in order to make it work like that
  int tempStartPosX = startPosX + 300;
  rect(tempStartPosX, startPosY, -xWidth, -yWidth);
  
  //spires
  triangle(startPosX + 10, startPosY - yWidth, startPosX + 90, startPosY - yWidth, startPosX + 45, startPosY - yWidth - 45);
  triangle(tempStartPosX - 10, startPosY - yWidth, tempStartPosX - 90, startPosY - yWidth, tempStartPosX - 45, startPosY - yWidth - 45);
}
