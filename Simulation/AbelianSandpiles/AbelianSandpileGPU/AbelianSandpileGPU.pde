
PShader shader;
PGraphics pg;

void setup() {
  size(400, 400, P3D);    
  pg = createGraphics(width, height, P2D);
  pg.noSmooth();
  noSmooth();
  shader = loadShader("shader.frag");
}

void draw() {
  shader.set("resolution", pg.width, pg.height);
  shader.set("mouse", 1.0*mouseX/width, 1-1.0*mouseY/height);
  shader.set("center", 0.5, 0.5);
  shader.set("frameCount", frameCount);
  for (int i=0; i<(frameCount%1==0?10:0); i++) {
    pg.beginDraw();
    pg.background(0);
    pg.shader(shader);
    pg.rect(0, 0, pg.width, pg.height);
    pg.resetShader();

    pg.set(pg.width/2,pg.height/2,color(255));

    pg.endDraw();
    image(pg, 0, 0, width, height);
  }
}