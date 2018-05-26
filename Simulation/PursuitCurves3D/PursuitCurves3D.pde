PVector randomOnSphere() {
  float theta=random(TWO_PI);
  float phi=random(TWO_PI);
  return new PVector(sin(phi)*cos(theta), sin(phi)*sin(theta), cos(phi));
}
class Follower {
  int targetInd;
  PVector pos;
  float speed;
  color col;
  ArrayList<PVector>past;
  Follower() {
    pos=randomOnSphere();
    pos.mult(100);
    speed=1;
    past=new ArrayList<PVector>();
    col=color(random(255), random(255), random(255));
  }
  void display() {
    for (int i=1; i<past.size(); i++) {
      stroke(col);
      strokeWeight(2);
      PVector v=past.get(i);
      PVector p=past.get(i-1);
      stroke(red(col), green(col), blue(col), 100*(1.0*i/past.size())+5);
      line(v.x, v.y, v.z, p.x, p.y, p.z);
      //translate(v.x, v.y, v.z);
      //fill(red(col),green(col),blue(col),255*(1.0*i/past.size()));
      //noStroke();
      //box(0.5);
      //translate(-v.x, -v.y, -v.z);
    }
  }
  void update() {
    //if (pos.mag()>1000)return;
    //while (past.size()>20)past.remove(0);
    Follower f=followers.get(targetInd);
    if(f.pos.equals(pos))return;
    stroke(col);
    fill(col);
    translate(pos.x,pos.y,pos.z);
    box(2);
    translate(-pos.x,-pos.y,-pos.z);
    line(f.pos.x, f.pos.y, f.pos.z, pos.x, pos.y, pos.z);
    PVector dir=PVector.sub(f.pos, pos);
    if(dir.mag()<0.5)return;
    //if(dir.mag()<0.1)pos=randomOnSphere().mult(100);
    dir.setMag(speed);
    past.add(pos.copy());
    pos.add(dir);
    //if(pos.x<-100)pos.x=100;
    //else if(pos.x>100)pos.x=-100;
    //if(pos.y<-100)pos.y=100;
    //else if(pos.y>100)pos.y=-100;
    //if(pos.z<-100)pos.z=100;
    //else if(pos.z>100)pos.z=-100;
  }
}
ArrayList<Follower>followers;
void setup() {
  fullScreen(P3D);
  pixelDensity(2);
  init();
}
void init() {
  followers=new ArrayList<Follower>();
  int numToAdd=20;
  for (int i=0; i<numToAdd; i++) {
    Follower f=new Follower();
    //f.targetInd=(i+1)%numToAdd;
    f.targetInd=int(random(numToAdd));
    f.speed=0.5;
    followers.add(f);
  }
  for(int i=0;i<followers.size();i++){
    Follower f=followers.get(i);
    while(f.targetInd==i)f.targetInd=int(random(numToAdd));
    while(f.targetInd==followers.get(f.targetInd).targetInd)f.targetInd=int(random(followers.size()));
    followers.set(i,f);
  }
}
void mousePressed() {
  init();
}
float rot=0;
void draw() {
  rot+=0.0025;
  background(255);
  //camera(200, -150, 200, 0, 0, 0, 0, 1, 0);
  PVector p1=followers.get(0).pos;
  PVector p2=followers.get(1).pos;
  //PVector diff=PVector.sub(p2,p1);
  //PVector eye=p1.sub(diff.mult(0.5));
  //PVector target=p1.add(diff.mult(0.5));
  float cameraZ= ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, width/height, 0.001, cameraZ*10.0);
  camera(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z,0,1,0);
  rotateX(map(mouseY,0,height,-PI,PI));
  rotateY(map(mouseX,0,width,-PI,PI));
  noFill();
  stroke(0);
  //box(200);
  for (Follower f : followers) {
    f.display();
    f.update();
  }
}