class Reg1B extends Reg1 {
  Reg1B() {
    name = "reg1B";
    red1 = 255; 
    green1 = 0; 
    blue1 = 0;
    red2 = 255; 
    green2 = 255; 
    blue2 = 255;
  }

  void init(String oldSceneName) {
    if (oldSceneName != "reg1B") {
      //cam.reset(0);
    }
    resetCam = true;
  }
}