//Collider class
class Collider {

  boolean isColliding(float posX1, float posY1, float w1, float h1, float posX2, float posY2, float w2, float h2) {
    if (posX1 + w1 >= posX2 &&     
      posX1 <= posX2 + w2 && 
      posY1 + h1 >= posY2 &&
      posY1 <= posY2 + h2)
    /*if (posX1 + w1 >= posX2 && //upper right corner
    posX1 + w1 <= posX2 + w2 &&
    posY1 >= posY2 &&
    posY1 <= posY2 + h2 ||
    posX1 + w1 >= posX2 && //lower right corner
    posX1 + w1 <= posX2 + w2 &&
    posY1 + h1 >= posY2 &&
    posY1 + h1 <= posY2 + h2 ||
    posX1 >= posX2 && //upper left corner
    posX1 <= posX2 + w2 &&
    posY1 >= posY2 &&
    posY1 <= posY2 + h2 ||
    posX1 >= posX2 && // lower left corner
    posX1 <= posX2 + w2 &&
    posY1 + h1 >= posY2 &&
    posY1 + h1 <= posY2 + h2)*/
      {
      return true;
    } else {
      return false;
    }
  }

  String whichSide(float posX1, float posY1, float w1, float h1, float posX2, float posY2, float w2, float h2) {
    //magic numbers extends collission detection from points to become an area. Tweaked to speed value of player.
    if (posY1 + h1 >= posY2 && 
      posY1 + h1 <= posY2 + 18 && 
      posX1 + w1 >= posX2 + 7 && 
      posX1 <= posX2 + w2 - 7) {
      return "onTopOf";
    } else if (posY1 <= posY2 + h2 && 
      posY1 >= posY2 + h2 - 15 && 
      posX1 + w1 >= posX2 + 7 && 
      posX1 <= posX2 + w2 - 7) {
      return "underneath";
    } else if (posX1 <= posX2 + w2 && 
      posX1 >= posX2 + w2 - 7 && 
      posY1 + h1 >= posY2 && 
      posY1 < posY2 + h2) {
      return "right";
    } else if (posX1 + w1 >= posX2 && 
      posX1 + w1 <= posX2 + 7 && 
      posY1 + h1 >= posY2 && 
      posY1 < posY2 + h2) {
      return "left";
    } else {
      return null;
    }
  }
}
