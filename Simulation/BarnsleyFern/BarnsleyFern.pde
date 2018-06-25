
void setup() {
  size(500, 500);
  background(255);
}
double x=0;
double y=0;
void drawPoint() {
  colorMode(HSB,100);
  stroke(map( (float)y,0,9.9983,0,100),100,100,20 );
  colorMode(RGB,255);
  point(map((float)x, -2.1820, 2.6558, 0, width), map((float)y, 0, 9.9983, height, 0));
}
void nextPoint(){
  float r=random(1);
  double nx=0;
  double ny=0;
  if(r<0.01){
    nx=0;
    ny=0.16*y;
  }else if(r<0.87){
    nx=0.85*x+0.04*y;
    ny=-0.04*x+0.85*y+1.6;
  }else if(r<0.93){
    nx=0.2*x-0.26*y;
    ny=0.23*x+0.22*y+1.6;
  }else{
    nx=-0.15*x+0.28*y;
    ny=0.26*x+0.24*y+0.44;
  }
  x=nx;
  y=ny;
}
void draw() {
  for(int i=0;i<500;i++){
    drawPoint();
    nextPoint();
  }
}