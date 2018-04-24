import java.util.Map; //<>//
import peasy.*;
import oscP5.*;
import netP5.*;

HashMap<String, Scene> scenesHash;
//Scene[] scenesArray;
ArrayList<Scene> scenesList = new ArrayList<Scene>();
Scene currentScene;
Scene lastScene;
int sceneIndex = 0;
String sceneName = "nudges";
float currentMouseWheelCount;
OscP5 oscP5;
NetAddress myRemoteLocation;
PeasyCam cam;
float oscA, oscB, oscC, oscD, oscE, oscRed, oscGreen, oscBlue, oscHit, oscFade;

void setup() {
  fullScreen(P3D);
  //size(960, 800, P3D);

  cam = new PeasyCam(this, 0, 0, 0, 500);

  scenesHash = new HashMap<String, Scene>();

  scenesList.add(new Reg1());
  scenesList.add(new Reg1B());
  scenesList.add(new CubeGrid());
  scenesList.add(new CubeGridB());
  scenesList.add(new VectorGrid());
  scenesList.add(new VectorGridB());
  scenesList.add(new Spiral());
  scenesList.add(new SpiralB());
  scenesList.add(new Rain());
  scenesList.add(new RainB());
  scenesList.add(new CubeFractal());
  scenesList.add(new Nodes());
  scenesList.add(new Maze());
  scenesList.add(new MazeB());
  scenesList.add(new Reg2());
  scenesList.add(new Reg2B());
  scenesList.add(new Beziers());
  scenesList.add(new CubePops());
  scenesList.add(new Carpet());
  scenesList.add(new CarpetB());
  scenesList.add(new Nudges());

  for (int i = 0; i < scenesList.size(); i++) {
    scenesHash.put(scenesList.get(i).getName(), scenesList.get(i));
  }

  currentScene = scenesList.get(0);

  oscP5 = new OscP5(this, 5000);
  myRemoteLocation = new NetAddress("127.0.0.1", 5000);
}

void oscEvent(OscMessage msg) {
  try {
    if (msg.checkAddrPattern("/proc_osc")==true) {

      oscHit = msg.get(1).floatValue();
      sceneName = msg.get(2).stringValue();
      oscFade = msg.get(3).floatValue();
      oscA = msg.get(4).floatValue();
      oscB = msg.get(5).floatValue();
      oscC = msg.get(6).floatValue();
      oscD = msg.get(7).floatValue();
      oscE = msg.get(8).floatValue();
      oscRed = msg.get(9).floatValue();
      oscGreen = msg.get(10).floatValue();
      oscBlue = msg.get(11).floatValue();

      doHitOsc();
    }
  }
  catch(Exception err) {
    println(err);
  }
}

Scene getScene() {
  //return currentScene;
  return scenesHash.get(sceneName);
}

void draw() {
  background(0); 
  Scene scene = getScene();

  if (scene == null) return;

  if (scene != lastScene) {
    scene.init(lastScene != null ? lastScene.name : "");
  }

  scene.draw();
  lastScene = scene;
}

void mousePressed() {
  doHit();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      sceneIndex++;
      if (sceneIndex >= scenesList.size()) sceneIndex = 0;      
      currentScene = scenesList.get(sceneIndex);// scenesArray[sceneIndex];
    } else if (keyCode == LEFT) {
      sceneIndex--;
      if (sceneIndex < 0) sceneIndex = scenesList.size() - 1;
      currentScene = scenesList.get(sceneIndex); // scenesArray[sceneIndex];
    }
  } else {
    if (key == ' ') {
      doHit();
    }
  }
}

void doHit() {
  float c = map(currentMouseWheelCount, 0, 100, 0, 1);
  float a = map(mouseX, 0, width, 0, 1);
  float b = map(mouseY, 0, height, 0, 1);
  float d = map(mouseX, 0, width, 0, 1);
  float e = map(mouseY, 0, height, 0, 1);

  c = 0.4;

  Scene scene = getScene();
  if (mouseButton == LEFT) {
    scene.hit(HitData.Make(1, a, b, c, d, e, 0.5, 0, 0, 0));
  } else {
    scene.hit(HitData.Make(0, a, b, c, d, e, 0.5, 0, 0, 0));
  }
}

void doHitOsc() {
  Scene scene = getScene();
  scene.hit(HitData.Make(oscHit, oscA, oscB, oscC, oscD, oscE, oscFade, oscRed, oscGreen, oscBlue));
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  currentMouseWheelCount -= e;
  if (currentMouseWheelCount < 0) {
    currentMouseWheelCount = 0;
  } else if (currentMouseWheelCount > 100) {
    currentMouseWheelCount = 100;
  }
}

public static class HitData {
  public float oscHit;
  public float oscA;
  public float oscB;
  public float oscC;
  public float oscD;
  public float oscE;
  public float oscFade;
  public float oscRed;
  public float oscGreen;
  public float oscBlue;

  public static HitData Make(float hit, float a, float b, float c, float d, float e, float fade, float red, float green, float blue) {
    HitData x = new HitData();
    x.oscHit = hit;
    x.oscA = a;
    x.oscB = b;
    x.oscC = c;
    x.oscD = d;
    x.oscE = e;
    x.oscFade = fade;
    x.oscRed = red;
    x.oscGreen = green;
    x.oscBlue = blue;
    return x;
  }
}