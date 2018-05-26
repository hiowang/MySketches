float x, y, z;

void setup() {
  size(1024, 1024, P3D);
  x=0;
  y=-0.001;
  z=0;
  mousePressed();
}
void mousePressed(){
  a=random(5,15);
  b=random(20,40);
  c=random(0,3);
  list.clear();
}
float rotY=0;
boolean isA=false, isD=false;
void keyPressed() {
  if (key=='a')isA=!isA;
  if (key=='d')isD=!isD;
  if (key==' ')isA=isD=false;
}
ArrayList<PVector>list=new ArrayList<PVector>();
float a=10;
float b=28;
float c=8.0/3;
void draw() {
  for (int i=0; i<200; i++) {
    float dx=a*(y-x);
    float dy=x*(b-z)-y;
    float dz=x*y-c*z;
    float diff=0.001;
    dx*=diff;
    dy*=diff;
    dz*=diff;
    list.add(new PVector(x, y, z));
    x+=dx;
    y+=dy;
    z+=dz;
  }
  //println(x+" "+y+" " +z);
  background(255);
  camera(150, -50, 150, 0, 0, 0, 0, 1, 0);
  rotateY(rotY);
  if (isA)rotY-=0.01;
  if (isD)rotY+=0.01;
  noFill();
  //fill(0);
  stroke(0, 50);
  //line(-100, 0, 0, 100, 0, 0);
  //line(0, -100, 0, 0, 100, 0);
  //line(0, 0, -100, 0, 0, 100);
  for(int i=1;i<list.size();i++){
    stroke(0,50);
    PVector a=list.get(i-1);
    PVector b=list.get(i);
    float dist=a.dist(b);
    colorMode(HSB,255,100,100,100);
    stroke(dist*200,100,100,50);
    colorMode(RGB,255);
    line(a.x,a.y,a.z,b.x,b.y,b.z);
  }
  //beginShape();
  //for (PVector p : list)curveVertex(p.x, p.y, p.z);
  //endShape();
}