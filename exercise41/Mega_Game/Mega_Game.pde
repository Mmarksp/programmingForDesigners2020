/*Mega Game - 16/12/2020
 Eva Louise Christensen & Mark Staun Poulsen*/

/*Credits:
Sprites by Team Cherry, Hollow Knight, 2017
Tiles were drawn by Eva
*/

/*Introduction:
Defeat all waves of enemies over the three levels as fast as possible.
The timer counts down from 5 min. You get points for how much time you have left.
Remember to heal using soul if you lose life. 
You can gather more soul by hitting enemies.
*/

//Instatiating objects
Title title = new Title();
Menu menu = new Menu();
GameOver gameover = new GameOver();
HighScore highscore = new HighScore();
Controls controls = new Controls();
Table table;
PrintWriter writer;

Player player = new Player(40, 640, 36, 72);
PImage KnightSpritesheet;
ArrayList<Platform> platforms = new ArrayList<Platform>();
PImage PlatformTilesheet;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Gruzzer>gruzzers = new ArrayList<Gruzzer>();
PImage GruzzerSpritesheet;
ArrayList<Tiktik> tiktiks = new ArrayList<Tiktik>();
PImage TiktikImage;
Mawlek mawlek;
PImage MawlekSpritesheet;
Spit spit;
Collider collider = new Collider();
Particle_system[] blood = new Particle_system[100];


void setup() {
  size(800, 800);
  
  //load images
  PImage background_img = loadImage("menu background.png");
  title.background_img = background_img;
  menu.background_img = background_img;
  gameover.background_img = background_img;
  highscore.background_img = background_img;
  controls.background_img = background_img;
  KnightSpritesheet = loadImage("KnightSpritesheet.png");
  for (int i = 0; i < 2; i++) {
    player.sprite[i] = KnightSpritesheet.get(36 * i, 0, 36, KnightSpritesheet.height);
  }
  GruzzerSpritesheet = loadImage("GruzzerSpritesheet.png");
  TiktikImage = loadImage("Tiktik.png");
  MawlekSpritesheet = loadImage("MawlekSpritesheet.png");
  PlatformTilesheet = loadImage("PlatformTilesheet.png");
  
  //particlesystem constructed
  for (int i = 0; i < blood.length; i++) {
    if (i%2 == 1) {
      blood[i] = new Particle_system(0, -20, random(2, 10), random(-2, 2));
    } else {
      blood[i] = new Particle_system(0, -20, random(-10, -2), random(-2, 2));
    }
  }

  //highscore table loaded, and writer created
  table = loadTable("hsTable.csv", "header, csv");
  highscore.read();
  //writer = createWriter("hsTable.csv");
}

//Global variables here
float deltaTime;
float lastTime = millis();
float frameDuration = 0.0333; //30 frames per second

String gameState = "title";
String playerName = "";
int score, scoreMin, scoreSec, timerScore = 0;
int level, wave, alphaLevelText;
boolean jumpKeyWasPressed = false;
boolean attackKeyWasPressed = false;

float gravity = 0.37;

//blood particle system
void createParticles(float x, float y) {
  for (int i = 0; i < blood.length; i++) {
    if (i%2 == 1) {
      blood[i] = new Particle_system(x, y, random(2, 10), random(-2, 2));
    } else {
      blood[i] = new Particle_system(x, y, random(-10, -2), random(-2, 2));
    }
  }
}

void mouseClicked() {
  if (gameState == "title") {
    gameState = "menu";
  } else if (gameState == "menu") {
    menu.select();
  } else if (gameState == "highscore") {
    highscore.select();
  } else if (gameState == "controls") {
    controls.select();
  } else if (gameState == "gameover") {
    gameover.select();
  }
}

void keyPressed() {
  if (gameState == "title") {
    if (key == ' ') {
      gameState = "menu";
    }
  } else if (gameState == "menu") {
    if (key == ' ') {
      gameState = "game";
    }
  } else if (gameState == "gameover") {
    if (key != CODED) {
      if (highscore.checkScore() && gameover.input) {
        if (keyCode != BACKSPACE && key != ' ') {
          playerName = playerName + str(key);
          println(playerName);
          println(score);
          if (playerName.length() > 2) {
            highscore.scores = append(highscore.scores, score);
            highscore.players = append(highscore.players, playerName);
            gameover.input = false;
            gameState = "highscore";
          }
        }
      }
    }
  } else if (gameState == "game") {
    if (key == 'a' || key == 'd') {
      player.isMoving = true;
      player.storedMoveKey = key;
    }
    if (key == ' ' && jumpKeyWasPressed == false || key == 'w' && jumpKeyWasPressed == false) {
      player.isJumpingOnce = true;
      jumpKeyWasPressed = true;
    }
    if (key == CODED) {
      if (keyCode == UP && attackKeyWasPressed == false || //if no attack key is pressed and player attacks
        keyCode == DOWN && attackKeyWasPressed == false && player.isGrounded == false || //cannot hit downwards when standing on ground
        keyCode == RIGHT && attackKeyWasPressed == false || 
        keyCode == LEFT && attackKeyWasPressed == false) {
        player.isAttackingOnce = true; //attack sequence must finish before able to attack again, see player.checkIfAttacking()
        player.storedAttackKey = keyCode;
        attackKeyWasPressed = true; //keyPressed will not repeat
      }
      else if (keyCode == SHIFT) {
        player.isHealing = true;
      }
    }
    //for testing purposes
    if (key == 'ø') {
      score =110;
      gameState="gameover";
    }
  }
}

void keyReleased() {
  if (key == 'a' && player.storedMoveKey != 'd' || key == 'd' && player.storedMoveKey != 'a') {
    player.isMoving = false;
  }
  if (key == ' ' || key == 'w') {
    player.breakJump = true;
    jumpKeyWasPressed = false;
  }
  if (key == CODED) {
    if (keyCode == UP ||
      keyCode == DOWN || 
      keyCode == RIGHT ||
      keyCode == LEFT) {
      attackKeyWasPressed = false;
    }
    if (keyCode == SHIFT)
    {
      player.isHealing = false;
    }
  }
}

//setup each level
void buildLevel() { //insert creating new objects such as platforms and enemies
  removeObjects();
  
  int tile = 36;
  platforms.add(new Platform(0, height-18, tile * 28, tile)); //Floor
  platforms.add(new Platform(0, -18, tile * 28, tile)); //Roof
  platforms.add(new Platform(-36, 0, tile, tile * 28)); //Left Wall
  platforms.add(new Platform(width, 0, tile, tile * 28)); //RIght Wall
  
  int startPositionX = 30;
  float startPositionY = height - 18 - player.h;
  if (level == 1) {
    player.pos.x = startPositionX;
    player.pos.y = startPositionY;
    
    platforms.add(new Platform(width * 0.4, 580, tile * 10, tile));
    platforms.add(new Platform(72, 300, tile * 10, tile));
    
    if (wave == 1) {
      score = 900;
      scoreMin = 5;
      scoreSec = 0;
      player.hp = 5;
      player.soul = 99;
      tiktiks.add(new Tiktik(100, 300 - TiktikImage.height * 0.5, TiktikImage.width * 0.75, TiktikImage.height * 0.5, 9, 10)); //last two are hp and soul_leak
      tiktiks.add(new Tiktik(600, 580 - TiktikImage.height * 0.5, TiktikImage.width * 0.75, TiktikImage.height * 0.5, 9, 10)); //rest is position and size
    } else if (wave == 2) {
      gruzzers.add(new Gruzzer(40, 400, 80 * 0.60, GruzzerSpritesheet.height * 0.60, 9, 20));
      gruzzers.add(new Gruzzer(600, 400, 80 * 0.60, GruzzerSpritesheet.height * 0.60, 9, 20));
    } else if (wave == 3) {
      gruzzers.add(new Gruzzer(100, 60, 80 * 0.75, GruzzerSpritesheet.height * 0.75, 9, 20));
      gruzzers.add(new Gruzzer(600, 400, 80 * 0.75, GruzzerSpritesheet.height * 0.75, 9, 20));
      tiktiks.add(new Tiktik(100, 300 - TiktikImage.height * 0.5, TiktikImage.width * 0.75, TiktikImage.height * 0.5, 9, 10));
      tiktiks.add(new Tiktik(180, 300 - TiktikImage.height * 0.5, TiktikImage.width * 0.75, TiktikImage.height * 0.5, 9, 10));
    }
  } else if (level == 2) {
    player.pos.x = startPositionX;
    player.pos.y = startPositionY;
    
    platforms.add(new Platform(tile * 7 + 250, 620, tile * 4, tile));
    platforms.add(new Platform(180, 580, tile * 4, tile));
    platforms.add(new Platform(80, 380, tile * 4, tile));
    platforms.add(new Platform(350, 180, tile * 4, tile));
    platforms.add(new Platform(tile * 7 + 300, 400, tile * 4, tile));

    if (wave == 1) {
      tiktiks.add(new Tiktik(37 * 7 + 25, 580 - TiktikImage.height * 0.5, TiktikImage.width * 0.75, TiktikImage.height * 0.5, 9, 10));
      tiktiks.add(new Tiktik(90, 380 - TiktikImage.height * 0.5, TiktikImage.width * 0.75, TiktikImage.height * 0.5, 9, 10));
      tiktiks.add(new Tiktik(36 * 7 + 370, 400 - TiktikImage.height * 0.5, TiktikImage.width * 0.75, TiktikImage.height * 0.5, 9, 10));
    } else if (wave == 2) {
      tiktiks.add(new Tiktik(382, 180 - TiktikImage.height * 0.5, TiktikImage.width * 0.75, TiktikImage.height * 0.5, 9, 10));
      gruzzers.add(new Gruzzer(40, 300, 80 * 0.75, GruzzerSpritesheet.height * 0.75, 9, 20));
      gruzzers.add(new Gruzzer(600, 500, 80 * 0.75, GruzzerSpritesheet.height * 0.75, 9, 20));
    } else if (wave == 3) {
      tiktiks.add(new Tiktik(36 * 8 + 260, 620 - TiktikImage.height * 0.5, TiktikImage.width * 0.75, TiktikImage.height * 0.5, 9, 10));
      gruzzers.add(new Gruzzer(200, 480, 80 * 0.75, GruzzerSpritesheet.height * 0.75, 9, 20));
      gruzzers.add(new Gruzzer(300, 60, 80 * 0.75, GruzzerSpritesheet.height * 0.75, 9, 20));
      gruzzers.add(new Gruzzer(700, 200, 80 * 0.75, GruzzerSpritesheet.height * 0.75, 9, 20));
    }
  } else if (level == 3) {
    player.pos.x = startPositionX;
    player.pos.y = startPositionY;
    
    platforms.add(new Platform(0, 580, tile * 2, tile));
    platforms.add(new Platform(width - tile * 2, 580, tile * 2, tile));
    platforms.add(new Platform(width * 0.25 - tile * 2, 380, tile * 2, tile));
    platforms.add(new Platform(width * 0.75, 380, tile * 2, tile));

    mawlek = new Mawlek(width*0.5 - 75, height - 18 - MawlekSpritesheet.height * 0.58, 150, MawlekSpritesheet.height, 51, 10);
  }
  
  prepareEnemies();
  preparePlatforms(tile);
  
  alphaLevelText = 255; //fade-out effect
}

void removeObjects() { //objects are removed before creating new ones in buildLevel()
  for (int i = platforms.size() - 1; i >= 0; i--) {
    platforms.remove(i);
  }
  for(int g = gruzzers.size() - 1; g >= 0; g--) {
      if(gruzzers.get(g) == enemies.get(g)) {
        enemies.remove(g);
        gruzzers.remove(g);
      } 
    }
  for(int t = tiktiks.size() - 1; t >= 0; t--) {
    if(tiktiks.get(t) == enemies.get(t)) {
      enemies.remove(t);
      tiktiks.remove(t);
    } 
  }
  
  if(mawlek != null) {
    enemies.remove(0);
    mawlek = null;
  }
}

void prepareEnemies() { //sprites are added and enemy type is added to array of overall enemies
  for (int i = 0; i < gruzzers.size(); i++) {
    for (int j = 0; j < gruzzers.get(i).sprite.length; j++) {
      gruzzers.get(i).sprite[j] = GruzzerSpritesheet.get(80 * j, 0, 80, GruzzerSpritesheet.height);
    }
    enemies.add(gruzzers.get(i));
  }
  for (int i = 0; i < tiktiks.size(); i++) {
    tiktiks.get(i).sprite = TiktikImage;
    enemies.add(tiktiks.get(i));
  }
  
  if(level == 3) {
    for (int i = 0; i < 3; i++) {
      mawlek.sprite[i] = MawlekSpritesheet.get(10 + 330 * i, 0, 320, MawlekSpritesheet.height);
    }
    enemies.add(mawlek);
  }
}

void preparePlatforms(int tile_size) {
  int [] tileSprites = {0, 1, 2};
  int rand;
  for(int i = 0; i < platforms.size(); i++) {
    for(int j = 0; j < platforms.get(i).w / tile_size; j++) {
      for(int k = 0; k < platforms.get(i).h / tile_size; k++) {
        rand = (int) random(tileSprites.length);
        platforms.get(i).sprite[j][k] = PlatformTilesheet.get(tile_size * tileSprites[rand], 0, tile_size, tile_size);
      }
    }
  }
}

void updateLevel() { //check if win conditions or if next level/wave
  if (enemies.size() == 0) {
    if (level == 3) {
      if (score < 0) { //determined by timer counting down
        score = 0;
      } else {
        score *= 10; //timer * 10 = points
        gameState = "gameover";
      }
      println("You finished with "+scoreMin+":"+scoreSec+" remaining");
      println("You receive "+score+"points");
    } else if (wave == 3) {
      level++;
      wave = 1;
    } else {
      wave++;
    }
    buildLevel();
  }
  push();
  textSize(60);
  fill(255, 255, 255, alphaLevelText);
  if (level == 3) {
    text("Final Level", width*0.5, height*0.6);
  } else {
    text("Level "+level+", Wave "+wave, width*0.5, height*0.6);
  }
  alphaLevelText--;
  pop();
}

void draw() {
  //Time Fix
  deltaTime = millis() - lastTime;

  //Game State
  if (deltaTime >= frameDuration) {
    if (gameState == "title") {
      title.display();
    } else if (gameState == "menu") {
      menu.display();
      menu.menu();
    } else if (gameState == "gameover") {
      gameover.display();
      gameover.menu();
    } else if (gameState == "highscore") {
      highscore.display();
      highscore.menu();
    } else if (gameState == "controls") {
      controls.display();
      controls.menu();
    } else if (gameState == "game") {
      background(50, 50, 100);
      fill(255);
      text("Time:", 636, 50);
      text(".", 716, 50);
      text(scoreMin, 700, 50);
      text(scoreSec, 740, 50);
      stroke(2);
      
      updateLevel();
      timerScore++;
      playerName = "";
      //Movement and collission in following order

      //Plaform colliders
      for (int i = 0; i < platforms.size(); i++) {
        if (collider.isColliding(player.pos.x, player.pos.y, player.w, player.h, platforms.get(i).pos.x, platforms.get(i).pos.y, platforms.get(i).w, platforms.get(i).h)) {
          String whichSide = collider.whichSide(player.pos.x, player.pos.y, player.w, player.h, platforms.get(i).pos.x, platforms.get(i).pos.y, platforms.get(i).w, platforms.get(i).h);
          if (whichSide == "onTopOf") {
            player.detectedGround = true;
          }
          player.collidingPlatforms(whichSide, platforms.get(i).pos.x, platforms.get(i).pos.y, platforms.get(i).w, platforms.get(i).h);
        }
        for (int j = 0; j < enemies.size(); j++) {
          if (collider.isColliding(enemies.get(j).pos.x, enemies.get(j).pos.y, enemies.get(j).w, enemies.get(j).h, platforms.get(i).pos.x, platforms.get(i).pos.y, platforms.get(i).w, platforms.get(i).h)) {
            String whichSide = collider.whichSide(enemies.get(j).pos.x, enemies.get(j).pos.y, enemies.get(j).w, enemies.get(j).h, platforms.get(i).pos.x, platforms.get(i).pos.y, platforms.get(i).w, platforms.get(i).h);
            for (int g = 0; g < gruzzers.size(); g++) {
              if (enemies.get(j) == gruzzers.get(g)) {
                gruzzers.get(g).colliding(whichSide);
              }
            }
            for (int t = 0; t < tiktiks.size(); t++) {
              if (enemies.get(j) == tiktiks.get(t)) {
                tiktiks.get(t).colliding(platforms.get(i).pos.x, platforms.get(i).pos.y, platforms.get(i).w, platforms.get(i).h);
              }
            }
          }
          if (spit != null) {
            if (collider.isColliding(spit.pos.x, spit.pos.y, spit.w, spit.h, platforms.get(i).pos.x, platforms.get(i).pos.y, platforms.get(i).w, platforms.get(i).h)) {
              spit.colliding();
            }
          }
        }
        platforms.get(i).display();
      }
      
      

      //Enemy colliders
      for (int i = 0; i < enemies.size(); i++) {
        if (collider.isColliding(player.pos.x, player.pos.y, player.w, player.h, enemies.get(i).pos.x, enemies.get(i).pos.y, enemies.get(i).w, enemies.get(i).h)) {
          player.isAttackedOnce = true;
        }
        if (spit != null) {
          if (collider.isColliding(player.pos.x, player.pos.y, player.w, player.h, spit.pos.x, spit.pos.y, spit.w, spit.h)) {
            player.isAttackedOnce = true;
            spit.colliding();
          }
        }
      }
      
      //Update objects
      player.update();
      for (int g = 0; g < gruzzers.size(); g++) {
        gruzzers.get(g).update();
      }
      for (int t = 0; t < tiktiks.size(); t++) {
        tiktiks.get(t).update();
      }
      if (mawlek != null) {
        mawlek.update();
        if (spit != null) {
          spit.update();
        }
      }
      
      //particle system
      for (int i = 0; i < blood.length; i++) {
        blood[i].display();
        blood[i].move();
      }
    }
    
    if (timerScore >= 60) {
      score--;
      scoreSec--;
      if (scoreSec < 0) {
        scoreMin--;
        scoreSec = 59;
      }
      timerScore = 0;
    }
    lastTime += deltaTime;
  }
}

void stop() {
  writer.flush();
  writer.close();
}
