/*
Title: exercise31
Author: Mark Staun Poulsen
Date: 01/10 2020
*/


void setup()
{ 
  int numberOfDice = 3;
  
  size(400, 400);
  
  Dice[] die = new Dice[numberOfDice];
  int[] rolledNumbers = new int[numberOfDice];
  
  for(int i = 0; i < numberOfDice; i++)
  {
    die[i] = new Dice();
    rolledNumbers[i] = die[i].roll();
    textSize(54);
    text(rolledNumbers[i], 100 + 75 * i, 200);
  }
}
