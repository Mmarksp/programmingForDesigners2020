class HighScore {
  PImage background_img;
  int line = 50;
  int[] scores = new int[10];
  String[] players = new String[10];

  void display() {
    imageMode(CENTER);
    float aspect = float(background_img.height)/float(height);
    image(background_img, 400, 400, float(background_img.width)/aspect, height);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    text("High Scores", 400, 200);
    textSize(32);
    text("Back to menu", 400, 600+line);

    this.scoreSort();
    for (int i=0; i<10; i++) {
      textSize(20);
      text(this.players[i], 360, float(260+i*28));
      text(str(this.scores[i]), 440, float(260+i*28));
    }
    this.write();
  }

  void read() {
    int i=0;
    for (TableRow row : table.rows()) {
      if (row.getInt("score") == 0 && row.getString("name") == null) {
        this.scores[i] = 0;
        this.players[i] = "AAA";
      } else {
        this.scores[i] = row.getInt("score");
        this.players[i] = row.getString("name");
      }
      i++;
    }
    //println(scores);
  }

  void write() {
    writer = createWriter("hsTable.csv");
    println("writing");
    writer.println("score,name");
    for (int i=0; i<10; i++) {
      //println(scores[i]+","+players[i]);
      writer.println(scores[i]+","+players[i]);
    }
    writer.flush();
    writer.close();
  }

  boolean checkScore() {
    for (int i=0; i<10; i++) {
      if (score > scores[i]) {
        return true;
      }
    }
    return false;
  }

  void scoreSort() {
    boolean isSorted = false;
    while (!isSorted) {
      isSorted = true;
      for (int i=1; i<scores.length; i++) {
        if (scores[i-1]<scores[i]) {
          isSorted = false;

          int temp = scores[i];
          scores[i] = scores[i-1];
          scores[i-1] = temp;
          String tempStr = players[i];
          players[i] = players[i-1];
          players[i-1] = tempStr;
        }
      }
    }
    //println("sorted");
    //println(scores);
  }


  void select() {
    if (mouseX > 280 && mouseX < 520 && mouseY > 500 + 2*line && mouseY < 500 + 3*line) {
      gameState = "menu";
    }
  }

  void menu() {
    fill(255, 255, 255, 60);
    noStroke();
    if (mouseX > 280 && mouseX < 520 && mouseY > 500 + 2*line+10 && mouseY < 500 + 3*line) {
      rect(280, 610, 520-280, 40);
    }
  }
}
