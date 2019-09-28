abstract class Scene {
  String name;

  String getName() {
    return name;
  }

  void init(String oldSceneName) {
  }

  void draw() {
    hint(ENABLE_DEPTH_TEST);
    draw3d();
    //camera();
    hint(DISABLE_DEPTH_TEST);
    draw2d();
    postDraw();
  }

  void draw2d() {
  }

  void draw3d() {
  }
  
  void postDraw(){
  }

  void hit(HitData data) {
  }


}