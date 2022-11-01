//here goes code we've thrown out
/*
draw(){
 rect(0,0,800,20); 
 rect(0,780,800,800);
 rect(0,0,20,800);
 rect(780,0,800,800);
 rect(140,620,36*4,36);
 rect(460,620,36*4,36);
}
*/

/*String gameState = "game"; //global variable for current screen/state
 boolean mouseIsClicked = false;
 
 void mouseClicked() {
 if (gameState == "gameover") {
 mouseIsClicked = true;
 highScore.button_click();
 } else if (gameState == "highscore") {
 mouseIsClicked = true;
 playAgain.button_click();
 } else {
 mouseIsClicked = false;
 }
 }
 
 int letters = 0;
 String[] playerName = {};
 int score = 0;
 void keyPressed() {
 if (key == ENTER) { //print name on hs
 for (int i=0; i<playerName.length; i++) {
 fill(255);
 textSize(20);
 text(playerName[i], 130+i*14, 300);
 //need to add player name to hs file & display on the hs screen
 }
 text(score, 240, 300);
 } //input name 
 else if (gameState == "highscore" && letters < 5) {
 String letter = str(key);
 playerName = append(playerName, letter);
 fill(255);
 textSize(26);
 textAlign(CENTER);
 text(letter, 160+20*letters, 600);
 if (gameState == "highscore" && letters >= 4) {
 text("Press enter", 200, 640);
 //text(playerName, 200, 200);
 }
 letters++;
 } else if (letters >= 4) {
 letters = 0;
 } else if (gameState == "game") { //attempting to reset,
 while (playerName.length > 0) { //so I can take 2 hs without restarting program
 shorten(playerName);
 }
 }
 }
 
 void collisionCheck() {
 float sm = 5;
 float bird_box_x = flappy.pos_x + sm*2, bird_box_y = flappy.pos_y + sm, bird_box_w = flappy.bird_width - 3*sm, bird_box_h = flappy.bird_height - 2*sm; //making a smaller hitbox than the bird
 if (bird_box_x + bird_box_w >= obst1.pos_x &&     // bird right edge past obst left
 bird_box_x <= obst1.pos_x + obst1.obst_w &&         // bird left edge past obst right
 bird_box_y + bird_box_h >= obst1.pos_y &&       // bird bottom edge past obst top
 bird_box_y <= obst1.pos_y + obst1.obst_h ||      // bird top edge past obst top
 bird_box_x + bird_box_w >= obst1.pos_x &&     // top obst
 bird_box_x <= obst1.pos_x + obst1.obst_w &&         
 bird_box_y + bird_box_h >= 0 &&       
 bird_box_y <= obst1.pos_y-260) {   
 obst1.pos_x = 400;
 flappy.die();
 } else if (bird_box_x == obst1.pos_x) {
 print("ya");
 score++;
 }
 }
 
 void score_draw() {
 fill(255);
 textSize(32);
 text(score, 360, 40);
 }*/
/*class Player {
 float x, y, w, h;
 
 Player(){
 w = 36;
 h = 72;
 x = 40;
 y = 780-h;
 }*/
