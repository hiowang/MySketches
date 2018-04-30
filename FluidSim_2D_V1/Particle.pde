float scalarCenterOfMass(float dist){
  //return 0.1;
  if(dist>200)return 0;
  if(dist>100)return 0.001;
  return 0.005;
}
float scalarSep(float dist){
  if(dist>50)return 0;
  return 0.001;
}
int totalID=0;
class Particle{
  PVector pos;
  PVector vel;
  PVector acc;
  int id;
  Particle(PVector p){
    pos=p;
    id=totalID;
    totalID++;
    vel=new PVector();
    acc=new PVector();
  }
  void update(boolean debugDraw){
    PVector com=new PVector();
    int numCom=0;
    for(Particle p:particles){
      if(id==p.id)continue;
      float scalar=scalarCenterOfMass(PVector.dist(pos,p.pos));
      PVector v=PVector.sub(p.pos,pos).mult(scalar);
      if(scalar>0)numCom++;
      com.add(v);
    }
    if(numCom>10)com.mult(0.1);
    vel.add(com);
    
    PVector sep=new PVector();
    for(Particle p:particles){
      if(id==p.id)continue;
      float scalar=scalarSep(PVector.dist(pos,p.pos));
      PVector v=PVector.sub(pos,p.pos).mult(scalar);
      sep.add(v);
      //if(debugDraw&&scalar>0){
      //  stroke(255,0,0,1);
      //  line(pos.x,pos.y,p.pos.x,p.pos.y);
      //}
    }
    vel.add(sep);
    
    pos.add(vel);
    vel.add(acc);
    
    vel.mult(0.99);
    
    //vel.add(0,0.01);
  }
  void display(){
    fill(0);
    stroke(100);
    ellipse(pos.x,pos.y,10,10);
  }
}