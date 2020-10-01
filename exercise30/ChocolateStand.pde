/*
Title: ChocolateStand
Author: Mark Staun Poulsen
Date: 01/10 2020
*/

class ChocolateStand 
{
  int chocolateCount = 40;
  int moneyCount = 10;
  String location = "next to the zoo";
  
  ChocolateStand(int chocolate, int money, String loc)
  {
    chocolateCount = chocolate;
    moneyCount = money;
    location = loc;
  }
  
  void sell(int numberOfSells)
  {
    for(int i = 0; i <= numberOfSells; i++)
    {
      chocolateCount -= 1;
      moneyCount += 3;
      println("The store sells "+numberOfSells+"count(s) of chocolate earning "+numberOfSells*3+" dollars.");
    }
  }
  
  void receive(int numberOfPurchases)
  {
    for(int i = 0; i <= numberOfPurchases; i++)
    {
      chocolateCount += 1;
      moneyCount -= 3;
      println("The store purchases "+numberOfPurchases+" count(s) of chocolate spending "+numberOfPurchases*3+" dollars.");
    }
  }
  
  void changeLocation(String loc)
  {
    location = loc;
    println("The store has been moved to "+location);
  }
  
  void printOutput()
  {
    println("Money: "+moneyCount);
    println("Count of chocolate: "+chocolateCount);
    println("Location: "+location);
  }
}
