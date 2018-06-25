
PShader shader;
PGraphics pg;

void setup() {
  //fullScreen(P3D);
  //size(300,300,P3D);
  //size(1000, 1000, P3D);
  //pixelDensity(2);
  //size(400, 400, P3D);
  size(600,600,P3D);
  pg = createGraphics(width, height, P3D);
  pg.noSmooth();
  shader = loadShader("shader.frag");
  shader.set("resolution", float(pg.width), float(pg.height));
  pg.beginDraw();
  pg.fill(255,0,0);
  pg.rect(0,0,width,height);
  pg.endDraw();
  fill(255,0,0);
  rect(0,0,width,height);
}

boolean doIt=true;

void draw() {
  //if (frameCount<=10)background(255);
  for (int i=0; i<100; i++) {
    if (doIt) {
      shader.set("mouse",1.0*mouseX/width,1.0-1.0*mouseY/height);
      shader.set("mousePressed",mousePressed);
      pg.beginDraw();
      pg.shader(shader);
      pg.rect(0, 0, width, height);
      pg.endDraw();
    }  
    image(pg, 0, 0, width, height);
  }
}
void keyPressed() {
  if (key==' ')doIt=!doIt;
}