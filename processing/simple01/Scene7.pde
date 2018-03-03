public class Scene7 extends Scene {

  boolean reset;
  float size = 100;
  float delta = size*1.5;
  float rotation = 0;
  boolean high;

  String getName() {
    return "scene7";
  }

  void init(String lastScene) {
    cam.reset(0);
    cam.lookAt(0,0,0);
    cam.setDistance(500);
    //cam.rotateY(-0.7);
    cam.rotateX(0.6);
  }

  void hit(float hitVal, float a, float b, float c, float d, float fade) {
    reset = true;
    rotation = 0;
    //cam.reset(0);
    cam.lookAt(0,0,0);
    cam.setDistance(500);
    //cam.rotateY(-0.7);
    //cam.rotateX(0.6);
    high = hitVal > 0.5;
  }

  void draw() {
    postDraw2d();

    stroke(255);
    noFill();
    sphereDetail(15);

    rotateY(rotation);

    // draw four things
    translate(delta, 0, 0);
    drawIt();
    translate(-delta, 0, 0);

    translate(0, 0, delta);
    drawIt();
    translate(0, 0, -delta);

    translate(-delta, 0, 0);
    drawIt();
    translate(delta, 0, 0);

    translate(0, 0, -delta);
    drawIt();
    translate(0, 0, delta);

    rotateY(-rotation);


    rotation += 0.025;
  }

  void drawIt() {
    if (!high) {
      box(size);
    } else {
      sphere(size);
    }
  }
}