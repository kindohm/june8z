public static class Defaults7b {
  public static float baseScale = 50;
}

public class Nodes extends Scene {

  Node[] nodes;
  int count;  
  int max = 50;
  float maxHorizDim = 300;
  float maxVertDim = 200;
  float halfPi = PI/2;
  float negHalfPi = -PI/2;
  float maxVel = 2.5;
  float maxRotVel = PI*0.01;

  String getName() {
    return "nodes";
  }

  void reset() {
    nodes = new Node[max];
    count = 0;
  }

  void init(String lastScene) {
    cam.reset(0);
    cam.lookAt(0, -50, 0);
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

    if (nodes[nodes.length -1] != null) {
      reset();
    }

    //fade = random(0, 0.5);

    Node newNode = new Node();
    newNode.high = hitVal > 0.5;
    newNode.fadeRate = fade;
    newNode.velocity = new PVector(random(-maxVel, maxVel) * a, random(-maxVel, maxVel) * a, random(-maxVel, maxVel) * a);
    newNode.rotVelocity = new PVector(random(-maxRotVel, maxRotVel) * b, random(-maxRotVel, maxRotVel) * b, random(-maxRotVel, maxRotVel) * b);

    if (newNode.high) {
      newNode.nodeColor = color(255, random(0, 255), random(0, 255));
    } else {
      newNode.nodeColor = color(random(0, 255), random(0, 255), 255);
    }

    newNode.rotateX = random(-1.5, 1.5);
    newNode.rotateY = random(-1.5, 1.5);
    newNode.rotateZ = random(-1.5, 1.5);
    newNode.x = random(-maxHorizDim, maxHorizDim);
    newNode.y = random(-maxVertDim, maxVertDim);
    newNode.z = random(-maxHorizDim, maxHorizDim);
    newNode.scale = random(Defaults.baseScale*0.25, Defaults.baseScale);
    newNode.halfScale = newNode.scale/2;

    nodes[count] = newNode;
    count++;
  }

  void doRotation() {
    cam.rotateY(-0.005);
    cam.rotateX(-0.0001);
  }

  void draw() {
    postDraw2d();
    doRotation();

    sphereDetail(12);
    directionalLight(255, 255, 255, 0.15, -0.5, -0.7);
    directionalLight(255, 255, 255, -0.3, 0.25, 0.8);
    ambientLight(55, 55, 55);

    if (nodes[0] == null) return;

    computeNode(nodes[0], null);

    for (int i = 1; i < count; i++) {
      Node node = nodes[i];
      computeNode(node, nodes[i-1]);
    }
  }

  void computeNode(Node node, Node prevNode) {
    if (node.opacity > 0.25) {
      stroke(255, 255, 255, node.opacity);
      fill(node.nodeColor, node.opacity);

      strokeWeight(0);
      //stroke(255, 255, 255);

      drawObject(node);

      node.opacity *= (1 - node.fadeRate * 0.04);
      node.x += node.velocity.x;
      node.y += node.velocity.y;
      node.z += node.velocity.z;
      node.rotateX += node.rotVelocity.x;
      node.rotateY += node.rotVelocity.y;
      node.rotateZ += node.rotVelocity.z;

      if (prevNode != null) {
        strokeWeight(2);
        stroke(node.nodeColor, node.opacity);
        line(node.x, node.y, node.z, prevNode.x, prevNode.y, prevNode.z);
      }
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