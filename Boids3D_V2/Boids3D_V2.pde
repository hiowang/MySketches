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

float boidStayInBorders=0.001;
float boidSeePredDist=80;
float boidRunFromPred=0.25;

float boidAlignDist=0;
float boidPVel=0;

float boidAttractDist=2000;
float boidCenterOfMass=10;//position

float boidRepelDist=0;
float boidRepel=0;
float boidRandom=0.0;//0.01
float boidMaxVel=3;

float rot=0;

float predFunc(float num){
  return 1;
}
PVector getRandom() {
  return new PVector(random(-1,1),random(-1,1),random(-1,1)).normalize();
}

ArrayList<Boid>boids;
ArrayList<Predator>preds;

void setup(){
  size(1000,1000,P3D);
  boids=new ArrayList<Boid>();
  preds=new ArrayList<Predator>();
  for(int i=0;i<1000;i++){
    boids.add(new Boid());
  }
}
void draw(){
  background(100);
  camera(600,-400,600,0,0,0,0,1,0);
  //rot+=0.001;
  pointLight(255,255,255,0,0,0);
  for(Predator p:preds){
    p.display();
    p.update();
  }
  for(Boid b:boids){
    b.display();
    b.update();
  }
  for(Boid b:boids){
    b.applyUpdate();
  }
  noFill();
  rotateY(rot);
  stroke(120);
  sphereDetail(10);
  sphere(size);
  rotateY(-rot);
}