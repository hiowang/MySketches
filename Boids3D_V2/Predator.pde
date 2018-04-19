class Predator {
  PVector pos, vel, acc, npos, nvel, nacc;
  int id=0;
  Predator() {
    pos=getRandom().mult(random(size));
    vel=new PVector(0, 0, 0);
    acc=new PVector(0, 0, 0);
    id=totalID;
    totalID++;
  }
  Predator(PVector p) {
    pos=p;
    vel=new PVector(0, 0, 0);
    acc=new PVector(0, 0, 0);
    id=totalID;
    totalID++;
  }
  PVector normVel(float f){
    PVector p=vel.copy();
    p.normalize();
    p.setMag(f);
    return p;
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
      stroke(0,50);
      line(pos.x,pos.y,pos.z,b.pos.x,b.pos.y,b.pos.z);
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
    if (pos.mag()>size) {
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
    //stroke(50);
    noStroke();
    //pushMatrix();
    //rotateY(rot);
    //translate(xoff,yoff,zoff);
    if(followPred&&predToFollow==this)fill(0,255,0);
    translate(pos.x, pos.y, pos.z);
    box(10);
    translate(-pos.x,-pos.y,-pos.z);
    //rotateY(-rot);
    //popMatrix();
  }
}