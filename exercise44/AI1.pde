// This is a 'smart' AI
// Each turn it will place its armies in countries that have hostile borders
// Each turn it will find the attack with the largest army differential and make that attack
// This AI may choose to not attack if it finds no borders with weaker armies

class AI1
{
  int iID=0;
  color cDisplayCol = color(150, 0, 200);

  public AI1(int id)
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

  void vPlaceArmies(Country[] ownedCountries, int numArmies)
  {
    int countryIndex = 0;
    do
    {
      for (int i = 0; i < 4; i++) // check the borders for countries that border enemy countries and place our armies there
      {
        if (ownedCountries[countryIndex].borders[i] != -1 && countries[ownedCountries[countryIndex].borders[i]].iOwner != iID)
        {
          ownedCountries[countryIndex].vStationArmies(1);
          numArmies--;
          println("Country "+ownedCountries[countryIndex].iGetID()+" has received one army reinforements; there is now a total of "+countries[countryIndex].iGetArmies()+" armies stationed.");
          break;
        }
      }

      countryIndex=(countryIndex+1)%ownedCountries.length;
    } 
    while (numArmies>0);
  }
  void vMakeAttack(Country[] ownedCountries)
  {
    // loop through all owned countries and their borders to find attackable countries
    int powerDif = 0;
    int attackSource = -1;
    int countryIndex = -1;
    for (int i = 0; i < ownedCountries.length; i++)
    {
      for (int j = 0; j < 4; j++)
      {
        int border = ownedCountries[i].borders[j];
        if (border != -1 && countries[border].iOwner != iID)
        {
          int dif = ownedCountries[i].iArmiesNumber - countries[border].iArmiesNumber;
          if (dif > powerDif)
          {
            powerDif = dif;
            attackSource = i;
            countryIndex = border;
          }
        }
      }
    }
    
    if (powerDif > 0)
    {
      ownedCountries[attackSource].bAttack(countryIndex);
    }
  }
}
