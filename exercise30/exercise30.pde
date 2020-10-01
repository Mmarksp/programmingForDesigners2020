/*
Title: exercise30
Author: Mark Staun Poulsen
Date: 30/10 2020
*/

//It goes fast. Use mouseLEFT and mouseRIGHT for selling and purchasing chocolate. 
//Use RightArrow for changing location

ChocolateStand C;
String[] locations = {"next to the zoo", "up on the mountain", "down in the sewers", "next to the town hall", "out into space"};

void setup()
{
  C = new ChocolateStand(40, 10, "next to the zoo");
}

void keyPressed()
{
  C.location = locations[round(random(locations.length - 1))];
}

void draw()
{
   int potential = round(random(0, 5));
   if(mouseButton == LEFT) //purchase more chocolate 
   {
     C.receive(potential);
     C.printOutput();
   } else if (mouseButton == RIGHT) //sell chocolate for money
   {
     C.sell(potential);
     C.printOutput();
   }
}
