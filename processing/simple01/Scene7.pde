public static class Defaults {
  public static float baseScale = 40;
}

public class Scene7b extends Scene7 {
  public Scene7b() {
  }

  String getName() {
    return "scene7b";
  }
}

public class Scene7 extends Scene {

  Node[] nodes;
  int count;
  boolean high;

  Scene7() {
  }

  String getName() {
    return "scene7";
  }

  void reset() {
    nodes = new Node[50];
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

  void hit(float hitVal, float a, float b, float c, float d, float fade) {
    if (nodes[nodes.length -1] != null) {
      reset();
    }

    high = hitVal > 0.5;

    fade = random(0, 1);

    Node lastNode = null;

    if (count > 0) {
      lastNode = nodes[count-1];
    }

    Node newNode = new Node();
    newNode.fadeRate = fade;
    newNode.nodeColor = color(random(0, 255), random(0, 255), random(0, 255));

    if (lastNode != null) {
      newNode.rotateX = random(-1.5, 1.5);
      newNode.rotateY = random(-1.5, 1.5);
      newNode.rotateZ = random(-1.5, 1.5);
      newNode.x = (lastNode.x + lastNode.scale/2) ;
      newNode.y = (lastNode.y + lastNode.scale/2* randomSignum()) ;
      newNode.z = (lastNode.z + lastNode.scale/2* randomSignum()) ;
      newNode.scale = random(Defaults.baseScale*0.25, Defaults.baseScale);
    }

    nodes[count] = newNode;
    count++;
  }

  void doRotation() {
    cam.rotateY(-0.01);
    //cam.rotateX(0.001);
    //cam.rotateZ(0.00133);
  }

  void draw() {
    postDraw2d();
    doRotation();

    sphereDetail(10);
    directionalLight(255, 255, 255, 0.15, -0.5, -0.7);
    directionalLight(255, 255, 255, -0.3, 0.25, 0.8);
    ambientLight(55, 55, 55);

    strokeWeight(0);
    stroke(255, 255, 255);

    for (int i = 0; i < count; i++) {
      Node node = nodes[i];
      if (node.opacity > 0) {
        stroke(255, 255, 255, node.opacity);
        fill(node.nodeColor, node.opacity);

        drawObject(node, 1, 1, 1);
        drawObject(node, -1, 1, -1);
        drawObject(node, -1, 1, 1);
        drawObject(node, 1, 1, -1);

        node.opacity *= (1 - node.fadeRate * 0.01);
      }
    }
  }

  void drawObject(Node node, int xmod, int ymod, int zmod) {

    translate(node.x * xmod, node.y * ymod, node.z * zmod);
    rotateX(node.rotateX);
    rotateY(node.rotateY);
    rotateZ(node.rotateZ);
    if (high) {
      sphere(node.scale);
    } else {
      box(node.scale, node.scale, node.scale);
    }
    rotateZ(-node.rotateZ);
    rotateY(-node.rotateY);
    rotateX(-node.rotateX);
    translate(-node.x * xmod, -node.y * ymod, -node.z * zmod);
  }
}

public class Node {

  public float x = 0;
  public float y = 0;
  public float z = 0;
  public float scale = Defaults.baseScale;
  public float rotateX;
  public float rotateY;
  public float rotateZ;
  public color nodeColor;
  public float fadeRate = 0;
  public float opacity = 255;
}