
int totalID=0;
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
    
    this.nacc=this.acc.add(getRandom().mult(valRandom));
    
    PVector com=new PVector(0,0);
    int n=0;
    for(Boid b:boids){
      if(b.id==id)continue;
      if(PVector.dist(pos,b.pos)>attractDist)continue;
      com.add(b.pos);
      n++;
      //stroke(0,10);
      //line(pos.x,pos.y,b.pos.x,b.pos.y);
    }
    if(n!=0)com=com.mult(1.0/n);
    com=com.sub(this.pos);
    com=com.mult(valCenterOfMass);
    
    this.nvel=this.nvel.add(com);
    
    PVector repel=new PVector(0,0);
    for(Boid b:boids){
      if(b.id==id)continue;
      if(PVector.dist(pos,b.pos)>repelDist)continue;
      repel=repel.sub(PVector.sub(b.pos,pos));
    }
    repel=repel.mult(valRepel);
    this.nvel=this.nvel.add(repel);
    
    PVector pvel=new PVector(0,0);//p=percieved
    
    for(Boid b:boids){
      if(b.id==id)continue;
      if(PVector.dist(pos,b.pos)>alignDist)continue;
      pvel=pvel.add(b.vel);
    }
    pvel=pvel.mult(valPVel);
    this.nvel=this.nvel.add(pvel);
    
    if(this.nvel.mag()>maxVel)this.nvel.setMag(maxVel);
    
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
PFont font;

float alignDist=50;
float attractDist=50;
float repelDist=10;
float valRepel=0.1;
float valCenterOfMass=0.01;//position
float valPVel=0.01;
float valRandom=0.01;
float maxVel=5;
void setup(){
  size(750,750);
  doInit();
  font=loadFont("Monospaced-12.vlw");
  textFont(font); 
  doInit();
}
void doInit(){
  boids=new ArrayList<Boid>();
  for(int i=0;i<300;i++){
    boids.add(new Boid());
  }
}
void draw(){
  background(255);
  doUpdate();
  for(Boid b:boids){
    b.display();
  }
}
void doUpdate(){
  for(Boid b:boids){
    b.update();
  }
  for(Boid b:boids){
    b.applyUpdate();
  }
}