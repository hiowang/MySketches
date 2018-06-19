
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
  pg.fill(255/2);
  pg.rect(0,0,width,height);
  pg.endDraw();
  background(255/2);
}

boolean doIt=false;

void draw() {
  //if (frameCount<=10)background(255);
  for (int i=0; i<100; i++) {
    if (doIt) {
      shader.set("slope", tan(random(-PI, PI)));
      shader.set("cx", random(1.0));
      shader.set("cy", random(1.0));
      shader.set("diff", 0.0025*(random(100)<50?-1:1));
      shader.set("maxDist",0.25);
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