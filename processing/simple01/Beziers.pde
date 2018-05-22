//public class Beziers extends Scene {

//  ArrayList<Curve> curves = new ArrayList<Curve>();
//  public float end = 600;
//  public float controlVariation = 200;
//  public float acceleration = 0.01;
//  ArrayList<Curve> deads = new ArrayList<Curve>();

//  String getName() {
//    return "beziers";
//  }

//  void init(String lastScene) {
//    cam.reset(0);
//  }

//  void hit(HitData data) {

//    float a = data.oscA;
//    float b = data.oscB;
//    float c = data.oscC;
//    float d = data.oscD;
//    float e = data.oscE;
//    float red = data.oscRed;
//    float green = data.oscGreen;
//    float blue = data.oscBlue;
//    float fade = data.oscFade;

//    a = random(0, 1);
//    b = random(0, 1);
//    c = random(0, 1);
//    d = random(0, 1);
//    e = 1; //random(0,1);
//    fade = random(0, 1);
    
//    red = random(0,1);
//    blue = random(0,1);
//    green = random(0,1);

//    float yVary1 = map(a, 0, 1, -controlVariation, controlVariation); //random(-controlVariation, controlVariation);
//    float yVary2 = map(b, 0, 1, -controlVariation, controlVariation); //random(-controlVariation, controlVariation);
//    float controlPos1 = map(c, 0, 1, -end, 0); // random(-end, 0);
//    float controlPos2 = map(d, 0, 1, 0, end); // random(0, end);

//    curves.add(makeCurve(true, yVary1, yVary2, controlPos1, controlPos2, fade, e, red, green, blue));
//    curves.add(makeCurve(false, yVary1, yVary2, controlPos1, controlPos2, fade, e, red, green, blue));
//  }

//  void doRotation() {
//    //cam.rotateY(0.001);
//    //cam.rotateX(-0.0001);
//    //cam.rotateZ(0.0002);
//  }

//  void draw() {
//    postDraw2d();
//    doRotation();
//    Curve curve;
//    int length = curves.size();
//    for (int i = 0; i < length; i++) {
//      curve = curves.get(i);
//      curve.update();
//      curve.draw();
//      if (curve.dead) {
//        deads.add(curve);
//      }
//    }

//    length = deads.size();
//    for (int i = 0; i < length; i++) {
//      curves.remove(deads.get(i));
//    }

//    deads.clear();
//  }

//  Curve makeCurve(boolean up, float yVary1, float yVary2, float controlPos1, float controlPos2, float fadeRate, float velRand, float red, float green, float blue) {
//    Curve curve = new Curve();
//    curve.fadeRate = fadeRate;
//    curve.anchor1 = new PVector(-end, 0, 0);
//    curve.anchor2 = new PVector(end, 0, 0);
//    curve.control1 = new PVector(controlPos1, yVary1, 0);
//    curve.control2 = new PVector(controlPos2, yVary2, 0);
//    curve.anchor1Vel = new PVector(0, 0, 0);
//    curve.anchor2Vel = new PVector(0, 0, 0);
//    curve.control1Vel = new PVector(0, 0, 0);
//    curve.control2Vel = new PVector(0, 0, 0);
//    curve.anchor1Accel = new PVector(0, up ? -acceleration : acceleration, 0);
//    curve.anchor2Accel = new PVector(0, up ? -acceleration : acceleration, 0);
//    curve.control1Accel = new PVector(randomVel(velRand), up ? -acceleration : acceleration + randomVel(velRand), 0);
//    curve.control2Accel = new PVector(randomVel(velRand), up ? -acceleration : acceleration + randomVel(velRand), 0);
//    curve.curveColor = color(red*255, green*255, blue*255);
//    return curve;
//  }

//  float randomVel(float randomness) {
//    return random(-acceleration*15, acceleration*15) * randomness;
//  }
//}

//public class Curve {
//  public PVector anchor1;
//  public PVector anchor2;
//  public PVector control1;
//  public PVector control2;
//  public PVector anchor1Vel;
//  public PVector anchor2Vel;
//  public PVector control1Vel;
//  public PVector control2Vel;
//  public PVector anchor1Accel;
//  public PVector anchor2Accel;
//  public PVector control1Accel;
//  public PVector control2Accel;
//  public color curveColor = color(0, 0, 255);
//  public float opacity = 255;
//  public float fadeRate;
//  public boolean up;
//  public boolean dead;

//  public void draw() {
//    strokeWeight(2);
//    noFill();
//    stroke(curveColor, opacity);
//    bezierDetail(30);
//    bezier(anchor1.x, anchor1.y, anchor1.z, control1.x, control1.y, control1.z, control2.x, control2.y, control2.z, anchor2.x, anchor2.y, anchor2.z);    
//  }

//  public void update() {
//    if (dead) return;

//    anchor1Vel.x += anchor1Accel.x;
//    anchor1Vel.y += anchor1Accel.y;
//    anchor1Vel.z += anchor1Accel.z;

//    anchor1.x += anchor1Vel.x;
//    anchor1.y += anchor1Vel.y;
//    anchor1.z += anchor1Vel.z;

//    anchor2Vel.x += anchor2Accel.x;
//    anchor2Vel.y += anchor2Accel.y;
//    anchor2Vel.z += anchor2Accel.z;

//    anchor2.x += anchor2Vel.x;
//    anchor2.y += anchor2Vel.y;
//    anchor2.z += anchor2Vel.z;

//    control1Vel.x += control1Accel.x;
//    control1Vel.y += control1Accel.y;
//    control1Vel.z += control1Accel.z;

//    control1.x += control1Vel.x;
//    control1.y += control1Vel.y;
//    control1.z += control1Vel.z;

//    control2Vel.x += control2Accel.x;
//    control2Vel.y += control2Accel.y;
//    control2Vel.z += control2Accel.z;    

//    control2.x += control2Vel.x;
//    control2.y += control2Vel.y;
//    control2.z += control2Vel.z;

//    opacity -= (1-fadeRate)*2.5;
//    dead = opacity <= 0.3;
//  }
//}