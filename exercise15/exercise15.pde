/*
Title: Exercise15
Author: Mark Staun Poulsen
Date: 05/09 2020
*/

PImage img;
int imgWidth = 400;
int imgHeight = 300;

void setup()
{
  size(1200, 900);
  img = loadImage("WinBack.jpg");
  img.resize(imgWidth, imgHeight);
  
  int yPos = 0;
  while(yPos < height)
  {
    int xPos = 0;
    while(xPos < width)
    {
      img.filter(DILATE); //try ERODE
      image(img, xPos, yPos);
      xPos += imgWidth;
    }
    yPos += imgHeight;
  }
}
