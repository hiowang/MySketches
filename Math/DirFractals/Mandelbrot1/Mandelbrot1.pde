void setup() {
  size(500, 500);
  pixelDensity(2);
  textFont(loadFont("Monospaced-20.vlw"));
}
float density=1;
float offx=0;
float offy=0;
float scale=1;
float targoffx=0, targoffy=0, targscale=1;
float mapX(float x) {
  x=map(x, 0, width, -2, 2);
  x*=scale;
  return x;
}
float n=0;
float mapY(float y) {
  y=map(y, 0, height, -2, 2);
  y*=scale;
  return y;
}
void mouseWheel(MouseEvent me) {
  float count=me.getCount();
  targscale+=count/100;
}
public static long combo(long choose, long total) {
  if (total < choose)
    return 0;
  if (choose == 0 || choose == total)
    return 1;
  return combo(total-1, choose-1)+combo(total-1, choose);
}
void draw() {
  background(0);
  n+=0.25;
  if (mousePressed) {
    targoffx=offx+mapX(mouseX);
    targoffy=offy+mapY(mouseY);
  }
  offx=lerp(offx, targoffx, 0.1);
  offy=lerp(offy, targoffy, 0.1);
  scale=lerp(scale, targscale, 0.1);
  if (targscale<0.00001)targscale=0.00001;
  if (scale<0.00001)scale=0.00001;
  for (float x=0; x<width*2; x+=density) {
    for (float y=0; y<height*2; y+=density) {
      double a=mapX(x);
      double b=mapY(y);
      a+=offx;
      b+=offy;
      double origa=a;
      double origb=b;

      int numIters=0;

      while (numIters<30&&calcMag((float)a,(float)b)<4) {
        double na=a*a-b*b;
        double nb=2*a*b;
        a=na;
        b=nb;
        a+=origa;
        b+=origb;

        numIters++;
      }
  
      color col=color(0, 0, 0);
      float v=float(numIters)/30;
      if (doHSB) {
        colorMode(HSB, 100);
        col=color(v*100, 100, 100);
        colorMode(RGB, 255);
      } else {
        col=color(v*255);
      }
      if (numIters==30)col=color(0);
      fill(col);
      stroke(col);
      rect(x, y, density, density);
    }
  }
  stroke(255);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  println("end frame "+frameCount);
}
boolean doHSB=true;
void keyPressed() {
  if (key=='h')doHSB=!doHSB;
}
float calcMag(float a,float b){
  //return abs(a)+abs(b);
  return sqrt(a*a+b*b);
}