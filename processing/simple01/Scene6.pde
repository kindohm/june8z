public class Scene6b extends Scene6 {
  public Scene6b() {
    red1 = 22; 
    green1 = 122; 
    blue1 = 82; 
    red2 = 110; 
    green2 = 85; 
    blue2 = 145;
  }

  String getName() {
    return "scene6b";
  }
}

public class Scene6 extends Scene {

  int colCount = 120;
  int maxRowCount = 40; 
  int currentRow = 0;
  float minHeight = 5;
  float maxHeight = 40;
  float cellWidth = 1;
  float rectWidth;
  boolean reset;
  float[][] cells = new float[maxRowCount][colCount];
  boolean[][] hits = new boolean[maxRowCount][colCount];
  float[][] fades = new float[maxRowCount][colCount];
  float[][] currentOpacities = new float[maxRowCount][colCount];
  float screenHeight;

  int red1 = 22, green1 = 82, blue1 = 122, red2 = 145, green2 = 110, blue2 = 84;

  Scene6() {
    rectWidth = width/colCount;
    screenHeight = height;
  }

  String getName() {
    return "scene6";
  }

  void init(String lastScene) {
  }

  void hit(HitData data) {

    float hitVal = data.oscHit;
    float fade = data.oscFade;
    
    for (int col = 0; col < colCount; col++) {
      cells[currentRow][col] = random(minHeight, maxHeight);
      hits[currentRow][col] = hitVal > 0.5;
      fades[currentRow][col] = fade;
      currentOpacities[currentRow][col] = 255;
    }

    currentRow++;

    if (reset || currentRow >= maxRowCount) {
      cells = new float[maxRowCount][colCount];
      hits = new boolean[maxRowCount][colCount];
      fades = new float[maxRowCount][colCount];
      currentOpacities = new float[maxRowCount][colCount];
      currentRow = 0;
      reset = false;
    }
  }


  void draw() {
    preDraw2d();

    stroke(0);
    strokeWeight(5);

    for (int row = 0; row < maxRowCount; row++) {
      for (int col = 0; col < colCount; col++) {

        if (cells[row][col] == 0) {
          break;
        }

        // calc y position
        float yPos = 0;
        for (int x = 0; x < row; x++) {
          yPos += cells[x][col];
        }

        if (yPos > screenHeight + maxHeight) {
          reset = true;
        }

        currentOpacities[row][col] -= fades[row][col]*4;

        if (hits[row][col]) {
          fill(red2, green2, blue2, currentOpacities[row][col]);
        } else {
          fill(red1, green1, blue1, currentOpacities[row][col]);
        }

        rect(col*rectWidth, yPos, rectWidth, cells[row][col]);
      }
    }

    postDraw2d();
  }
}