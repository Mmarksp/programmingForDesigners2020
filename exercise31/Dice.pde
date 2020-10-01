/*
Title: Dice
Author: Mark Staun Poulsen
Date: 01/10 2020
*/

class Dice
{ 
  int[] faces = {1, 2, 3, 4, 5, 6};
  
  int roll()
  {
    return faces[round(random(faces.length - 1))];
  }
}
