public class Nudges extends Scene {

  int rows = 15;
  int cols = 15;
  float floor = 230;
  ArrayList<Nudge> units = new ArrayList<Nudge>();
  ArrayList<Nudge> deads = new ArrayList<Nudge>();
  float extents = 200;
  boolean resetCam;

  Nudges() {
  }

  String getName() {
    return "nudges";
  }

  void init(String lastScene) {
    resetCam = true;
  }

  void hit(HitData data) {
    
    float hitVal = data.oscHit;
    
    // random position scale and initial rotation amount
    float a = data.oscA;
    
    // rotation scale
    float b = data.oscB; //0.1;
    
    // growth 
    float c = data.oscC;

    float fade = data.oscFade;

    Nudge unit = new Nudge();
    unit.pos = new PVector(random(-extents, extents)*a, floor, random(-extents, extents)*a);
    unit.vel = new PVector(0, 0, 0);
    unit.accel = new PVector(0, -0.01, 0);  
    unit.fadeRate= fade;
    unit.initRotateY = random(-PI, PI)*a*0.5;
    unit.rotation = b * 0.01;
    unit.growth = c * 1.5;

    unit.unitColor = color(data.oscRed * 255, data.oscGreen*255, data.oscBlue*255);

    if (hitVal > 0.5) {
      unit.high = true;
      //unit.unitColor = color(random(0, 1)*255, random(0, 1)*255, random(0, 1)*25);
    } else {
      //unit.unitColor = color(random(0, 1)*25, random(0, 1)*255, random(0, 1)*255);
    }
    units.add(unit);


    
  }

  void doRotation() {
    //cam.rotateY(0.003);
  }

  void draw3d() {
    if (resetCam){
      cam.reset(0);
      resetCam = false;
    }
    
    //postDraw2d();
    doRotation();

    directionalLight(255, 255, 255, 0.15, -0.5, -0.7);
    directionalLight(255, 255, 255, -0.3, 0.25, 0.8);
    ambientLight(55, 55, 55);
    sphereDetail(15);
    Nudge unit;
    //mahUnits = (ArrayList<Nudge>) units.clone();


    int size = units.size();

    for (int i = 0; i < size; i++) {
      unit = units.get(i);
      if (unit == null) break;
      unit.update();
      if (!unit.dead) {
        unit.draw();
      } else {
        deads.add(unit);
      }
    }      

    size = deads.size();
    for (int i = 0; i < size; i++) {
      units.remove(deads.get(i));
    }

    deads.clear();
  }
}

public class Nudge {

  public PVector pos;
  public PVector vel;
  public PVector accel;
  public color unitColor;
  public float fadeRate = 0.5;
  public float opacity = 255;
  public float shapeWidth = width/3; // 200;
  public float shapeDepth = 5;
  public float shapeHeight = 5;
  public float initRotateY = 0;
  public float rotateY = 0;
  public float rotateZ = 0;
  public float rotateX = 0;
  public float rotation = 0;
  public float growth = 0;
  public boolean dead;
  public boolean high;

  public void draw() {
    if (vel == null || accel == null || pos == null) return;

    fill(unitColor, opacity);
    strokeWeight(0);
    translate(pos.x, pos.y, pos.z);
    rotateY(initRotateY + rotateY);
    rotateX(rotateX);
    rotateZ(rotateZ);
    box(shapeWidth, shapeHeight, shapeDepth);
    rotateZ(-rotateZ);
    rotateX(-rotateX);
    rotateY(-initRotateY - rotateY);
    translate(-pos.x, -pos.y, -pos.z);
  }

  public void update() {
    if (vel == null || accel == null || pos == null) return;

    rotateY += rotation;
    rotateX += rotation;
    rotateZ += rotation;

    shapeDepth += growth;
    shapeWidth += growth;

    vel.x += accel.x;
    vel.y += accel.y;
    vel.z += accel.z;
    pos.x += vel.x;
    pos.y += vel.y;
    pos.z += vel.z;
    if (opacity > 0.1) {
      opacity -= (1-fadeRate)*2.5;
    }

    if (opacity <= 0.05) {
      dead = true;
    }
  }
}