void setup() {
  size(500, 500);
  osn=new OpenSimplexNoise();
  background(0);
  //for(int i=0;i<10000;i++)placeLine();
}
void draw() {
  for (int i=0; i<100; i++) {
    placeLine();
  }
}
void placeLine() {
  float x=random(-width/2,width/4);
  float y=random(-height/2,height/4);
  float ang=(frameCount*0.1)%TWO_PI;
  float nx=cos(ang)*x+sin(ang)*y;
  float ny=sin(ang)*x-cos(ang)*y;
  x=nx+width/2;
  y=ny+height/2;
  float mapX=map(x, 0, width, 0, 255);
  float mapY=map(y, 0, height, 0, 255);
  float red=(frameCount*1)%255;
  red=map(cos(frameCount*0.01), -1, 1, 0, 255);
  color col=color( red, mapX, mapY);
  stroke(col);
  line(x, y, x+random(-20, 20), y+random(-20, 20));
}
OpenSimplexNoise osn;
float noise(float x, float y) {
  return (float)osn.eval(x, y);
}