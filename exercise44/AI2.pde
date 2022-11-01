// AI2 is the AI that students modify

class AI2
{
  int iID=0;
  color cDisplayCol = color(200, 150, 0); // students should feel free to pick their own AIs display color
  
  // do not modify this constructor
  public AI2(int id)
  {
    iID = id;
  }
  
  // do not modify this function
  void vTurnMake()
  {
    // calculate how many armies this player gets to place
    int iCountriesNumber=0;
    boolean[] bWhichCountries = new boolean[countries.length]; // this is used to test ownership of complete islands later
    for (int i = 0; i < countries.length; i++)
    {
      bWhichCountries[i] = countries[i].iGetOwner()==iID;
      if (bWhichCountries[i]) { 
        iCountriesNumber++;
      }
    }
    if (iCountriesNumber==0) { 
      return;
    }  //player is out
    // reinforcements count is number of countries owned divided by 3, plus 2 extra. There is also a bonus for owning complete islands
    int iReinforcements=int(iCountriesNumber/3);
    iReinforcements+=2;
    // test for complete island ownership
    if (bWhichCountries[0] && bWhichCountries[3]) // this AI owns the complete small island
    {
      iReinforcements+=1;
    }
    if (bWhichCountries[1] && bWhichCountries[2] && bWhichCountries[4]) // this AI owns the complete medium island
    {
      iReinforcements+=2;
    }
    if (bWhichCountries[5] && bWhichCountries[6] && bWhichCountries[7] && bWhichCountries[8]) // this AI owns the complete large island
    {
      iReinforcements+=3;
    }
    println("AI "+iID+" rules over "+iCountriesNumber+" countries and receives "+iReinforcements+" armies this round.");

    // cache this players owned countries
    Country[] ownedCountries = new Country[iCountriesNumber];
    int index = 0;
    for (int i = 0; i < countries.length; i++)
    {
      if (countries[i].iGetOwner()==iID)
      {
        ownedCountries[index] = countries[i];
        index++;
      }
    }

    // run logic for placing armies and attacking (written by student)
    vPlaceArmies(ownedCountries, iReinforcements);
    vMakeAttack(ownedCountries);
  }
  
//------------------------------------------------------------------- Students should implement their code below here ----------------------------------------------------------------\\
// Rules:
// You can make extra functions to avoid duplicate code but you must implement both vPlaceArmies and vMake Attack if you want your AI to do anything
// You should not be manipulating any class variables directly, use get and set methods
// Only make one attack per turn (we will check this)
// Only place the number of armies passed as a parameter (we will check this)
//-------------\\
// Use Methods:
// Country::iGetOwner() - returns the ID of the Ai that owns it
// Country::iGetArmies() - returns the number of armies stationed there
// Country::.vStationArmies(int a); - adds the number of armies (a) to the current total, use this to place armies in your countries
// Country::iGetBorder() - returns a length 4 array of ints, the stored ints are the IDs of the bordering countries
//-------------\\
// Access Global Variables:
// Country[] countries - this is a length 9 array of countries in the game, the index of a country is its ID, you can use iGetBorder() in combination with this to access info on neighboring countries
//-------------\\
  
  
  
/*
Title: Exercise44 
Author: Mark Staun Poulsen
Date: 13/12 2020
*/
/* AI2 is quite territorial. It has three ordered priorities. 
1) If it currently holds 1/2 of small island, 2/3 of middle island or 3/4 of large island, 
it will always prioritize (re)capturing its lost territory. 
2) It is very suspicious of AI1 and will nextafter attempt to take holdings from it where it is possible. 
It will also bolster its defences around AI1 to exploit its tendency to attack weaker countries.
3) Last, it also seeks to bolster its general defences and will the in case of no optimal attack or defence strategy seek to bolster the defences more overall along the borders.
Perhaps until a new solution presents itself.

It does not consider AI0 a big threat and will never prioritize it. This does not always go well.
*/
  
  int priorityTarget; //(re)Capture island
  int secondaryTarget; //Sabotage AI1's efforts
  int tertiaryTarget; //General attack where success is likely
  
  int attackingCountry; //which friendly country is attacking
  boolean intendsToAttackTarget;
  
  // students should implement this function, place only the number of armies passed forward into this function
  void vPlaceArmies(Country[] ownedCountries, int numArmies)
  {
    priorityTarget = checkIslandStatus(); //checks current holdings for potential island sets if striking now
    secondaryTarget = -1;
    tertiaryTarget = -1;
    
    if(priorityTarget != -1) //proceeds with island takeover
    {
      int neighborToBolster = checkIslandNeighborCountries(priorityTarget); //find the neighbor to bolster with armies
      int delta_ArmySize = compareArmies(priorityTarget, neighborToBolster, numArmies);
      intendsToAttackTarget = checkIfIntendingToAttack(delta_ArmySize); //is success likely?
      
      if(intendsToAttackTarget == true)
      {
        while(countries[neighborToBolster].iGetArmies() < countries[priorityTarget].iGetArmies() + 1 && numArmies >= 0)
        {
          countries[neighborToBolster].vStationArmies(1);
          numArmies--;
          println("Country "+countries[neighborToBolster].iGetID()+" has received one army reinforements; there is now a total of "+countries[neighborToBolster].iGetArmies()+" armies stationed.");
        }
        attackingCountry = neighborToBolster;
      } 
    }
    
    
    if(numArmies > 0)
    {
      for(int i = 0; i < ownedCountries.length; i++)
      {
        for(int j = 0; j < 4; j++)
        {
          if(ownedCountries[i].borders[j] != -1 && countries[ownedCountries[i].borders[j]].iOwner == player1.iID) //checks for all neighboring countries owned by AI1
          {   
            int delta_ArmySize = compareArmies(countries[ownedCountries[i].iID].iGetID(), countries[ownedCountries[i].borders[j]].iGetID(), numArmies);
            if(secondaryTarget == -1 && priorityTarget == -1) //if a secondary target is currently undeclared 
            {
              intendsToAttackTarget = checkIfIntendingToAttack(delta_ArmySize); //is success likely?
            }
            
            if(intendsToAttackTarget == true)
            {
              secondaryTarget = countries[ownedCountries[i].borders[j]].iGetID();
              attackingCountry = ownedCountries[i].iGetID();
              while(ownedCountries[i].iGetArmies() < countries[ownedCountries[i].borders[j]].iGetArmies() + 1 && numArmies > 0)
              {
                ownedCountries[i].vStationArmies(1);
                numArmies--;
                println("Country "+ownedCountries[i].iGetID()+" has received one army reinforements; there is now a total of "+countries[ownedCountries[i].iGetID()].iGetArmies()+" armies stationed.");
                intendsToAttackTarget = false;
              }
            }
          }
        }
      }
    }
     
    int countryIndex = 0;
    while(numArmies > 0) //I copied over code from AI1 in order to compare borders because my own attempt kept on resulting in errors.
    { //Modified it to fit the logic of my implementation.
      for (int i = 0; i < 4; i++)
      {
        if (ownedCountries[countryIndex].borders[i] != -1 && countries[ownedCountries[countryIndex].borders[i]].iOwner != iID)
        {
          if(numArmies > 0)
          {
            ownedCountries[countryIndex].vStationArmies(1);
            numArmies--;
            println("Country "+ownedCountries[countryIndex].iGetID()+" has received one army reinforements; there is now a total of "+countries[countryIndex].iGetArmies()+" armies stationed.");
          }
          if(priorityTarget == -1 && secondaryTarget == -1 && tertiaryTarget == -1)
          {
            if(ownedCountries[countryIndex].iGetArmies() > countries[ownedCountries[countryIndex].borders[i]].iGetArmies() + 1)
            {
              attackingCountry = ownedCountries[countryIndex].iGetID();
              tertiaryTarget = countries[ownedCountries[countryIndex].borders[i]].iGetID();
            }
          }
        }
      }
      countryIndex=(countryIndex+1)%ownedCountries.length;
    }  
  }
  
  int checkIslandStatus() 
  { 
    int potentialTargetID = -1;
    
    if (countries[5].iOwner == iID && countries[6].iOwner == iID && countries[7].iOwner == iID && countries[8].iOwner != iID|| //large island
    countries[5].iOwner == iID && countries[6].iOwner == iID && countries[8].iOwner == iID && countries[7].iOwner != iID||
    countries[5].iOwner == iID && countries[7].iOwner == iID && countries[8].iOwner == iID && countries[6].iOwner != iID||
    countries[6].iOwner == iID && countries[7].iOwner == iID && countries[8].iOwner == iID && countries[5].iOwner != iID)
    { 
      if(countries[8].iOwner != iID) 
      {
        potentialTargetID = countries[8].iGetID();
      }
      if(countries[7].iOwner != iID)
      {
        potentialTargetID = countries[7].iGetID();
      }
      if(countries[6].iOwner != iID)
      {
        potentialTargetID = countries[6].iGetID();
      }
      if(countries[5].iOwner != iID)
      {
        potentialTargetID = countries[5].iGetID();
      }
    } 
    else if (countries[1].iOwner == iID && countries[2].iOwner == iID && countries[4].iOwner != iID|| //middle island
    countries[1].iOwner == iID && countries[4].iOwner == iID && countries[2].iOwner != iID||
    countries[2].iOwner == iID && countries[4].iOwner == iID && countries[1].iOwner != iID)
    {
      if(countries[4].iOwner != iID)
      {
        potentialTargetID = countries[4].iGetID();
      }
      if(countries[2].iOwner != iID)
      {
        potentialTargetID = countries[2].iGetID();
      }
      if(countries[1].iOwner != iID)
      {
        potentialTargetID = countries[1].iGetID();
      }
    }
    else if (countries[0].iOwner == iID && countries[3].iOwner != iID|| //small island
    countries[3].iOwner == iID && countries[0].iOwner != iID)
    {
      if(countries[3].iOwner != iID)
      {
        potentialTargetID = countries[3].iGetID();
      }
      if(countries[0].iOwner != iID)
      {
        potentialTargetID = countries[0].iGetID();
      }
    } 

    return potentialTargetID;
  }
  
  int checkIslandNeighborCountries(int priorityTargetID) 
  {
    int [] neighborsID = new int[4]; //choose one of the following friendly neighbouring countries to the potential target country
    int currentlyLargestArmy = -1;
    for(int i = 0; i < 4; i++)
    {
      if(countries[countries[priorityTargetID].borders[i]].iOwner == iID)
      {
        neighborsID[i] = countries[countries[priorityTargetID].borders[i]].iGetID();
        for(int j = 0; j < 4; j++)
        {
          if(countries[neighborsID[i]].borders[j] != iID && countries[neighborsID[i]].borders[j] != priorityTargetID)
          {
            return neighborsID[i]; //prioritize bolstering a neighbouring country currently inaccessible to AI from other countries except potential target
          }
        }
      }
    }
    for(int i = 0; i < neighborsID.length; i++)
    {
      if(countries[neighborsID[i]].iGetArmies() > currentlyLargestArmy)
      {
        currentlyLargestArmy = neighborsID[i]; //otherwise, prioritize bolstring the neighbouring country with the largest army
      }
    }
    return currentlyLargestArmy; 
  }
  
  int compareArmies(int targetID, int friendlyCountryID, int numArmies)
  {
    return countries[friendlyCountryID].iGetArmies() + numArmies - countries[targetID].iGetArmies();
  }
  
  boolean checkIfIntendingToAttack(int delta_ArmySize)
  {
    if(delta_ArmySize >= 0) //consider removing "equals to" sign
    {
      return true;
    } else 
    {
      return false;
    }
  }
  
  // students should implement this function, make only a maximum of 1 attack (choosing not to attack is valid but you cannot attack multiple times)
  void vMakeAttack(Country[] ownedCountries)
  {
    if(priorityTarget != -1)
    {
      countries[attackingCountry].bAttack(priorityTarget);
    } else if(secondaryTarget != -1) 
    {
      countries[attackingCountry].bAttack(secondaryTarget);
    } else if(tertiaryTarget != -1)
    {
      countries[attackingCountry].bAttack(tertiaryTarget);
    }
  }
}
