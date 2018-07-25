class Renderer {
  float[][]hits;
  int w;
  int h;
  int maxIters;
  Renderer(int a, int b, int c) {
    w=a;
    h=b;
    maxIters=c;
    hits=new float[w][h];
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        hits[x][y]=0;
      }
    };
  }
  void placePoint() {
    float origX=random(-2, 2);
    float origY=random(-2, 2);
    float x=origX;
    float y=origY;
    float addX=origX;
    float addY=origY;
    int i=0;
    while (i<maxIters&&x*x+y*y<4.0) {
      float nx=x*x-y*y;
      float ny=2*x*y;
      x=addX+nx;
      y=addY+ny;
      i++;
    }
    if (x*x+y*y>4.0) {
      i=0;
      x=origX;
      y=origY;
      while (i<maxIters&&x*x+y*y<49.0) {
        float nx=x*x-y*y;
        float ny=2*x*y;
        int rx=int(map(x, -2, 2, 0, w));
        int ry=int(map(y, -2, 2, 0, h));
        if (rx>=0&&ry>=0&&rx<w&&ry<h) {
          hits[rx][ry]++;
        }
        x=addX+nx;
        y=addY+ny;
        i++;
      }
    }
  }
}
Renderer rr, rg, rb;
boolean doIt=true;
void keyPressed() {
  if (key==' ')doIt=!doIt;
  if (key=='d')d=!d;
}
boolean d=false;

void setup() {
  size(400, 400);
  rr=new Renderer(width, height, 800);
  rg=new Renderer(width, height, 200);
  rb=new Renderer(width, height, 50);
}
float rmul=0.0;
float gmul=0.0;
float bmul=0.0;
void draw() {
  surface.setTitle("Buddhabrot, SPF="+nf(1.0/frameRate, 1, 5)+", FPS="+nf(frameRate,2,3));

  for (int num=0; num<100000&&doIt; num++) {
    rr.placePoint();
    rg.placePoint();
    rb.placePoint();
    //surface.setTitle("Buddhabrot, FPS="+nf(frameRate, 2, 3));
    //for (int x=0; x<width; x++)for (int y=0; y<height; y++)set(x, y, color(0.2*hits[x][y]));
  }
  if (key=='1') {
    rmul=0.15/5;
    gmul=0.0;
    bmul=0.0;
  }
  if (key=='2') {
    rmul=0.0;
    gmul=0.15/5;
    bmul=0.0;
  }
  if (key=='3') {
    rmul=0.0;
    gmul=0.0;
    bmul=0.15/5;
  }
  if (key=='4') {
    rmul=gmul=bmul=0.1;
  }
  if(key=='5'){
    rmul=0.1/20;
    gmul=0.15/20;
    bmul=0.15/20;
  }
  if(key=='6'){
    rmul=0.1;
    gmul=0.15;
    bmul=0.15;
  }
  if (d) {
    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        set(x, y, color(rmul*rr.hits[x][y], gmul*rg.hits[x][y], bmul*rb.hits[x][y]));
      }
    }
  }else{
    background(255);
  }
}