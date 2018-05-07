import processing.video.*;

float d=2;
Capture cap;
void setup() {
  size(640,480);
  cap=new Capture(this,320,240);
  cap.start();
  background(21, 8, 50);
}
void draw() {
  smooth();
  colorMode(HSB,100);
  for(int i=0;i<1000;i++){
    PVector a=rand();
    PVector b=PVector.add(a,PVector.random2D().mult(10));
    stroke(col(a.x/2,a.y/2));
    line(a.x,a.y,b.x,b.y);
  }
}
PVector rand(){
  return new PVector(random(width),random(height));
}
void captureEvent(Capture video) {
  video.read();
}
color col(float x,float y){
  int ix=int(x);
  int iy=int(y);
  return cap.get(ix,iy);
}