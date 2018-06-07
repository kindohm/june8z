
public class Logs extends Scene {

  boolean resetCam;
  int minCols = 3;
  int maxCols = 30;
  int minRows = 3;
  int maxRows = 15;
  int rows = 3;
  int row = 0;
  int cols = 8;
  int col = 0;
  float depth = 2000;
  Log[][] logs;
  float bigSizeX = 1600;
  float bigSizeZ = 800;

  String getName() {
    return "logs";
  }

  void reset() {
    row = 0;
    col = 0;
    logs = new Log[cols][rows];
  }

  void init(String lastScene) {
    resetCam = true;
    reset();
  }

  void hit(HitData data) {

    float hitVal = data.oscHit;
    float a = data.oscA;
    float b = data.oscB;
    float c = data.oscC;
    float d = data.oscD;
    //float fade = data.oscFade;

    int newCols = int(map(a, 0, 1, minCols, maxCols));
    int newRows = int(map(b, 0, 1, minRows, maxRows));

    if (rows != newRows|| cols != newCols) {
      rows= newRows;
      cols = newCols;
      reset();
    }

    if (row >= rows) {
      row = 0;
      col++;
    }

    if (col >= cols) {
      reset();
    }

    //data.oscGreen = random(0, 1);
    //data.oscRed = random(0, 1);
    //data.oscBlue = random(0, 1);

    Log newLog = new Log();
    if (hitVal > 0.5) {
      newLog.red = map(data.oscGreen, 0, 1, 0, 255);
      newLog.green = map(data.oscRed, 0, 1, 0, 255);
      newLog.blue = map(data.oscBlue, 0, 1, 0, 255);
    } else {
      newLog.red = map(data.oscRed, 0, 1, 0, 255);
      newLog.green = map(data.oscGreen, 0, 1, 0, 255);
      newLog.blue = map(data.oscBlue, 0, 1, 0, 255);
    }

    //newLog.fadeRate = fade;
    newLog.pos = new PVector(col, 0, row);
    newLog.vel = new PVector(0, c*map(random(0, 1), 0, 1, 0, 0.5), 0);
    newLog.sizeX = bigSizeX/cols;
    newLog.sizeZ = bigSizeZ/rows;
    newLog.rotateYRate = map(d,0,1,0,0.001);

    logs[col][row] = newLog;

    row++;
  }

  void doRotation() {
    cam.rotateY(-0.00005);
    cam.rotateX(-0.00001);
  }

  void draw3d() {
    if (resetCam) {
      cam.reset(0);
      resetCam = false;
    }

    doRotation();

    ambientLight(155, 155, 155);
    directionalLight(155, 155, 155, -0.1,0.3,-0.7);

    Log log;

    if (logs == null) {
      return;
    }

    float halfCols = bigSizeX/2;
    float halfRows = bigSizeZ/2;
    //stroke(255);
    //strokeWeight(5);
    noStroke();

    rotateX(-1);
    rotateY(0.5);
    rotateZ(0.6);
    for (int c = 0; c < logs.length; c++) {
      for (int r = 0; r < logs[c].length; r++) {
        log = logs[c][r];
        if (log == null) continue;

        fill(color(log.red, log.green, log.blue));
        translate(log.pos.x * log.sizeX - halfCols/3, depth/2 - log.pos.y, log.pos.z* log.sizeZ - halfRows);
        rotateY(log.rotateY);
        box(log.sizeX, depth, log.sizeZ);
        rotateY(-log.rotateY);
        translate(-log.pos.x * log.sizeX + halfCols/3, -depth/2 + log.pos.y, -log.pos.z * log.sizeZ + halfRows);

        log.pos.y += log.vel.y;
        log.rotateY += log.rotateYRate;
        //float rate = (1-log.fadeRate*0.01);        
        //log.red *= rate;
        //log.green *= rate;
        //log.blue *= rate;
      }
    }
    rotateZ(-0.6);
    rotateY(-0.5);
    rotateX(1);
  }
}

public class Log {
  public PVector pos;
  public PVector vel;
  public float sizeX;
  public float sizeZ;
  //public float opacity = 255;
  //public float fadeRate = 0;
  public float rotateY;
  public float rotateYRate;
  public float red;
  public float green;
  public float blue;
}