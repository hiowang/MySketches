class Cube{
  float x,y,z,size;
  Cube(float _1,float _2,float _3,float _4){
    x=_1;
    y=_2;
    z=_3;
    size=_4;
  }
  void display(){
    noFill();
    stroke(0,5);
    translate(x,y,z);
    box(size);
    translate(-x,-y,-z);
  }
  ArrayList<Cube>makeNew(){
    ArrayList<Cube>list=new ArrayList<Cube>();
    list.add(new Cube(x-size/4,y-size/4,z-size/4,size/2));
    list.add(new Cube(x+size/4,y-size/4,z-size/4,size/2));
    list.add(new Cube(x-size/4,y+size/4,z-size/4,size/2));
    list.add(new Cube(x+size/4,y+size/4,z-size/4,size/2));
    list.add(new Cube(x-size/4,y-size/4,z+size/4,size/2));
    list.add(new Cube(x+size/4,y-size/4,z+size/4,size/2));
    list.add(new Cube(x-size/4,y+size/4,z+size/4,size/2));
    list.add(new Cube(x+size/4,y+size/4,z+size/4,size/2));
    return list;
  }
  float area(){
    return size*size*size;
  }
  boolean contains(float a,float b,float c){
    return inRange(a,x-size/2,x+size/2)&&inRange(b,y-size/2,y+size/2)&&inRange(c,z-size/2,z+size/2);
  }
  
}
boolean inRange(float a,float b,float c){
  return a>=b&&a<=c;
}
ArrayList<Cube>cubes;
void setup(){
  size(1000,1000,P3D);
  init();
}
void init(){
  cubes=new ArrayList<Cube>();
  cubes.add(new Cube(0,0,0,400));
  point=new PVector(0,0,0);
  pastPoints=new ArrayList<PVector>();
  noiseSeed( (long)(Math.random()*Long.MAX_VALUE));
}
void mousePressed(){
  iterate();
}
void keyPressed(){
  if(key==' ')init();
}
boolean splitCube(Cube c){
  return c.contains(point.x,point.y,point.z)&&c.area()>20;
}
void iterate(){
  ArrayList<Cube>list=new ArrayList<Cube>();
  for(Cube c:cubes)if(splitCube(c))list.addAll(c.makeNew());else list.add(c);
  cubes.clear();
  cubes.addAll(list);
}
PVector point;
float rotY=0;
ArrayList<PVector>pastPoints;
void draw(){
  iterate();
  background(255);
  rotY+=0.0025;
  camera(500,-300,500, 0,0,0, 0,1,0);
  rotateY(rotY);
  for(Cube c:cubes)c.display();
  fill(255,0,0);
  noStroke();
  translate(point.x,point.y,point.z);
  box(10);
  translate(-point.x,-point.y,-point.z);
  float f=50;
  float zoom=0.01;
  float dx=noise(point.x*zoom,point.y*zoom,point.z*zoom)-0.5;
  float dy=noise(point.x*zoom+f,point.y*zoom+f,point.z*zoom+f)-0.5;
  float dz=noise(point.x*zoom+f+f,point.y*zoom+f+f,point.z*zoom+f+f)-0.5;
  float g=10;
  point.x+=dx*g;
  point.y+=dy*g;
  point.z+=dz*g;
  pastPoints.add(point.copy());
  stroke(0,0,255);
  strokeWeight(4);
  for(int i=1;i<pastPoints.size();i++){
    PVector p1=pastPoints.get(i-1);
    PVector p2=pastPoints.get(i);
    line(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z);
  }
  strokeWeight(1);
}