void setup() {
  size(300, 300);
  //pixelDensity(2);
  osn=new OpenSimplexNoise((long)(Math.random()*Long.MAX_VALUE));
}
float zoom=0.01;
int roundTo=20;
float thickness=0.01;
float z=0;
float dz=0.01;
OpenSimplexNoise osn;
float noise(float x,float y,float z){
  return (float)(osn.eval(x,y,z))*0.5+0.5;
}
float zoom2=0.025;
float zoom3=0.05;
void draw() {
  z+=dz;
  //zoom3=map(mouseX,0,width*2,0,0.2);
  println(zoom3);
  background(255);
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      set(x, y, color(0));
      float n=noise(x*zoom, y*zoom,z)*0.5+noise(x*zoom2,y*zoom2,z+100)*0.35+noise(x*zoom3,y*zoom3,z+200)*0.15;//multi octaves! class Octave?
      float round=float(int(n*roundTo))/roundTo;
      colorMode(HSB, 100);
      if (abs(n-round)<thickness)set(x, y, color(n*100, 100, 100));
      //else set(x,y,color(n*100,20,100));
      colorMode(RGB, 255);
    }
  }
}