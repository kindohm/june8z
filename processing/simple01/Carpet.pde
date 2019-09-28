//public class Carpet extends Scene {

//  boolean rotating = false;
//  float rotInc = PI*0.035;
//  float currentRot = 0;
//  int cellCount = 0;
//  int maxCells = 60;
//  int rows = 60; // MUST BE EVEN
//  float size = 60;  
//  boolean high;
//  boolean[] cells = new boolean[maxCells];
//  float red1 = 0, green1 = 255, blue1 = 0, red2 = 255, green2 = 0, blue2 = 255;

//  String getName() {
//    return "carpet";
//  }

//  void init(String lastScene) {
//    cam.reset(0);
//    cam.rotateY(-0.7);
//    cam.rotateX(0.6);
//  }

//  void hit(HitData data) {

//    float hitVal = data.oscHit;

//    rotating = true;
//    if (cellCount < maxCells) {
//      cellCount++;
//    }
//    currentRot = 0;
//    high = hitVal > 0.5;
//  }


//  void draw() {
//    postDraw2d();

//    if (!high) {
//      stroke(red1, green1, blue1);
//    } else {
//      stroke(red2, green2, blue2);
//    }

//    noFill();

//    for (int row = -rows/2; row < rows/2; row++) {

//      for (int c = 0; c < cellCount; c++) {
//        translate(c*size, size/2, row*size);

//        float amount = map(currentRot, 0, PI/2, 0, size);
//        if (rotating) {
//          translate(amount, 0, 0);
//        } else {
//          translate(size, 0, 0);
//        }

//        box(size, 0, size);

//        if (rotating) {
//          translate(-amount, 0, 0);
//        } else {
//          translate(-size, 0, 0);
//        }

//        translate(-c*size, -size/2, -row*size);
//      }
//    }


//    if (rotating) {
//      currentRot += rotInc;
//      rotateZ(-currentRot);
//    }

//    for (int row = -rows/2; row < rows/2; row++) {
//      translate(0, 0, row*50);
//      box(50);
//      translate(0, 0, -row*50);
//    }

//    if (rotating) {
//      rotateZ(currentRot);
//    }

//    if (currentRot >= PI/2) {
//      rotating = false;
//      currentRot = 0;
//    }
//  }

//  void drawShape(float dim) {
//    box (dim, 0, dim);
//  }
//}

//public class CarpetB extends Carpet {

//  public CarpetB() {
//    red1 = 255; 
//    green1 = 255;
//    blue1 = 0; 
//    red2 = 0; 
//    green2 = 255; 
//    blue2 = 255;
//  }

//  String getName() {
//    return "carpetB";
//  }
//}