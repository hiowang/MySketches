class Sphere {
  float r;
  float theta;
  float phi;
  float thetaRate;
  float phiRate;
  Sphere(float _1, float _2) {
    this(_1, _2, _2);
  }
  Sphere(float _1, float _2, float _3) {
    r=_1;
    thetaRate=_2;
    phiRate=_3;
    theta=random(TWO_PI);
    phi=random(TWO_PI);
  }
  PVector pointOnSphere(float x, float y, float z) {
    return new PVector(x+r*sin(phi)*cos(theta), y+r*sin(phi)*sin(theta), z+r*cos(phi));
  }
  void render(float x, float y, float z) {
    fill(200);
    noStroke();
    translate(x, y, z);
    sphereDetail(5);
    sphere(r/2);
    translate(-x, -y, -z);
  }
  void update() {
    theta+=thetaRate;
    phi+=phiRate;
  }
}
float rand(float min, float max, float times) {
  float f=random(0, 1);
  f=int(times*f)/times;
  return (max-min)*f+min;
}
ArrayList<Sphere>spheres;
void setup() {
  size(1000, 1000, P3D);
  spheres=new ArrayList<Sphere>();
  for (int i=0; i<15; i++) {
    spheres.add(new Sphere(30, rand(0.05, 0.07, 20)));
  }
  //spheres.add(new Sphere(150,0.01,0.07));
  //spheres.add(new Sphere(150,0.01,0.03));
  //spheres.add(new Sphere(150,0.01,0.02));
  //spheres.add(new Sphere(150,0.01,0.01));
  points=new ArrayList<PVector>();
}
ArrayList<PVector>points;
void draw() {
  background(255);
  camera(500, -500, 500, 0, 0, 0, 0, 1, 0);
  rotateY(frameCount*0.01);
  pointLight(255, 255, 255, 500, -500, 500);
  for (int i=0; i<50; i++) {
    float x=0;
    float y=0;
    float z=0;
    for (Sphere s : spheres) {
      //s.render(x,y,z);
      s.update();
      PVector p=s.pointOnSphere(x, y, z);
      x=p.x;
      y=p.y;
      z=p.z;
    }
    points.add(new PVector(x, y, z));
  }
  stroke(0,30);
  strokeWeight(1);
  noFill();
  beginShape();
  for (PVector p : points) {
    vertex(p.x, p.y, p.z);
  }
  endShape();
}