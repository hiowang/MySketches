float x, y;
float a, b, c, d;
void setup() {
  size(500, 500);
  x=0;
  y=0;
  assign(1.641,1.902,0.316,1.525);
  assign(0.970,-1.899,1.381,-1.506);
  assign(2.01,-2.53,1.61,-0.33);
  assign(-2.7,-0.09,-0.86,-2.2);
  assign(-0.827,-1.637,1.659,-0.943);
  assign(-2.24,0.43,-0.65,-2.43);
  assign(-2,-2,-1.2,2);
  assign(-0.709,1.638,0.452,1.740);
  background(255);
  pixelDensity(2);
}
void assign(float _1,float _2,float _3,float _4){
  a=_1;
  b=_2;
  c=_3;
  d=_4;
}
void mouseDragged(){
  background(255);
  x=0;
  y=0;
  a=map(mouseX,0,width,-2,2);
  b=map(mouseY,0,height,-1,1);
  for (int i=0;i<1000;i++) {
    float newX=x-a*sin(y+tan(b*y));
    float newY=y-a*sin(x+tan(b*x));
    float d=dist(x,y,newX,newY);
    x=newX;
    y=newY;
    colorMode(HSB,100);
    fill((d*100)%100,100,100);
    colorMode(RGB,255);
    ellipse(x*width/2+width/2, y*height/2+height/2, 1, 1);
  }
}
void draw() {
  fill(0);
  noStroke();
  for (int i=0;i<10000;i++) {
    float newX=sin(a*y)-cos(b*x);
    float newY=sin(c*x)-cos(d*y);
    float d=dist(x,y,newX,newY);
    x=newX;
    y=newY;
    colorMode(HSB,100);
    fill((d*100)%100,100,100);
    colorMode(RGB,255);
    ellipse(-x*width/6+width/2, -y*height/6+height/2, 1, 1);
  }
}