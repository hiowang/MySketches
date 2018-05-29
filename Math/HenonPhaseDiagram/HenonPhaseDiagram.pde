float x, y;
float a, b;
void setup() {
  size(500, 500);
  x=0;
  y=0;
  a=1.4;
  b=0.3;
  background(255);
  pixelDensity(2);
}
void mouseDragged(){
  background(255);
  x=0;
  y=0;
  a=map(mouseX,0,width,-2,2);
  b=map(mouseY,0,height,-1,1);
  for (int i=0;i<1000;i++) {
    float newX=1-a*x*x+y;
    float newY=b*x;
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
  background(255);
  fill(0);
  noStroke();
  a=radians(map(mouseX,0,width,-15,15));
  x=1;
  y=0;
  for (int i=0;i<10000;i++) {
    float newX=x*cos(a)-(y-x*x)*sin(a);
    float newY=x*sin(a)-(y-x*x)*cos(a);
    float d=dist(x,y,newX,newY);
    x=newX;
    y=newY;
    colorMode(HSB,100);
    fill((d*100)%100,100,100);
    colorMode(RGB,255);
    ellipse(x*width/2+width/2, y*height/2+height/2, 1, 1);
  }
}