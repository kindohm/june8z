public class Maze extends Scene {

  int rows = 50;
  int cols = 50;
  int maxRows = 75;
  int maxCols = 75;
  int minRows = 1;
  int minCols = 1;
  float cellHeight, cellWidth;
  boolean[][] cells;
  boolean[][] mahCells;
  float opacity = 255;
  float fadeAmount;
  boolean high;
  float rotAmount = 0;
  float rotation = 0;
  boolean resetCam;

  Maze() {
    cellHeight = height / (rows * 0.8);
    cellWidth = width / (cols * 0.8);

    reconfigure(0);
  }

  String getName() {
    return "maze";
  }

  void init(String lastScene) {
    resetCam = true;
  }

  void reconfigure(float mod) {
    //int count = 0;
    cells = new boolean[cols][rows];
    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        //count++;
        cells[c][r] = random(0, 1) < mod;
      }
    }
  }

  void hit(HitData data) {

    float hitVal = data.oscHit;
    float a = data.oscA;
    float b = data.oscB;
    float c = data.oscC;
    float d = data.oscD;
    float fade = data.oscFade;

    high = hitVal > 0.5;
    //c = random(0, 1);
    cols = int(map(a, 0, 1, minCols, maxCols));
    rows = int(map(b, 0, 1, minRows, maxRows));
    cellHeight = height / (rows * 0.9);
    cellWidth = width / (cols * 0.9);

    //fade = random(0, 1);
    //d = random(0, 1);
    reconfigure(c);
    opacity = 255;
    fadeAmount = fade;
    rotAmount =0;// map(d, 0, 1, -0.05, 0.05);
  }


  void draw2d() {
    //preDraw2d();

    if (resetCam) {
      resetCam = false;
      camera();
    }

    if (high) {
      fill(255, 0, 0, opacity);
    } else {
      fill(200, 200, 255, opacity);
    }
    strokeWeight(0);

    mahCells = cells.clone();

    rotation += rotAmount;

    for (int c = 0; c < mahCells.length; c++) {
      for (int r = 0; r < mahCells[c].length; r++) {

        boolean val = mahCells[c][r];
        if (val) {
          translate(c*cellWidth, r * cellHeight);
          rotate(rotation);
          drawThing();
          rotate(-rotation);
          translate(-c*cellWidth, -r * cellHeight);
        }
      }
    }

    //postDraw2d();

    opacity -= (1 - fadeAmount) * 40;
  }

  void drawThing() {
    rect(-cellWidth/2, -cellHeight/2, cellWidth, cellHeight);
  }
}

public class MazeB extends Maze {

  MazeB() {
    cellHeight = height / (rows * 0.8);
    cellWidth = width / (cols * 0.8);
    reconfigure(0);
  }


  String getName() {
    return "mazeB";
  }

  void hit(float hitVal, float a, float b, float c, float d, float fade) {
    high = hitVal > 0.5;
    c = 1; //random(0, 1);
    cols = int(map(a, 0, 1, minCols, maxCols));
    rows = int(map(b, 0, 1, minRows, maxRows));
    cellHeight = height / (rows * 0.9);
    cellWidth = width / (cols * 0.9);

    fade = random(0, 1);
    d = 0.5; //random(0, 1);
    reconfigure(c);
    opacity = 255;
    fadeAmount = fade;
    rotAmount = 0;// map(d, 0, 1, -0.05, 0.05);
  }

  void drawThing() {
    textSize(cellHeight*0.75);

    if (high) {
      text("111", 0, 0, cellWidth, cellHeight);
    } else {
      text("000", 0, 0, cellWidth, cellHeight);
    }
  }
}