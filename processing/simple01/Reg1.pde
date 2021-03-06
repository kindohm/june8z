class Reg1 extends Scene {

  int rows = 10;
  int cols = 40;
  int minCols = 2;
  int maxCols = 10;
  int minRows = 2;
  int maxRows = 10;
  int currentRow = 0, currentCol = 0, rectWidth, rectHeight;
  float stroke, fadeRate;
  int red1 = 255, green1 = 0, blue1 = 255, red2 = 0, green2 = 255, blue2 = 255;
  Scene1Cell[][] table;
  boolean resetCam;

  Reg1() {
    name = "reg1";
    buildTable();
  }

  void init(String oldSceneName) {
    if (oldSceneName != "reg1") {
      //cam.reset(0);
      //buildTable();
    }
    resetCam = true;
  }

  void buildTable() {
    currentRow = 0;
    currentCol = 0;
    rectWidth = width/cols;
    rectHeight = height/rows;
    table = new Scene1Cell[cols][rows];
  }

  void hit(HitData data) {

    float hitVal = data.oscHit;
    float a = data.oscA;
    float b = data.oscB;
    float fade = data.oscFade;    
    
    stroke = 5;
    fadeRate = map(fade, 0, 1, 0, 10);

    int newCols = int(map(a, 1, 0, minCols, maxCols));
    int newRows = int(map(b, 1, 0, minRows, maxRows));

    if (newCols != cols || newRows != rows) {
      rows = newRows;
      cols = newCols;
      buildTable();
    }

    if (currentRow == 0 && currentCol == 0) {
      buildTable();
    }

    table[currentCol][currentRow] = new Scene1Cell(hitVal, stroke, fadeRate);

    currentRow++;

    if (currentRow >= rows) {
      currentRow = 0;
      currentCol++;
    }

    if (currentCol >= cols) {
      currentCol = 0;
    }
  }


  void draw2d() {

    //preDraw2d();

    if (resetCam){
      camera();
      resetCam = false;
    }

    float hitVal, strokeVal, opacity;
    Scene1Cell cell;

    if (table == null) {
      return;
    }

    stroke(0);

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {

        // safety!
        if (col >= cols || row >= rows || table[col] == null) return;

        cell = table[col][row];
        if (cell != null) {
          hitVal = cell.getHitVal();
          strokeVal = cell.getStroke();
          opacity = cell.getOpacity();
        } else {
          hitVal = 0;
          strokeVal = 5;
          opacity = 0;
        }

        strokeWeight(strokeVal);
        if (hitVal > 0.5) {
          fill(red2, green2, blue2, opacity);
        } else {
          fill(red1, green1, blue1, opacity);
        } 

        rect(col * rectWidth, row * rectHeight, rectWidth, rectHeight);
        if (cell != null) cell.fade();
      }
    }

    //postDraw2d();
  }
}

class Scene1Cell {
  float stroke;
  float hitVal;
  float fadeRate;
  float opacity;

  Scene1Cell(float newHitVal, float newStroke, float newFadeRate) {
    stroke = newStroke;
    hitVal = newHitVal;
    fadeRate = newFadeRate;
    opacity = 255;
  }

  float getStroke() {
    return stroke;
  }

  float getHitVal() {
    return hitVal;
  }

  float getFadeRate() {
    return fadeRate;
  }

  void fade() {
    opacity -= fadeRate;
    if (opacity <= 0) {
      opacity = 0;
    }
  }

  float getOpacity() {
    return opacity;
  }
}