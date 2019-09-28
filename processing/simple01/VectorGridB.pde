class VectorGridB extends VectorGrid {

  VectorGridB() {
    name = "vectorGridB";
    red1 = 255; 
    green1 = 255; 
    blue1 = 0;
    red2 = 255; 
    green2 = 0; 
    blue2 = 255;
  }

  void init(String oldSceneName) {
    if (oldSceneName != "vectorGridB") {
      reset = true;
    }
  }

  void drawShape1(float sizeX, float sizeY, float sizeZ) {  
    ellipse(0,0,sizeX, sizeY);
  }

  void drawShape2(float sizeX, float sizeY, float sizeZ) {
    float x = sizeX;
    float y = sizeY;

    beginShape();

    vertex(-x, y, 0);
    vertex( x, y, 0);
    vertex(   0, -y, 0);

    vertex( x, y, 0);
    vertex( x, y, 0);
    vertex(   0, -y, 0);

    vertex( x, y, 0);
    vertex(-x, y, 0);
    vertex(   0, -y, 0);

    vertex(-x, y, 0);
    vertex(-x, y, 0);
    vertex(0, -y, 0);    

    endShape();
  }
}