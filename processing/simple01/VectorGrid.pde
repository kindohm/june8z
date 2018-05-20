class VectorGrid extends Scene {

  int row, col, slot;
  int rows = 1;
  int cols = 1;
  int slots = 1;
  int minCols = 1;
  int maxCols = 20;
  int minRows = 1;
  int maxRows = 20;
  int minSlots = 1;
  int maxSlots = 20;
  float spaceSize = 350;
  float currentHitVal = 0;
  float vary = 0;
  float shapeSizeX = 1;
  float shapeSizeY = 1;
  float shapeSizeZ = 1;
  boolean reset = false;
  float fadeAmount = 0;
  float currentFade = 0;
  float rotationAmount = 0;
  float currentRotation = 0;
  int red1 = 0, green1 = 255, blue1 = 0, red2 = 0, green2 = 255, blue2 = 255;

  int newCols, newRows, newSlots;

  VectorGrid() {
    name = "vectorGrid";
  }

  void init(String oldSceneName) {
    cam.reset(0);
  }

  void hit(HitData data) {

    float hitVal = data.oscHit;
    float a = data.oscA;
    float b = data.oscB;
    float c = data.oscC;
    float d = data.oscD;
    float fade = data.oscFade;

    reset = true;

    newCols = int(map(a, 0, 1, minCols, maxCols));
    newRows = int(map(b, 0, 1, minRows, maxRows));
    newSlots = int(map(c, 0, 1, minSlots, maxSlots));
    fadeAmount = map(fade, 0, 1, 0, 1);
    rotationAmount = map(d, 0, 1, 0, 0.05);

    currentHitVal = hitVal;
    currentFade = 0;
    currentRotation = 0;
    cam.reset(0);
  }

  void doRotation() {
    cam.rotateY(0.01);
    cam.rotateX(0.002);
  }

  void draw() {    
    postDraw2d();

    if (reset) {
      reset = false;
    }

    rows = newRows;
    cols = newCols;
    slots = newSlots;

    shapeSizeX = spaceSize / rows; 
    shapeSizeY = spaceSize / cols;
    shapeSizeZ = spaceSize / slots;

    noFill();
    strokeWeight(2);

    translate(-spaceSize/2, -spaceSize/2, -spaceSize/2);

    float x = shapeSizeX * factor + currentFade;
    float y = shapeSizeY * factor + currentFade;
    float z = shapeSizeZ * factor + currentFade;

    for (row = 0; row < rows; row++) {
      for (col = 0; col < cols; col++) {
        for (slot = 0; slot < slots; slot++) {

          translate(row * shapeSizeX, col * shapeSizeY, slot * shapeSizeZ);

          translate(shapeSizeX/2, shapeSizeY/2, shapeSizeZ/2);
          rotateX(currentRotation);
          if (currentHitVal < 1) {
            stroke(red1, green1, blue1);
            drawShape2(x/2, y/2, z/2);
          } else {
            stroke(red2, green2, blue2);
            drawShape1(x, y, z);
          }
          rotateX(-currentRotation);
          translate(-shapeSizeX/2, -shapeSizeY/2, -shapeSizeZ/2);

          translate(-row * shapeSizeX, -col * shapeSizeY, -slot * shapeSizeZ);
        }
      }
    }

    translate(spaceSize/2, spaceSize/2, spaceSize/2);

    doRotation();

    currentFade -= fadeAmount;
    currentRotation += rotationAmount;
  }

  float factor = 0.6;
  void drawShape1(float sizeX, float sizeY, float sizeZ) {  
    box(sizeX, sizeY, 0);
  }

  void drawShape2(float sizeX, float sizeY, float sizeZ) {
    float x = sizeX;
    float y = sizeY;

    beginShape();

    vertex(-x, y, 0);
    vertex( x, y, 0);
    vertex(   0, -y, 0);

    vertex( x, y, 0);
    vertex( x, y, 0);
    vertex(   0, -y, 0);

    vertex( x, y, 0);
    vertex(-x, y, 0);
    vertex(   0, -y, 0);

    vertex(-x, y, 0);
    vertex(-x, y, 0);
    vertex(0, -y, 0);    

    endShape();
  }
}