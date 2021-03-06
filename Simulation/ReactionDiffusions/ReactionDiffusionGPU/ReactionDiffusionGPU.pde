
PShader shader;
PGraphics pg;

void setup() {
  size(500, 500, P3D);    
  pg = createGraphics(width, height, P2D);
  pg.noSmooth();
  shader = loadShader("shader.frag");
  background(255,0,0);
}

void draw() {
  shader.set("resolution", width, height);
  shader.set("mouse", 1.0*mouseX/width, 1-1.0*mouseY/height);
  shader.set("frameCount",frameCount);
  for (int i=0; i<1; i++) {
    pg.beginDraw();
    pg.background(0);
    pg.shader(shader);
    pg.rect(0, 0, pg.width, pg.height);
    pg.resetShader();
    
    if(mousePressed){
      pg.fill(0,255,0);
      pg.noStroke();
      pg.ellipse(mouseX-5,mouseY-5,10,10);
    }

    pg.endDraw();  
    image(pg, 0, 0, width, height);
  }
}