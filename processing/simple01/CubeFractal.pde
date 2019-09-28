public static class Defaults {
  public static float baseScale = 50;
}

public class CubeFractal extends Scene {

  Node[] nodes;
  int count;  
  int max = 25;
  float halfPi = PI/2;
  float negHalfPi = -PI/2;
  float maxVel = 2.5;
  float maxRotVel = PI*0.01;
  boolean resetCam;

  String getName() {
    return "cubeFractal";
  }

  void reset() {
    nodes = new Node[max];
    count = 0;
  }

  void init(String lastScene) {
    resetCam = true;
    reset();
  }

  int randomSignum() {
    return (int) random(2) * 2 - 1;
  }

  void hit(HitData data) {
    float hitVal = data.oscHit;
    float a = data.oscA;
    float b = data.oscB;
    float fade = data.oscFade;
    float red = data.oscRed;
    float green = data.oscGreen;
    float blue = data.oscBlue;

    if (nodes[nodes.length -1] != null) {
      reset();
    }

    //fade = random(0, 0.5);

    Node lastNode = null;

    if (count > 0) {
      lastNode = nodes[count-1];
    }

    Node newNode = new Node();
    newNode.high = hitVal > 0.5;
    newNode.fadeRate = fade;
    newNode.velocity = new PVector(random(-maxVel, maxVel) * a, random(-maxVel, maxVel) * a, random(-maxVel, maxVel) * a);
    newNode.rotVelocity = new PVector(random(-maxRotVel, maxRotVel) * b, random(-maxRotVel, maxRotVel) * b, random(-maxRotVel, maxRotVel) * b);

    if (newNode.high) {
      newNode.nodeColor = color(map(blue,0,1,0,255), map(green, 0, 1, 0, 255), map(red,0,1,0,255));
    } else {
      newNode.nodeColor = color(map(red,0,1,0,255), map(green,0,1,0,255), map(blue,0,1,0,255));
    }

    if (lastNode != null) {
      newNode.rotateX = random(-1.5, 1.5);
      newNode.rotateY = random(-1.5, 1.5);
      newNode.rotateZ = random(-1.5, 1.5);
      newNode.x = (lastNode.x + lastNode.scale/2);
      newNode.y = (lastNode.y + lastNode.scale/2* randomSignum()) ;
      newNode.z = (lastNode.z + lastNode.scale/2* randomSignum()) ;
      newNode.scale = random(Defaults.baseScale*0.25, Defaults.baseScale);
      newNode.halfScale = newNode.scale/2;
    }

    nodes[count] = newNode;
    count++;
  }

  void doRotation() {
    cam.rotateY(-0.005);
    cam.rotateX(-0.0001);
  }

  void draw3d() {

    if (resetCam) {
      cam.reset(0);
      cam.lookAt(0, -50, 0);
      resetCam = false;
    }

    //postDraw2d();
    doRotation();

    sphereDetail(12);
    directionalLight(255, 255, 255, 0.15, -0.5, -0.7);
    directionalLight(255, 255, 255, -0.3, 0.25, 0.8);
    ambientLight(55, 55, 55);
    strokeWeight(0);
    //stroke(255, 255, 255);

    if (nodes[0] == null) return;

    computeNode(nodes[0]);

    for (int i = 1; i < count; i++) {
      Node node = nodes[i];
      computeNode(node);
    }
  }

  void computeNode(Node node) {
    if (node.opacity > 0.25) {
      stroke(255, 255, 255, node.opacity);
      fill(node.nodeColor, node.opacity);


      drawObject(node);

      rotateY(halfPi);
      drawObject(node);

      rotateY(halfPi);
      drawObject(node);

      rotateY(halfPi);
      drawObject(node);

      rotateY(negHalfPi);
      rotateY(negHalfPi);
      rotateY(negHalfPi);

      node.opacity *= (1 - node.fadeRate * 0.04);
      node.x += node.velocity.x;
      node.y += node.velocity.y;
      node.z += node.velocity.z;
      node.rotateX += node.rotVelocity.x;
      node.rotateY += node.rotVelocity.y;
      node.rotateZ += node.rotVelocity.z;
    }
  }

  void drawObject(Node node) {

    translate(node.x, node.y, node.z);
    rotateX(node.rotateX);
    rotateY(node.rotateY );
    rotateZ(node.rotateZ );
    if (node.high) {
      sphere(node.halfScale);
    } else {
      box(node.scale, node.scale, node.scale);
    }
    rotateZ(-node.rotateZ );
    rotateY(-node.rotateY );
    rotateX(-node.rotateX );
    translate(-node.x, -node.y, -node.z );
  }
}

public class Node {

  public float x = 0;
  public float y = 0;
  public float z = 0;
  public float scale = Defaults.baseScale;
  public float halfScale = scale/2;
  public float rotateX;
  public float rotateY;
  public float rotateZ;
  public color nodeColor;
  public float fadeRate = 0;
  public float opacity = 255;
  public boolean high;
  public PVector velocity;
  public PVector rotVelocity;
}