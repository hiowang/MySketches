//float xdepth=500;
//float ydepth=500;
//float zdepth=500;
float size=500;
int totalID=0;

float predSeeDist=100;
float predAttack=1;
float predMaxVel=4;
float predRandom=0;//1
float predStayInBorders=0.01;

float boidStayInBorders=0.1;
float boidSeePredDist=80;
float boidRunFromPred=0.25;

float boidAlignDist=30;
float boidPVel=0.05;

float boidAttractDist=100;
float boidCenterOfMass=0.01;//position

float boidRepelDist=20;
float boidRepel=0.1;

float boidRandom=0.0;//0.01
float boidMaxVel=3;

float rot=0;

float predFunc(float num) {
  return 1;
}
PVector getRandom() {
  return new PVector(random(-1, 1), random(-1, 1), random(-1, 1)).normalize();
}

ArrayList<Boid>boids;
ArrayList<Predator>preds;

void setup() {
  size(1000, 1000, P3D);
  boids=new ArrayList<Boid>();
  preds=new ArrayList<Predator>();
  for (int i=0; i<750; i++) {
    boids.add(new Boid());
  }
}

Boid boidToFollow;
boolean followBoid=false;

Predator predToFollow;
boolean followPred=false;

PVector cam=new PVector(600, -400, 600);
PVector look=new PVector(0, 0, 0);

PVector curCam=new PVector(600, -400, 600);
PVector curLook=new PVector(0, 0, 0);

PVector lerp(PVector a, PVector b, float c) {
  return new PVector(lerp(a.x, b.x, c), lerp(a.y, b.y, c), lerp(a.z, b.z, c));
}

void keyPressed() {
  if (key=='b') {
    backTarg=color(255);
    boidToFollow=boids.get(int(random(boids.size())));
    followBoid=true;
    followPred=false;
    near=0.01;
    //fPos=fLook=0.01;
    fPos=0.025;
    fLook=0.025;
  }
  if (key=='p') {
    if (preds.size()==0)return;
    
    backTarg=color(255,240,240);
    predToFollow=preds.get(int(random(preds.size())));
    followPred=true;
    followBoid=false;
    near=0.01;
    fPos=fLook=0.05;
  }
  if (key==' ') {
    backTarg=color(255);
    followBoid=false;
    followPred=false;
    fPos=fLook=0.01;
  }
  if (key=='e') {
    for (int i=0; i<50; i++)boids.add(new Boid());
  }
  if (key=='w') {
    preds.add(new Predator());
    near=((height/2.0) / tan(PI*60.0/360.0))/10;
  }
}

color backTarg=color(255);
color backCur=color(255);

float backF=0.05;

color ambientTarg=color(50);
color ambientCur=color(50);

float ambF=0.01;

float near=1;
float fPos=0.01, fLook=0.01;
void draw() {
  background(red(backCur),green(backCur),blue(backCur));
  //float cameraZ=((height/2.0) / tan(PI*60.0/360.0));
  //rot+=0.01;
  float fov=PI/3;
  float aspect=width/height;
  //float near=0.001;
  float far=2000;
  perspective(fov, aspect, near, far);
  ambientLight(red(ambientCur), green(ambientCur), blue(ambientCur));
  float rCur=red(ambientCur);
  float gCur=green(ambientCur);
  float bCur=blue(ambientCur);

  float rTarg=red(ambientTarg);
  float gTarg=green(ambientTarg);
  float bTarg=blue(ambientTarg);
  ambientCur=color(lerp(rCur, rTarg, ambF), lerp(gCur, gTarg, ambF), lerp(bCur, bTarg, ambF));
  
  
  
  rCur=red(backCur);
  gCur=green(backCur);
  bCur=blue(backCur);

  rTarg=red(backTarg);
  gTarg=green(backTarg);
  bTarg=blue(backTarg);
  backCur=color(lerp(rCur, rTarg, backF), lerp(gCur, gTarg, backF), lerp(bCur, bTarg, backF));

  if (followBoid) {
    cam=PVector.sub(boidToFollow.pos,boidToFollow.normVel(10));
    look=PVector.add(cam, PVector.mult(boidToFollow.vel, 10));
  } else if (followPred) {
    cam=PVector.sub(predToFollow.pos,predToFollow.normVel(30));
    look=PVector.add(cam, PVector.mult(predToFollow.vel, 10));
  } else {
    cam=new PVector(600, -400, 600);
    look=new PVector(0, 0, 0);
  }
  //float fPos=0.05;
  //float fLook=0.05;
  curCam=lerp(curCam, cam, fPos);
  curLook=lerp(curLook, look, fLook);
  camera(curCam.x, curCam.y, curCam.z, curLook.x, curLook.y, curLook.z, 0, 1, 0);
  //rot+=0.01;
  pointLight(255, 255, 255, 0, 0, 0);
  rotateY(rot);
  for (Predator p : preds) {
    p.display();
    p.update();
  }
  for (Boid b : boids) {
    b.display();
    b.update();
  }
  for (Boid b : boids) {
    b.applyUpdate();
  }
  noFill();
  //rotateY(rot);
  stroke(120);
  sphereDetail(10);
  sphere(size);
  rotateY(-rot);
}