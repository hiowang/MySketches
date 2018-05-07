class Planet {
  float mass, x, y, z, r;
  float vx, vy, vz, ax, ay, az;
  int id=0;
  boolean dead=false;
  boolean stuck=false;
  float range,h;
  Planet(float range,float h) {
    this.range=range;
    this.h=h;
    float ang=random(TWO_PI);
    float cur_r=random(range);
    x=cos(ang)*cur_r;
    z=sin(ang)*cur_r;
    y=random(-h,h);
    if(totalID<1){
      stuck=true;
      x=y=z=0;
    }
    if(stuck){
      mass=5;
      r=10;
    }else{
      mass=0.1;
      r=20;
    }
    vx=vy=vz=ax=ay=az=0;
    id=totalID;
    totalID++;
  }
  void display(float scale) {
    //ellipseMode(CENTER);
    noStroke();
    fill(50);
    if(stuck)fill(150,0,0);
    translate(x/scale,y/scale,z/scale);
    if(planets.size()>150)box(r/scale);
    else sphere(r/scale);
    translate(-x/scale,-y/scale,-z/scale);
    if(stuck){
      //if(true){
      stroke(0,50);
      //line(x/scale,y/scale,z/scale,0,y/scale,z/scale);
      //line(x/scale,y/scale,z/scale,x/scale,0,z/scale);
      //line(x/scale,y/scale,z/scale,x/scale,y/scale,0);
    }
    //ellipse(x, y, r, r);
  }
  void update() {
    if(stuck)r=50;
    for (Planet p : planets) {
      if (p.id==id)continue;
      //if (p.dead)continue;
      if (dead)continue;
      float dist=dist(x, y, z,p.x, p.y,p.z);
      float forceMag=forceCalc(this,p);
      float accMag=forceMag/mass;
      if (dist<r/2+p.r/2) {
        //accMag=0;
        Planet newP=new Planet(range,h);
        newP.x=(p.x+x)/2;
        newP.y=(p.y+y)/2;
        newP.z=(p.z+z)/2;
        newP.r=(p.r+r)/2+5;
        newP.mass=p.mass+mass;
        newP.vx=(p.vx+vx)/2;
        newP.vy=(p.vy+vy)/2;
        newP.vz=(p.vz+vz)/2;
        newP.ax=(p.ax+ax)/2;
        newP.ay=(p.ay+ay)/2;
        newP.az=(p.az+az)/2;
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
      az+=accMag*(p.z-z);
    }
    //if (!stuck) {
      ax=constrain(ax, -maxAcc, maxAcc);
      ay=constrain(ay, -maxAcc, maxAcc);
      az=constrain(az, -maxAcc, maxAcc);
      vx=constrain(vx, -maxVel, maxVel);
      vy=constrain(vy, -maxVel, maxVel);
      vz=constrain(vz, -maxVel, maxVel);
      if(stuck){
        ax*=stuckAcc;
        ay*=stuckAcc;
        az*=stuckAcc;
        vx*=stuckVel;
        vy*=stuckVel;
        vz*=stuckVel;
      }
      vx+=ax;
      vy+=ay;
      vz+=az;
      x+=vx;
      y+=vy;
      z+=vz;
    //}
  }
}
//G*m^2/d^2
float forceCalc(Planet a,Planet b){
  if(a.id==b.id)return 0;
  float dist=dist(a.x,a.y,a.z,b.x,b.y,b.z);
  return GravConst*(a.mass)*(b.mass)/sq(dist);
}
float stuckAcc=1;
float stuckVel=0.75;
float maxAcc=1;
float maxVel=30;
float GravConst=100;
int totalID=0;