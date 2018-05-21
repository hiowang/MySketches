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
      PVector v=past.get(i);
      PVector p=past.get(i-1);
      stroke(red(col), green(col), blue(col), 235*(1.0*i/past.size())+20);
      line(v.x, v.y, v.z, p.x, p.y, p.z);
      //translate(v.x, v.y, v.z);
      //fill(red(col),green(col),blue(col),255*(1.0*i/past.size()));
      //noStroke();
      //box(0.5);
      //translate(-v.x, -v.y, -v.z);
    }
  }
  void update() {
    if (pos.mag()>200)return;
    //while (past.size()>20)past.remove(0);
    Follower f=followers.get(targetInd);
    //stroke(0);
    //line(f.pos.x, f.pos.y, f.pos.z, pos.x, pos.y, pos.z);
    PVector dir=PVector.sub(f.pos, pos);
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
  int numToAdd=150;
  for (int i=0; i<numToAdd; i++) {
    Follower f=new Follower();
    //f.targetInd=(i+1)%numToAdd;
    f.targetInd=int(random(numToAdd));
    followers.add(f);
  }
}
void mousePressed() {
  init();
}
float rot=0;
void draw() {
  rot+=0.0025;
  background(255);
  camera(200, -150, 200, 0, 0, 0, 0, 1, 0);
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