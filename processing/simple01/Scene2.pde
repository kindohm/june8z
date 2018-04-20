class Scene2 extends Scene {

  int rows = 5;
  int cols = 5;
  int slots = 5;
  int minCols = 1;
  int maxCols = 10;
  int minRows = 1;
  int maxRows = 10;
  int minSlots = 1;
  int maxSlots = 10;
  int currentRow = 0, currentCol = 0, currentSlot = 0, shapeSize = 85;
  int red1 = 100, green1 = 50, blue1 = 255, red2 = 50, green2 = 255, blue2 = 50;
  boolean reset = false;
  boolean high = false;
  float currentScale = 1;
  float fadeAmount = 0;

  Scene2Cell[][][] table;

  Scene2() {
    name = "scene2";
    buildTable();
  }

  void init(String oldSceneName) {
    if (oldSceneName != "scene2b") {
      cam.reset(0);
    }
  }

  void buildTable() {
    currentRow = 0;
    currentCol = 0;
    currentSlot = 0;
    table = new Scene2Cell[cols][rows][slots];

    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        for (int s = 0; s < slots; s++) {
          table[c][r][s] = new Scene2Cell();
        }
      }
    }
  }

  void hit(HitData data) {

    float hitVal = data.oscHit;
    float a = data.oscA;
    float b = data.oscB;
    float c = data.oscC;
    float d = data.oscD;

    reset = true;

    int newCols = int(map(a, 0, 1, minCols, maxCols));
    int newRows = int(map(b, 0, 1, minRows, maxRows));
    int newSlots = int(map(c, 0, 1, minSlots, maxSlots));

    if (newCols != cols || newRows != rows || newSlots != slots) {
      rows = newRows;
      cols = newCols;
      slots = newSlots;
      buildTable();
    }

    if (currentRow == 0 && currentCol == 0 && currentSlot == 0) {
      buildTable();
    }

    high = hitVal > 0.5;
    fadeAmount = d;
    currentScale = 1;
  }

  void doRotation() {
    cam.rotateY(0.015);
    cam.rotateX(0.002);
  }

  void draw() {    

    if (reset) {
      cam.reset(0);
      reset = false;
    }

    postDraw2d();
    doRotation();
    sphereDetail(13);
    directionalLight(200, 102, 126, 0.15, -0.5, -0.7);
    ambientLight(55, 55, 55);


    if (table == null) {
      return;
    }

    noStroke();

    translate(-cols/2*shapeSize, -rows/2*shapeSize, -slots/2*shapeSize);

    for (int slot = 0; slot < slots; slot++) {
      for (int col = 0; col < cols; col++) {
        for (int row = 0; row < rows; row++) {

          // safety!
          if (col >= cols || row >= rows || slot >= slots) return;

          noStroke();
          translate(col * shapeSize, row * shapeSize, slot * shapeSize);

          if (high) {
            fill(red2, green2, blue2, 255);
            box(shapeSize *0.8 * currentScale);
          } else {
            fill(red1, green1, blue1, 255);
            box(shapeSize * 0.8 * currentScale);
          } 

          translate(-col * shapeSize, -row * shapeSize, -slot * shapeSize);
        }
      }
    }
    translate(cols/2*shapeSize, rows/2*shapeSize, slots/2*shapeSize);
    currentScale -= fadeAmount*0.025;
  }
}

class Scene2Cell {


  Scene2Cell() {
  }
}