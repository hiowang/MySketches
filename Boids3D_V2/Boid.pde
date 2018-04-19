
class Boid {
  PVector pos, vel, acc;
  PVector npos, nvel, nacc;
  int id=0;
  Boid() {
    pos=getRandom().mult(random(size));
    vel=new PVector(0,0);
    acc=new PVector(0,0);
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
    if (pos.mag()>size) {
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
    //stroke(50);
    noStroke();
    pushMatrix();
    //translate(xoff,yoff,zoff);
    rotateY(rot);
    translate(pos.x, pos.y, pos.z);
    box(5);
    popMatrix();
  }
}