class CubeGridB extends CubeGrid {
  CubeGridB() {
    name = "cubeGridB";
    red1 = 50; 
    green1 = 100; 
    blue1 = 255;
    red2 = 255; 
    green2 = 255; 
    blue2 = 150;
  }

  void init(String oldSceneName) {
    if (oldSceneName != "cubeGridB"){
        //cam.reset(0);
    }
  }

  void doRotation() {
    cam.rotateY(-0.01);
    cam.rotateX(-0.005);
  }
}