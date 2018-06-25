//start with one point at (0,0,0)
ArrayList<PVector>stuck=new ArrayList<PVector>();
ArrayList<Float>times=new ArrayList<Float>();
class Line {
  PVector a, b;
}
ArrayList<Line>lines=new ArrayList<Line>();
void setup() {
  size(500, 500, P3D);
}
PVector pointOnSphere(float r, float phi, float theta) {
  return new PVector(r*sin(phi)*cos(theta), r*sin(phi)*sin(theta), r*cos(phi));
}
void draw() {
  background(0);
  camera(50, -50, 50, 0, 0, 0, 0, 1, 0);
  rotateY(frameCount*0.01);
  //for(int i=0;i<stuck.size();i++){
  //  PVector p=stuck.get(i);
  //  noStroke();
  //  colorMode(HSB,100);
  //  fill((100*(times.get(i)/10.0))%100,50,100);
  //  colorMode(RGB,255);
  //  pushMatrix();
  //  translate(p.x,p.y,p.z);
  //  box(1);
  //  popMatrix();
  //}
  for (Line l : lines) {
    stroke(255);
    line(l.a.x, l.a.y, l.a.z, l.b.x, l.b.y, l.b.z);
  }
  for (int i=0; i<10; i++)addNew();
}
PVector collides(PVector p) {
  if(p.mag()>40)return p.copy().normalize().mult(40);
  for(PVector p1:stuck)if(PVector.dist(p,p1)<2)return p1;
  return null;
}
void addNew() {
  PVector p=new PVector(0,0,0);
  float d=2;
  PVector collidesWith=collides(p);
  while (collidesWith==null) {
    p.x+=random(-d, d);
    p.y+=random(-d, d);
    p.z+=random(-d, d);
    collidesWith=collides(p);
  }
  stuck.add(p);
  times.add((float)frameCount);
  Line l=new Line();
  l.a=p;
  l.b=collidesWith;
  lines.add(l);
}