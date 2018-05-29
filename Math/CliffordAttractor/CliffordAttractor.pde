float x, y;
float a, b, c, d;
void setup() {
  size(500, 500);
  x=0;
  y=0;
  //a=-1.4;
  //b=1.6;
  //c=1.0;
  //d=0.7;
  assign(-1.4,1.6,1.0,0.7);
  //assign(1.7,-0.6,-1.2,1.6);
  //assign(1.7,1.7,0.6,1.2);
  //assign(1.5,-1.8,1.6,0.9);
  //assign(-1.7,1.3,-0.1,-1.2);
  //assign(-1.7,1.8,-1.9,-0.4);
  //assign(-1.8,-2.0,-0.5,-0.9);
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
    float newX=sin(a*y)+c*cos(a*x);
    float newY=sin(b*x)+d*cos(b*y);
    float d=dist(x,y,newX,newY);
    x=newX;
    y=newY;
    colorMode(HSB,100);
    fill((d*100)%100,100,100);
    colorMode(RGB,255);
    ellipse(-x*width/6+width/2, -y*height/6+height/2, 1, 1);
  }
}