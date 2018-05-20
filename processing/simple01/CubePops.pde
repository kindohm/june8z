public float cellSize = 50;

public class CubePops extends Scene {

  int rows = 15;
  int cols = 15;
  float floor = -100;
  Unit[][] units;
  Unit[][] mahUnits;

  CubePops() {
    units = new Unit[cols][rows];
  }

  String getName() {
    return "cubePops";
  }

  void init(String lastScene) {
    cam.reset(0);
  }

  void hit(HitData data) {

    float hitVal = data.oscHit;
    float a = data.oscA;
    float b = data.oscB;
    //float c = data.oscC;
    //float d = data.oscD;
    //float e = data.oscE;
    //float red = data.oscRed;
    //float green = data.oscGreen;
    //float blue = data.oscBlue;
    float fade = 1; //data.oscFade;

    rows = int(map(a, 0, 1, 1, 25));
    cols = int(map(b, 0, 1, 1, 25));

    units = new Unit[cols][rows];
    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {

        Unit unit = new Unit();
        unit.pos = new PVector(c * cellSize, 0, r * cellSize);
        unit.vel = new PVector(0, 0, 0);
        unit.accel = new PVector(0, random(-0.2, 0), 0);  
        unit.fadeRate= fade;
        if (hitVal > 0.5) {
          unit.unitColor = color(random(0, 1)*255, random(0, 1)*25, random(0, 1)*255);
        } else {
          unit.unitColor = color(random(0, 1)*25, random(0, 1)*255, random(0, 1)*255);
        }
        units[c][r] = unit;
      }
    }

    cam.reset(0);
  }

  void doRotation() {
    cam.rotateY(0.001);
  }

  void draw() {
    postDraw2d();
    doRotation();

    directionalLight(255, 255, 255, 0.15, -0.5, 0.7);
    directionalLight(255, 255, 255, -0.3, 0.25, 0.8);
    ambientLight(55, 55, 55);


    Unit unit;
    mahUnits = units.clone();

    translate(float(-cols)/2 * cellSize + cellSize/2, -floor, float(-rows)/2 * cellSize + cellSize/2);
    //translate(0,-floor, 0);

    for (int c = 0; c < mahUnits.length; c++) {
      for (int r = 0; r < mahUnits[c].length; r++) {
        unit = mahUnits[c][r];
        if (unit == null) break;
        unit.update();
        unit.draw();
      }
    }

    translate(-(float(-cols)/2 * cellSize + cellSize/2), floor, -(float(-rows)/2 * cellSize + cellSize/2));
  }
}

public class Unit {

  public PVector pos;
  public PVector vel;
  public PVector accel;
  public color unitColor = color(255, 255, 0);
  public float fadeRate = 0.5;
  public float opacity = 255;
  public float size = 37.5; // cellSize *0.75;

  public void draw() {
    if (vel == null || accel == null || pos == null) return;

    fill(unitColor, opacity);
    //noFill();
    //stroke(unitColor, opacity);
    strokeWeight(0);
    translate(pos.x, pos.y, pos.z);
    box(size);
    translate(-pos.x, -pos.y, -pos.z);
  }

  public void update() {
    if (vel == null || accel == null || pos == null) return;

    vel.x += accel.x;
    vel.y += accel.y;
    vel.z += accel.z;
    pos.x += vel.x;
    pos.y += vel.y;
    pos.z += vel.z;
    if (opacity > 0.1) {
      opacity -= (1-fadeRate)*2.5;
    }
  }
}