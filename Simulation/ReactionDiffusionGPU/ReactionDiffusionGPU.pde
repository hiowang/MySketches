
PShader compute;
PGraphics pg;

void setup() {
  size(1000, 1000, P3D);    
  pg = createGraphics(1000, 1000, P2D);
  pg.noSmooth();
  compute = loadShader("compute.frag");
  //background(0, 255, 0);
  //fill(0, 255, 0);
  //noStroke();
  //rect(50, 50, 20, 20);
}

void setVals(float Da, float Db, float f, float k, float dt) {
  compute.set("Da", Da);
  compute.set("Db", Db);
  compute.set("f", f);
  compute.set("k", k);
  compute.set("dt", dt);
}

void draw() {
  //for (int i=0; i<50; i++) {
  compute.set("resolution", float(pg.width), float(pg.height));
  compute.set("time", millis()/1000.0);
  //setVals(1.0, 0.5, 0.055, 0.062, 1.0);
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 1, 0);
  compute.set("mouse", x, y);  
  compute.set("mousePressed", (mousePressed? (mouseButton==LEFT?1:2)   :0));
  compute.set("mousePressRad", 0.010);
  pg.beginDraw();
  pg.background(0);
  pg.shader(compute);
  pg.rect(0, 0, pg.width, pg.height);
  pg.endDraw();  
  image(pg, 0, 0, width, height);
  surface.setTitle("ReactionDiffusionGPU, frameRate="+nf(frameRate,2,3)+", frameCount="+frameCount);
  //}
}