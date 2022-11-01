// This is a 'random' AI
// Each turn it will place its armies randomly among countries it owns
// Each turn it will make an attack to a random bordering country that it doesn't own
// This AI will always make an attack each turn

class AI0
{
  int iID=0;
  color cDisplayCol = color(0, 150, 200);

  public AI0(int id)
  {
    iID = id;
  }

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

  // implement this function to place the passed number of armies throughout your owned countries
  void vPlaceArmies(Country[] ownedCountries, int numArmies)
  {
    //distribute received armies randomly for now    
    do
    {
      int iCountryRandom=int(random(0, ownedCountries.length));
      ownedCountries[iCountryRandom].vStationArmies(1);
      numArmies--;
      println("Country "+ownedCountries[iCountryRandom].iGetID()+" has received one army reinforements; there is now a total of "+countries[iCountryRandom].iGetArmies()+" armies stationed.");
    } 
    while (numArmies>0);
  }

  // implement this function to attack a bordering country
  void vMakeAttack(Country[] ownedCountries)
  {
    // loop through all owned countries and their borders to find attackable countries
    int attackableCountries = 0;
    for (int i = 0; i < ownedCountries.length; i++)
    {
      for (int j = 0; j < ownedCountries[i].borders.length; j++)
      {
        int borderVal = ownedCountries[i].borders[j];
        if (borderVal != -1 && countries[borderVal].iOwner != iID)
        {
          attackableCountries++;
        }
      }
    }

    // pick a random attackable country then go through the same loop until you hit that attack
    int countryToAttack=int(random(0, attackableCountries));
    attackableCountries=0;
    boolean breakEarly = false;
    for (int i = 0; i < ownedCountries.length; i++)
    {
      for (int j = 0; j < ownedCountries[i].borders.length; j++)
      {
        int borderVal = ownedCountries[i].borders[j];
        if (borderVal != -1 && countries[borderVal].iOwner != iID)
        {
          if (countryToAttack == attackableCountries)
          {
            ownedCountries[i].bAttack(borderVal);
            breakEarly = true;
            break;
          }
          attackableCountries++;
        }
      }

      if (breakEarly)
      {
        break;
      }
    }
  }
}
