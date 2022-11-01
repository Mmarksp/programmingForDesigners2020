class Country
{
  int iID=-1;
  int iPosX=0;
  int iPosY=0;
  int[] borders={-1, -1, -1, -1};  //bordering countries, max 4
  int iOwner=-1;
  int iArmiesNumber=0;

  Country(int iID)
  {
    this.iID=iID;
  }

  void vInit(int iPosX, int iPosY, int border0, int border1, int border2, int border3)
  {
    this.iPosX=iPosX;
    this.iPosY=iPosY;
    borders[0]=border0;
    borders[1]=border1;
    borders[2]=border2;
    borders[3]=border3;
  }

  void vReset(int iArmiesNumber, int owner)
  {
    iOwner=owner;
    this.iArmiesNumber=iArmiesNumber;
  }

  void display()
  {
    //fill(country);
    fill(getPlayerCol(iOwner));
    rect(iPosX, iPosY, iSize, iSize, 15);
    fill(black);
    text("Country "+iID, iPosX+(iSize*0.1), iPosY+(iSize*0.4));
    text("Owner: AI "+iOwner, iPosX+(iSize*0.1), iPosY+(iSize*0.4)+textsize);
    text("Armies: "+iArmiesNumber, iPosX+(iSize*0.1), iPosY+(iSize*0.4)+(2*textsize));
  }
  
  int iGetID()
  {
    return iID;
  }
  
  int iGetOwner()
  {
    return iOwner;
  }
  
  void vSetOwner(int o)
  {
    iOwner=o;
  }
  
  int iGetArmies()
  {
    return iArmiesNumber;
  }
  
  void vSetArmies(int a)
  {
    iArmiesNumber=a;
  }
  
  void vStationArmies(int a)
  {
    iArmiesNumber+=a;
  }
  
  int[] iGetBorder()
  {
    return borders;
  }
  
  Boolean bAttack(int iCountryDst)
  {
    // you must have at least 1 army that can move into the newly acquired territory, we return if you try and attack with 1 army or less
    if(iArmiesNumber <= 1)
    {
      println("AI "+iOwner+" tried to attack country "+iCountryDst+" from country "+iID+" but does not have enough armies to invade. The attack fails.");
      return false;
    }
    
    print("AI "+iOwner+" attacks country "+iCountryDst+" from country "+iID+"..."); 
    // 50/50 outcome for each battle
    // attacking with more armies gives the player a higher probability of winning the war
    int battles = 0;
    do
    {
      if(random(0, 1)>=0.5) // 50/50 roll on an army winning
      {
        // attacker wins this fight
        countries[iCountryDst].vSetArmies(countries[iCountryDst].iArmiesNumber-1);
      }
      else
      {
        iArmiesNumber--;
      }
      battles++;
    } while (iArmiesNumber > 1 && countries[iCountryDst].iArmiesNumber > 0);
    
    print(" and after " + battles + " battles ");
    
    if(countries[iCountryDst].iArmiesNumber <= 0)
    {
      // attacker won the war
      println ("liberates it from AI "+countries[iCountryDst].iGetOwner()+"!");
      countries[iCountryDst].vSetOwner(iOwner);
      countries[iCountryDst].vSetArmies(iArmiesNumber-1);
      iArmiesNumber=1;  //all armies -1 move from the src to the dst country
      return true;
    }
    
    // attacker lost the war
    println ("fails to liberate it from AI "+countries[iCountryDst].iGetOwner()+".");
    return false;
  }
}
