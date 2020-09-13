/*
Title: exercise25
Author: Mark Staun Poulsen
Date: 13/08 2020

List of adjectives were acquired from following URL: https://www.enchantedlearning.com/wordlist/adjectives.shtml
List of nouns were acquired from following URL: https://www.ef.com/ca/english-resources/english-vocabulary/top-50-nouns/
*/


void setup()
{
  printBandNames(10);
}

String createBandName()
{
  String nouns[] = loadStrings("nouns.txt");
  String adjectives[] = loadStrings("adjectives.txt");
  
  int roundedRandom = round(random(0, nouns.length -1));
  String pickedNoun = nouns[roundedRandom];
  
  roundedRandom = round(random(0, adjectives.length -1));
  String pickedAdjective = adjectives[roundedRandom];
  
  return pickedAdjective+" "+pickedNoun;
}

void printBandNames(int numberOfBandNames)
{
  for(int i = 0; i <= numberOfBandNames; i++)
  {
    println(createBandName());
  }
}
