void setup(){
  //fullScreen();
  size(500,500);
}
class Circle{
  float ang,r,off;
  color col;
  Circle(float ang,float r,float off,color col){
    this.ang=ang;
    this.r=r;
    this.off=off;
    this.col=col;
  }
  void draw(){
    fill(col);
    noStroke();
    ellipse(cos(ang)*r,sin(ang)*r,5,5);
  }
}
void draw(){
  background(0);
  noCursor();
  if(frameCount%2==0)drawCircles();
  translate(width/2,height/2);
  for(Circle c:circles){
    c.draw();
  }
  //saveFrame("frames01/frame-#####.png");
}
void mousePressed(){
  drawCircles();
}
float r=1;
float off=0;
ArrayList<Circle>circles=new ArrayList<Circle>();
void drawCircles(){
  float n=10;
  r+=3;
  //r*=2;
  //r*=1.01;
  angOff+=radians(137.5);
  off+=0.1;
  for(int i=0;i<n;i++){
    circles.add(new Circle(TWO_PI*i/n+angOff,r,off,col(i/n+off)));
  }
}
float angOff=0;
color col(float f){
  f=f%1;
  colorMode(HSB,100);
  color c=color(f*100,100,100);
  colorMode(RGB,255);
  return c;
}