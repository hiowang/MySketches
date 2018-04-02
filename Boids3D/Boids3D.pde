
float predFunc(float numBoids) {
  //\frac{e^{\left(x-10\right)}}{20000}+1
  return exp(numBoids+4)/20000;
  //return numBoids;
}
int totalID=0;
class Predator {
  PVector pos, vel, acc, npos, nvel, nacc;
  int id=0;
  Predator() {
    this(new PVector(random(xdepth), random(ydepth), random(zdepth)));
  }
  Predator(PVector p) {
    pos=p;
    vel=new PVector(0, 0, 0);
    acc=new PVector(0, 0, 0);
    id=totalID;
    totalID++;
  }
  void update() {
    npos=pos.copy();
    nvel=vel.copy();
    nacc=acc.copy();
    this.npos=this.pos.add(this.vel);
    this.nvel=this.vel.add(this.acc);


    PVector attack=new PVector(0, 0, 0);
    int num=0;
    for (Boid b : boids) {
      if (PVector.dist(pos, b.pos)>predSeeDist)continue;
      attack.add(PVector.sub(b.pos, pos));
      num++;
    }
    attack.mult(predAttack);
    attack.mult(predFunc(num));
    //nvel=(attack);
    nvel=nvel.add(attack);
    if (num<3)nvel.mult(0.75);
    //nvel.mult(0.5);
    if (this.nvel.mag()>predMaxVel)this.nvel.setMag(predMaxVel);


    //if (this.npos.x<0)this.npos.x=xdepth;
    //if (this.npos.y<0)this.npos.y=ydepth;
    //if (this.npos.z<0)this.npos.z=zdepth;
    //if (this.npos.x>xdepth)this.npos.x=0;
    //if (this.npos.y>ydepth)this.npos.y=0;
    //if (this.npos.z>zdepth)this.npos.z=0;
    if (new PVector(pos.x-xdepth/2, pos.y-ydepth/2, pos.z-zdepth/2).mag()>500) {
      PVector inBorders=PVector.sub(new PVector(0, 0, 0), pos);
      inBorders.mult(predStayInBorders);
      nvel.add(inBorders);
    }
    float rand=predRandom;
    if (num>3)rand=0;
    this.nacc=this.acc.add(getRandom().mult(rand));
  }
  void applyUpdate() {
    pos=npos.copy();
    vel=nvel.copy();
    acc=nacc.copy();
  }
  void display() {
    fill(200, 0, 0);
    stroke(50);
    pushMatrix();
    //translate(xoff,yoff,zoff);
    translate(pos.x, pos.y, pos.z);
    box(10);
    popMatrix();
  }
}
class Boid {
  PVector pos, vel, acc;
  PVector npos, nvel, nacc;
  int id=0;
  Boid() {
    this(new PVector(random(xdepth), random(ydepth), random(zdepth)));
  }
  Boid(PVector pos) {
    id=totalID;
    totalID++;
    this.pos=pos;
    this.vel=new PVector(0, 0, 0);
    this.acc=new PVector(0, 0, 0);
  }
  void update() {
    this.npos=pos.copy();
    this.nvel=vel.copy();
    this.nacc=acc.copy();
    this.npos=this.pos.add(this.vel);
    this.nvel=this.vel.add(this.acc);

    this.nacc=this.acc.add(getRandom().mult(boidRandom));

    PVector com=new PVector(0, 0, 0);
    int n=0;
    for (Boid b : boids) {
      if (b.id==id)continue;
      if (PVector.dist(pos, b.pos)>boidAttractDist)continue;
      com.add(b.pos);
      n++;
      //stroke(0,10);
      //line(pos.x,pos.y,b.pos.x,b.pos.y);
    }
    if (n!=0)com=com.mult(1.0/n);
    com=com.sub(this.pos);
    com=com.mult(boidCenterOfMass);

    this.nvel=this.nvel.add(com);

    PVector repel=new PVector(0, 0, 0);
    for (Boid b : boids) {
      if (b.id==id)continue;
      if (PVector.dist(pos, b.pos)>boidRepelDist)continue;
      repel=repel.sub(PVector.sub(b.pos, pos));
    }
    repel=repel.mult(boidRepel);
    this.nvel=this.nvel.add(repel);

    PVector pvel=new PVector(0, 0, 0);//p=percieved

    for (Boid b : boids) {
      if (b.id==id)continue;
      if (PVector.dist(pos, b.pos)>boidAlignDist)continue;
      pvel=pvel.add(b.vel);
    }
    pvel=pvel.mult(boidPVel);
    this.nvel=this.nvel.add(pvel);

    PVector runFromPred=new PVector(0, 0, 0);
    for (Predator p : preds) {
      if (PVector.dist(p.pos, pos)>boidSeePredDist)continue;
      runFromPred.add(PVector.sub(pos, p.pos));
    }
    runFromPred.mult(boidRunFromPred);
    nvel=nvel.add(runFromPred);
    //nvel.mult(5);

    if (this.nvel.mag()>boidMaxVel)this.nvel.setMag(boidMaxVel);

    //if (this.npos.x<0)this.npos.x=xdepth;
    //if (this.npos.y<0)this.npos.y=ydepth;
    //if (this.npos.z<0)this.npos.z=zdepth;
    //if (this.npos.x>xdepth)this.npos.x=0;
    //if (this.npos.y>ydepth)this.npos.y=0;
    //if (this.npos.z>zdepth)this.npos.z=0;
    if (new PVector(pos.x-xdepth/2, pos.y-ydepth/2, pos.z-zdepth/2).mag()>500) {
      PVector inBorders=PVector.sub(new PVector(0, 0, 0), pos);
      inBorders.mult(boidStayInBorders);
      nvel.add(inBorders);
    }
    //inBorders.
  }
  void applyUpdate() {
    pos=npos.copy();
    vel=nvel.copy();
    acc=nacc.copy();
  }
  void display() {
    fill(200);
    stroke(50);
    pushMatrix();
    //translate(xoff,yoff,zoff);
    translate(pos.x, pos.y, pos.z);
    box(5);
    popMatrix();
  }
}
PVector getRandom() {
  float ang=random(TWO_PI);
  return new PVector(cos(ang), sin(ang), random(-1, 1));
}
ArrayList<Boid>boids;
ArrayList<Predator>preds;
PFont font;

float predSeeDist=100;
float predAttack=1;
float predMaxVel=4;
float predRandom=0.1;//1
float predStayInBorders=0.01;

float boidStayInBorders=0.01;
float boidSeePredDist=80;
float boidRunFromPred=0.25;
float boidAlignDist=50;
float boidAttractDist=50;
float boidRepelDist=20;
float boidRepel=0.1;
float boidCenterOfMass=0.01;//position
float boidPVel=0.05;
float boidRandom=0;//0.01
float boidMaxVel=3;
float xdepth, ydepth, zdepth;

PVector camEye;
PVector camCenter;
PVector targetCamEye;
PVector targetCamCenter;

int camType=0;
int CamNormal=0;
int CamPred=1;
int CamPrey=2;
void keyPressed() {
  if (key==' ')camType=CamNormal;
  if (key=='p')camType=CamPred;
  if (key=='b')camType=CamPrey;
  if(key=='d'){
    if(camType==CamPred){
      if(preds.size()>0)preds.remove(0);
    }
  }
}

void setup() {
  fullScreen(P3D);
  xdepth=ydepth=zdepth=500;
  doInit();
  font=loadFont("Monospaced-12.vlw");
  textFont(font); 
  doInit();
  camEye=new PVector(-500, -300, -300);
  camCenter=new PVector(10, 10, 10);
  targetCamEye=camEye.copy();
  targetCamCenter=camCenter.copy();
}
void doInit() {
  boids=new ArrayList<Boid>();
  preds=new ArrayList<Predator>();
  for (int i=0; i<1500; i++) {
    boids.add(new Boid());
  }
}
//void mousePressed() {
  //for (int i=0; i<10; i++) {
    //if(mouseButton==LEFT)preds.add(new Predator());
    //else boids.add(new Boid());
  //}
//}
PVector lerpVec(PVector a, PVector b, float t) {
  return new PVector(lerp(a.x, b.x, t), lerp(a.y, b.y, t), lerp(a.z, b.z, t));
}
void draw() {
  if(frameCount%10==0&&mousePressed){
    if(mouseButton==LEFT)boids.add(new Boid());
    if(mouseButton==RIGHT)preds.add(new Predator());
  }
  println(camType);
  background(255);
  //perspective(PI/3.0,width/height,1,1000);
  if(camType==CamNormal){
    targetCamEye=new PVector(-500,-400,-300);
    targetCamCenter=new PVector(0,0,0);
  }
  if (camType==CamPrey&&boids.size()>0) {
    //background(100);
    Boid obj=boids.get(0);
    PVector pos=obj.pos.copy();
    PVector vel=obj.vel.copy();
    if (vel.magSq()<0.1)vel=new PVector(0, 1, 0);
    targetCamEye=PVector.sub(pos, vel.mult(10));
    targetCamCenter=PVector.add(pos, vel.mult(10));
  } else if (camType==CamPred&&preds.size()>0) {
    background(255,240,240);
    //background(0);
    Predator obj=preds.get(0);
    PVector pos=obj.pos.copy();
    PVector vel=obj.vel.copy();
    if (vel.magSq()<0.1)vel=new PVector(0, 1, 0);
    targetCamEye=PVector.sub(pos, vel.mult(10));
    targetCamCenter=PVector.add(pos, vel.mult(10));
  }
  float lerpVal=0.1;
  camEye=lerpVec(camEye, targetCamEye, lerpVal);
  camCenter=lerpVec(camCenter, targetCamCenter, lerpVal);
  camera(camEye.x, camEye.y, camEye.z, camCenter.x, camCenter.y, camCenter.z, 0, 1, 0);
  line(0, 0, 0, xdepth, 0, 0);
  line(0, 0, 0, 0, ydepth, 0);
  line(0, 0, 0, 0, 0, zdepth);
  line(xdepth, ydepth, zdepth, 0, ydepth, zdepth);
  line(xdepth, ydepth, zdepth, xdepth, 0, zdepth);
  line(xdepth, ydepth, zdepth, xdepth, ydepth, 0);
  doUpdate();
  for (Boid b : boids) {
    b.display();
  }
  for (Predator p : preds) {
    p.display();
  }
}
void doUpdate() {
  for (Boid b : boids) {
    b.update();
  }
  for (Boid b : boids) {
    b.applyUpdate();
  }
  for (Predator p : preds) {
    p.update();
  }
  for (Predator p : preds) {
    p.applyUpdate();
  }
}