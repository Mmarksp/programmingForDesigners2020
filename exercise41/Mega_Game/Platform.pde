class Platform {
  PVector pos;
  int w, h;
  
  PImage [][] sprite;
  int numberOfTilesX, numberOfTilesY;
  
  Platform(float x, float y, int plat_width, int plat_height){
    pos = new PVector(x, y);
    w = plat_width;
    h = plat_height;
    
    numberOfTilesX = w / 36;
    numberOfTilesY = h / 36;
    sprite = new PImage[numberOfTilesX][numberOfTilesY];
  }
  
  void display(){
    for(int i = 0; i < numberOfTilesX; i++) {
      for(int j = 0; j < numberOfTilesY; j++) {
        image(sprite[i][j], this.pos.x + 36 * i + 36 * 0.5, this.pos.y + 36 * j + 36 * 0.5);
      }
    }
  }
}
