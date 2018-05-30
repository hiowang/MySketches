import queasycam.*;
//https://www.youtube.com/watch?v=quFVoZLxP_c
float x, y, z;
ArrayList<PVector>list=new ArrayList<PVector>();
QueasyCam qc;
void setup() {
  size(750, 750, P3D);
  qc=new QueasyCam(this);
  //x=1;
  //y=1;
  //z=0;
  x=1.2;y=1;z=-0.02;
  
}
void draw() {
  background(255);
  //camera(1500, 0, 500, 0, 0, 0, 0, 1, 0);
  noFill();
  stroke(0,100);
  beginShape();
  for (int i=0; i<list.size(); i++) {
    PVector p=list.get(i);
    vertex(p.x*100, p.y*100, p.z*1000);
  }
  endShape();
  for (int i=0; i<100; i++) {
    list.add(new PVector(x, y, z));
    float ox=x;
    float oy=y;
    float oz=z;
    while (dist(x, y, z, ox, oy, oz)<0.01) {
      float dx=3*x*(1-y)-2.2*z;
      float dy=-y*(1-x*x);
      float dz=0.001*x;
      float factor=0.001;
      x+=dx*factor;
      y+=dy*factor;
      z+=dz*factor;
    }
  }
}
void line(PVector a, PVector b) {
  a.mult(500);
  b.mult(500);
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}