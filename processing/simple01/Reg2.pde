class Reg2 extends Scene {

  int rows = 10;
  int cols = 40;
  int minCols = 1;
  int maxCols = 10;
  int minRows = 1;
  int maxRows = 10;
  int currentRow = 0, currentCol = 0, rectWidth, rectHeight;
  Scene9Cell[][] table;
  PImage img1, img2;

  Reg2() {
    name = "reg2";
    buildTable();
    img1 = loadImage("computer.jpg");
    img2 = loadImage("computer2.jpg");
  }

  void init(String oldSceneName) {
    if (oldSceneName != "reg2") {
      //cam.reset(0);
      //buildTable();
    }
  }

  void buildTable() {
    currentRow = 0;
    currentCol = 0;
    rectWidth = width/cols;
    rectHeight = height/rows;
    table = new Scene9Cell[cols][rows];
  }

  void hit(HitData data) {

    float hitVal = data.oscHit;
    float a = data.oscA;
    float b = data.oscB;

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

    table[currentCol][currentRow] = new Scene9Cell(hitVal);

    currentRow++;

    if (currentRow >= rows) {
      currentRow = 0;
      currentCol++;
    }

    if (currentCol >= cols) {
      currentCol = 0;
    }
  }


  void draw() {

    preDraw2d();

    float hitVal;
    Scene9Cell cell;

    if (table == null) {
      return;
    }

    stroke(0);

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {

        // safety!
        if (col >= cols || row >= rows) return;

        cell = table[col][row];
        if (cell != null) {
          hitVal = cell.getHitVal();
        } else {
          hitVal = 0;
        }

        if (cell == null) {
          break;
        }

        image(hitVal > 0.5 ? img2 : img1, col * rectWidth, row * rectHeight, rectWidth, rectHeight);
      }
    }

    postDraw2d();
  }
}

class Scene9Cell {
  float hitVal;

  Scene9Cell(float newHitVal) {
    hitVal = newHitVal;
  }

  float getHitVal() {
    return hitVal;
  }
}

public class Reg2B extends Reg2 {
  Reg2B() {
    name = "reg2B";
    buildTable();
    img1 = loadImage("cat1.jpg");
    img2 = loadImage("cat2.jpg");
  }
}