float predFunc(float numBoids){
  //\frac{e^{\left(x-10\right)}}{20000}+1
  return exp(numBoids-3);
}
int totalID=0;
class Predator{
  PVector pos,vel,acc,npos,nvel,nacc;
  int id=0;
  Predator(){
    this(new PVector(random(width),random(height)));
  }
  Predator(PVector p){
    pos=p;
    vel=new PVector(0,0);
    acc=new PVector(0,0);
    id=totalID;
    totalID++;
  }
  void update(){
    npos=pos.copy();
    nvel=vel.copy();
    nacc=acc.copy();
    this.npos=this.pos.add(this.vel);
    this.nvel=this.vel.add(this.acc);
    
    
    PVector attack=new PVector(0,0);
    int num=0;
    for(Boid b:boids){
      if(PVector.dist(pos,b.pos)>predSeeDist)continue;
      attack.add(PVector.sub(b.pos,pos));
      num++;
    }
    attack.mult(predAttack);
    attack.mult(predFunc(num));
    //nvel=(attack);
    nvel=nvel.add(attack);
    if(num<3)nvel.mult(0.75);
    //nvel.mult(0.5);
    if(this.nvel.mag()>predMaxVel)this.nvel.setMag(predMaxVel);
    
    
    if(this.npos.x<0)this.npos.x=width-10;
    if(this.npos.y<0)this.npos.y=height-10;
    if(this.npos.x>width)this.npos.x=10;
    if(this.npos.y>height)this.npos.y=10;
    float rand=predRandom;
    if(num>3)rand=0;
    this.nacc=this.acc.add(getRandom().mult(rand));
  }
  void applyUpdate(){
    pos=npos.copy();
    vel=nvel.copy();
    acc=nacc.copy();
  }
  void display(){
    fill(200,0,0);
    stroke(50);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(vel.heading()-radians(90));
    float r=10;
    beginShape();
    vertex(0,r*2);
    vertex(-r/2,0);
    vertex(r/2,0);
    endShape(CLOSE);
    popMatrix();
  }
}
class Boid{
  PVector pos,vel,acc;
  PVector npos,nvel,nacc;
  int id=0;
  Boid(){
    this(new PVector(random(width),random(height)));
  }
  Boid(PVector pos){
    id=totalID;
    totalID++;
    this.pos=pos;
    this.vel=new PVector(0,0);
    this.acc=new PVector(0,0);
  }
  void update(){
    this.npos=pos.copy();
    this.nvel=vel.copy();
    this.nacc=acc.copy();
    this.npos=this.pos.add(this.vel);
    this.nvel=this.vel.add(this.acc);
    
    this.nacc=this.acc.add(getRandom().mult(boidRandom));
    
    PVector com=new PVector(0,0);
    int n=0;
    for(Boid b:boids){
      if(b.id==id)continue;
      if(PVector.dist(pos,b.pos)>boidAttractDist)continue;
      com.add(b.pos);
      n++;
      //stroke(0,10);
      //line(pos.x,pos.y,b.pos.x,b.pos.y);
    }
    if(n!=0)com=com.mult(1.0/n);
    com=com.sub(this.pos);
    com=com.mult(boidCenterOfMass);
    
    this.nvel=this.nvel.add(com);
    
    PVector repel=new PVector(0,0);
    for(Boid b:boids){
      if(b.id==id)continue;
      if(PVector.dist(pos,b.pos)>boidRepelDist)continue;
      repel=repel.sub(PVector.sub(b.pos,pos));
    }
    repel=repel.mult(boidRepel);
    this.nvel=this.nvel.add(repel);
    
    PVector pvel=new PVector(0,0);//p=percieved
    
    for(Boid b:boids){
      if(b.id==id)continue;
      if(PVector.dist(pos,b.pos)>boidAlignDist)continue;
      pvel=pvel.add(b.vel);
    }
    pvel=pvel.mult(boidPVel);
    this.nvel=this.nvel.add(pvel);
    
    PVector runFromPred=new PVector(0,0);
    for(Predator p:preds){
      if(PVector.dist(p.pos,pos)>boidSeePredDist)continue;
      runFromPred.add(PVector.sub(pos,p.pos));
    }
    runFromPred.mult(boidRunFromPred);
    nvel=nvel.add(runFromPred);
    
    if(this.nvel.mag()>boidMaxVel)this.nvel.setMag(boidMaxVel);
    
    if(this.npos.x<0)this.npos.x=width;
    if(this.npos.y<0)this.npos.y=height;
    if(this.npos.x>width)this.npos.x=0;
    if(this.npos.y>height)this.npos.y=0;
  }
  void applyUpdate(){
    pos=npos.copy();
    vel=nvel.copy();
    acc=nacc.copy();
  }
  void display(){
    fill(200);
    stroke(50);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(vel.heading()-radians(90));
    float r=5;
    beginShape();
    vertex(0,r*2);
    vertex(-r/2,0);
    vertex(r/2,0);
    endShape(CLOSE);
    popMatrix();
    //ellipse(pos.x-5,pos.y-5,10,10);
  }
}
PVector getRandom(){
  float ang=random(TWO_PI);
  return new PVector(cos(ang),sin(ang));
}
ArrayList<Boid>boids;
ArrayList<Predator>preds;
PFont font;

float predSeeDist=50;
float predAttack=1;
float predMaxVel=10;
float predRandom=1;

float boidSeePredDist=50;
float boidRunFromPred=0.25;
float boidAlignDist=50;
float boidAttractDist=50;
float boidRepelDist=10;
float boidRepel=0.25;
float boidCenterOfMass=0.01;//position
float boidPVel=0.05;
float boidRandom=0.01;
float boidMaxVel=3;
void setup(){
  fullScreen();
  //size(750,750);
  doInit();
  font=loadFont("Monospaced-12.vlw");
  textFont(font); 
  doInit();
}
void doInit(){
  boids=new ArrayList<Boid>();
  preds=new ArrayList<Predator>();
  for(int i=0;i<1250;i++){
    boids.add(new Boid());
  }
}
void keyPressed(){
  for(int i=0;i<1;i++){
    preds.add(new Predator());
  }
}
void draw(){
  //background(100,100,200);
  background(255);
  //noStroke();
  //fill(255,1);
  //rect(0,0,width,height);
  doUpdate();
  for(Boid b:boids){
    b.display();
  }
  for(Predator p:preds){
    p.display();
  }
}
void doUpdate(){
  for(Boid b:boids){
    b.update();
  }
  for(Boid b:boids){
    b.applyUpdate();
  }
  for(Predator p:preds){
    p.update();
  }
  for(Predator p:preds){
    p.applyUpdate();
  }
}