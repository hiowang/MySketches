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

float boidStayInBorders=0.01;
float boidSeePredDist=80;
float boidRunFromPred=0.25;
float boidAlignDist=30;
float boidAttractDist=30;
float boidRepelDist=20;
float boidRepel=0.1;
float boidCenterOfMass=0.01;//position
float boidPVel=0.05;
float boidRandom=0.01;//0.01
float boidMaxVel=3;

float rot=0;

float predFunc(float num){
  return 1;
}
PVector getRandom() {
  float ang=random(TWO_PI);
  return new PVector(cos(ang), sin(ang), random(-1, 1));
}

ArrayList<Boid>boids;
ArrayList<Predator>preds;

void setup(){
  size(1000,1000,P3D);
  boids=new ArrayList<Boid>();
  preds=new ArrayList<Predator>();
  for(int i=0;i<100;i++){
    boids.add(new Boid());
  }
}
void draw(){
  background(255);
  camera(400,-400,400,0,0,0,0,1,0);
  //rot+
  rot+=0.001;
  for(Predator p:preds){
    p.display();
    p.update();
  }
  for(Boid b:boids){
    b.display();
    b.update();
  }
  //translate(250,250,250);
  noFill();
  rotateY(rot);
  stroke(0);
  sphereDetail(10);
  sphere(size);
  rotateY(-rot);
  //translate(-250,-250,-250);
}