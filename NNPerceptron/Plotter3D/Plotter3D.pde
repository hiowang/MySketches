import queasycam.*;

void setup() {
  //size(1000, 1000, P3D);
  fullScreen(P3D);
  QueasyCam qc=new QueasyCam(this);
  qc.controllable=true;
  qc.speed=0.5;
  //qc.sensitivity=0.;
}
void draw() {
  background(0);
  //CoordProvider cp=new Noise3Provider(0.005,500);
  //CoordProvider cp=new Noise2Provider(0.0025,100);
  //CoordProvider cp=new CorkscrewProvider();
  CoordProvider cp=new NoiseExp();
  //camera(0,5,0, 0,0,0, 0,1,0);
  for (float t=frameCount-50000; t<frameCount; t+=1) {
    float x1=cp.x(t);
    float y1=cp.y(t);
    float z1=cp.z(t);
    //stroke(255);
    colorMode(HSB);
    float a=255*(t-frameCount+1000)/1000;
    //float a=255;
    float h=cp.calcHue(t);
    stroke(h,255,255,a);
    fill(h,255,255,a);
    pushMatrix();
    translate(x1,y1,z1);
    sphereDetail(1);
    sphere(1);
    popMatrix();
    //line(x1, y1, z1, x2, y2, z2);
  }
  //fill(255);
  //text("FPS:"+frameRate, 100, 100);
}

interface CoordProvider{
  float x(float t);
  float y(float t);
  float z(float t);
  float calcHue(float t);
}

class CorkscrewProvider implements CoordProvider{
  float z=0.1;
  float x(float t){return sin(t*z)*10;}
  float y(float t){return cos(t*z)*10;}
  float z(float t){return t*z;}
  float calcHue(float t){return ((x(t)/10+y(t)/10)+1.5)*120;}
}

class Noise3Provider implements CoordProvider{
  float zoom,scale;
  Noise3Provider(float z,float s){
    zoom=z;
    scale=s;
  }
  float x(float t){
    return noise(t*zoom)*scale;
  }
  float y(float t){
    return noise(t*zoom+100)*scale;
  }
  float z(float t){
    return noise(t*zoom+200)*scale;
  }
  float calcHue(float t){
    return noise(t*zoom,t*zoom+100,t*zoom+200)*360;
  }
}
class NoiseExp implements CoordProvider{
  float x(float t){
    return t%30;
  }
  float y(float t){
    return (int)(t/30);
  }
  float z(float t){
    return 0;
  }
  float z=0.01;
  float calcHue(float t){
    return pow(noise(x(t)*z,y(t)*z+100),noise(x(t)*z,y(t)*z+200))*360;
  }
}

class Noise2Provider implements CoordProvider{
  float zoom,scale;
  Noise2Provider(float z,float s){
    zoom=z;
    scale=s;
  }
  float x(float t){
    return noise(t*zoom)*scale;
  }
  float y(float t){
    return noise(t*zoom+100)*scale;
  }
  float z(float t){
    //return noise(t*zoom+200)*scale;
    return 0;
  }
  float calcHue(float t){
    return noise(t*zoom,t*zoom+100)*360;
  }
}