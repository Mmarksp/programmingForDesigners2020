
//Risk Easy AI
//by Max Wrighton and dace.de 2020

//Rules:
//Countries with more than 1 army in them can attack neighbouring countries
//Every turn the number of a player's countries devided by three are reinforments that can be placed in any country of that player.
//Every player gets 2 armies per turn independently of number of countries they own.
//There are bonus reinforcements for owning a complete island, +1 for small island, +2 for medium island, and +3 for large island
//When attacking a country, all armies -1 are involved, and all surviving armies move into the conqured country.
//Players are out of the game if they lose their last country.
//The player who owns all countries wins.

boolean stepThrough = false; // this can be set to true in order to slow the pace of the game for debugging
boolean spacePressed = false;
int iGamesToPlay = 150;

Country[] countries=null; // array of all countries

// AI players
AI0 player0=null;
int iWinsPlayer0=0;
AI1 player1=null;
int iWinsPlayer1=0;
AI2 player2=null;
int iWinsPlayer2=0;

// Tracking the active player and the turn
int iPlayerActive=0;
int iTurn=0;

// tracking the game number
int iGameNumber=0;
int iStartingPlayer=0;

// quick reference values
int iSize=100; // used for displaying countries
int textsize=12; // text size reference
color sea=color(20, 40, 255); // background color: blue ish
color black=color(0, 0, 0); // text and border color: black

// setup project
void setup()
{
  size(600, 480);

  countries=new Country[9];
  // for each country in the new array: create a new country, set its armies to 2 and set its owner
  for (int i = 0; i < countries.length; i++)
  {
    countries[i] = new Country(i);
    countries[i].vReset(2, i%3);
  }
  // country positions and borders are hard coded
  countries[0].vInit(140, 25, 3, 1, -1, -1);
  countries[1].vInit(340, 50, 0, 2, 4, -1);
  countries[2].vInit(440, 25, 1, 4, -1, -1);
  countries[3].vInit(65, 125, 0, 5, -1, -1);
  countries[4].vInit(440, 125, 1, 2, 7, -1);
  countries[5].vInit(200, 275, 3, 6, 8, -1);
  countries[6].vInit(300, 250, 5, 7, 8, -1);
  countries[7].vInit(400, 300, 4, 6, 8, -1);
  countries[8].vInit(300, 350, 5, 6, 7, -1);

  // initialise players with their IDs
  player0=new AI0(0);
  player1=new AI1(1);
  player2=new AI2(2);
  
  drawHUD(); // draw the hud at the end of the setup so that if stepthrough is enabled we still see something on start up
}

// reset countries
void resetGame()
{
  iGameNumber++;
  if (iGameNumber >= iGamesToPlay)
  {
    println("\n"+iGamesToPlay+" games have been played:\n"+
      "AI0 won "+iWinsPlayer0+" games\n"+
      "AI1 won "+iWinsPlayer1+" games\n"+
      "AI2 won "+iWinsPlayer2+" games");
    noLoop();
    return;
  }

  iStartingPlayer=(iStartingPlayer+1)%3; // the starting player changes each round so we get a fairer representation
  iPlayerActive=iStartingPlayer;
  iTurn=0;

  println("\n--------------------------------Starting game number: "+iGameNumber+"--------------------------------");

  // for each country in the new array: set its armies to 2 and set its owner
  for (int i = 0; i < countries.length; i++)
  {
    countries[i].vReset(2, i%3);
  }
}

color getPlayerCol(int playerID)
{
  if (playerID==0) { 
    return player0.cDisplayCol;
  } else if (playerID==1) { 
    return player1.cDisplayCol;
  } else /*playerID is 2*/ { 
    return player2.cDisplayCol;
  }
}

void drawHUD()
{
  fill(0, 0, 0, 120); // transparent black
  rect(15, 360, 160, 100);
  rect(15, 360, 160, 20);
  fill(255);
  text("Risk Easy Stats", 26, 375);
  text("Game number: "+iGameNumber+"/"+iGamesToPlay+"\n"+
  "AI 0 wins: "+iWinsPlayer0+"\n"+
  "AI 1 wins: "+iWinsPlayer1+"\n"+
  "AI 2 wins: "+iWinsPlayer2+"\n"+
  // add more on screen info here
  ((stepThrough) ? "\nstepThrough enabled\nSPACE BAR TO STEP":""),
  26, 405);
}

void keyPressed()
{
  // for the stepThrough
  if (key==32)
  {
    spacePressed = true;
  }
}

void draw()
{
  // simple step through system so you need to press space to advance
  // this requires the boolean 'stepThrough' to be set to true
  if (stepThrough && !spacePressed) { return; }
  spacePressed = false;

  // run the correct AI's logic based on the active player
  println("Turn "+iTurn+"--------------------------------");
  if       (iPlayerActive==0) { player0.vTurnMake(); }
  else if  (iPlayerActive==1) { player1.vTurnMake(); }
  else /*iPlayerActive is 2*/ { player2.vTurnMake(); }

  //check winning
  int iWinCountries=0;
  for (int i = 0; i < countries.length; i++)
  {
    if (countries[i].iGetOwner()==iPlayerActive) { iWinCountries++; }
  }
  if (iWinCountries==countries.length)
  {
    println("AI "+iPlayerActive+" won by liberating all "+iWinCountries+" countries after "+iTurn+" turns!");
    if       (iPlayerActive==0) { iWinsPlayer0++; }
    else if  (iPlayerActive==1) { iWinsPlayer1++; }
    else /*iPlayerActive is 2*/ { iWinsPlayer2++; }
    resetGame();
  }

  // display the game screen
  background(sea);
  // these lines being drawn are showing the conections across the sea
  line(240, 75, 340, 100);
  line(115, 175, 240, 325);
  line(490, 225, 440, 300);
  for (int i = 0; i < countries.length; i++) { countries[i].display(); }
  drawHUD();

  // increment player active and turn data
  iPlayerActive=(iPlayerActive+1)%3; // increments iPlayerActive then wraps it to make sure it is never above 2
  iTurn++;
}
