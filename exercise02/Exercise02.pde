/*
Title: Exercise03
Author: Mark Staun Poulsen
Date: 27/08 2020
*/

PShape art;

void setup()
{
  size(400, 400);
  background(230,230,230);
}

void draw()
{
  drawArt();
}

void drawArt()
{

  
  art = createShape();
  
  art.beginShape();
  art.fill(0,17,167);
  art.stroke(10);
  art.vertex(66, 300);
  art.vertex(333, 350);
  art.vertex(250, 66);
  art.vertex(120, 43);
  art.vertex(66, 300);
  art.endShape(CLOSE);
  
  bezier(333, 350, 333, 250, 285, 100, 250, 66);
  //quadraticVertex
  
  shape(art, 0, 0);
}
