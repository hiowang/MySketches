class Planet {
  float mass, x, y, r;
  float vx, vy, ax, ay;
  int id=0;
  boolean dead=false;
  boolean stuck=false;
  Planet() {
    x=random(-2500, 2500);
    y=random(-2500, 2500);
    if(totalID<1)stuck=true;
    if(stuck){
      mass=2;
      r=10;
    }else{
      mass=0.1;
      r=10;
    }
    vx=vy=ax=ay=0;
    id=totalID;
    totalID++;
  }
  void display() {
    ellipseMode(CENTER);
    fill(50);
    ellipse(x, y, r, r);
  }
  void update() {
    if(stuck)r=50;
    for (Planet p : planets) {
      if (p.id==id)continue;
      //if (p.dead)continue;
      if (dead)continue;
      float dist=dist(x, y, p.x, p.y);
      float forceMag=forceCalc(this,p);
      float accMag=forceMag/mass;
      if (dist<r/2+p.r/2) {
        //accMag=0;
        Planet newP=new Planet();
        newP.x=(p.x+x)/2;
        newP.y=(p.y+y)/2;
        newP.r=(p.r+r)/2+5;
        newP.mass=p.mass+mass;
        newP.vx=(p.vx+vx)/2;
        newP.vy=(p.vy+vy)/2;
        newP.ax=(p.ax+ax)/2;
        newP.ay=(p.ay+ay)/2;
        newP.stuck=stuck||p.stuck;
        toAdd.add(newP);
        toRem.add(this);
        toRem.add(p);
        dead=true;
        p.dead=true;
      }
      //}else{
      //stroke(0,map(forceMag,0,1,255,0));
      //line(x+width/2,y+height/2,p.x+width/2,p.y+height/2);
      //}
      ax+=accMag*(p.x-x);
      ay+=accMag*(p.y-y);
    }
    //if (!stuck) {
      ax=constrain(ax, -maxAcc, maxAcc);
      ay=constrain(ay, -maxAcc, maxAcc);
      vx=constrain(vx, -maxVel, maxVel);
      vy=constrain(vy, -maxVel, maxVel);
      if(stuck){
        ax*=stuckAcc;
        ay*=stuckAcc;
        vx*=stuckVel;
        vy*=stuckVel;
      }
      vx+=ax;
      vy+=ay;
      x+=vx;
      y+=vy;
    //}
  }
}
//G*m^2/d^2
float forceCalc(Planet a,Planet b){
  if(a.id==b.id)return 0;
  float dist=dist(a.x,a.y,b.x,b.y);
  return GravConst*sq(a.mass)*sq(b.mass)/sq(dist);
}
float stuckAcc=0;
float stuckVel=0;
float maxAcc=1;
float maxVel=30;
float GravConst=1;
int totalID=0;