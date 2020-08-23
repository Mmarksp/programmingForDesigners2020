/*
Title: Exercise01
Author: Mark Staun Poulsen
Date: 23/08 2020
*/

void setup() 
{
  size(320, 200);
  background(100, 200, 255);
}

void draw()
{
  drawOcean();
  drawBeach();
  drawParasol();
}

void drawOcean()
{
  PShape ocean;
  ocean = createShape();
  
  ocean.beginShape();
  ocean.fill(140, 148, 255);
  ocean.noStroke();
  ocean.vertex(0, 200);
  ocean.vertex(130, 200);
  ocean.vertex(110, 170);
  ocean.vertex(110, 160);
  ocean.vertex(180, 90);
  ocean.vertex(0, 90);
  ocean.vertex(0, 0);
  ocean.endShape(CLOSE);
  
  shape(ocean, 0, 0);
}

void drawBeach()
{
  PShape beach;
  beach = createShape();
  
  beach.beginShape();
  beach.fill(255,234,168);
  beach.noStroke();
  beach.vertex(130, 200);
  beach.vertex(320, 200);
  beach.vertex(320, 90);
  beach.vertex(180, 90);
  beach.vertex(110, 160);
  beach.vertex(110, 170);
  beach.vertex(130, 200);
  beach.endShape(CLOSE);
  
  shape(beach, 0, 0);
}

void drawParasol()
{
  strokeWeight(2);
  fill(255, 120, 150);
  quad(230, 160, 235, 163, 255, 80, 250, 77);
  arc(245, 95, 100, 80, PI+QUARTER_PI, TWO_PI, CHORD);
}
