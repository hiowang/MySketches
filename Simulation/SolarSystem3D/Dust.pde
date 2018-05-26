class Dust {
  float x, y, z, r;
  float vx, vy, vz, ax, ay, az;
  int id=0;
  float range,h;
  Dust(float range,float h) {
    this.range=range;
    this.h=h;
    float ang=random(TWO_PI);
    float cur_r=random(range);
    x=cos(ang)*cur_r;
    z=sin(ang)*cur_r;
    y=random(-h,h);
    r=1;
    vx=vy=vz=ax=ay=az=0;
    id=totalID;
    totalID++;
  }
  void display(float scale) {
    //ellipseMode(CENTER);
    noStroke();
    fill(0,0,0,20);
    translate(x/scale,y/scale,z/scale);
    box(10);
    translate(-x/scale,-y/scale,-z/scale);

  }
  void update() {
    for (Planet p : planets) {
      if (p.id==id)continue;
      float dist=dist(x, y, z,p.x, p.y,p.z);
      float forceMag=forceCalc(this,p);
      //if (dist<r/2+p.r/2) {
      //}
      //}else{
      //stroke(0,map(forceMag,0,1,255,0));
      //line(x+width/2,y+height/2,p.x+width/2,p.y+height/2);
      //}
      ax+=forceMag*(p.x-x);
      ay+=forceMag*(p.y-y);
      az+=forceMag*(p.z-z);
    }
    //if (!stuck) {
      ax=constrain(ax, -maxAccDust, maxAccDust);
      ay=constrain(ay, -maxAccDust, maxAccDust);
      az=constrain(az, -maxAccDust, maxAccDust);
      vx=constrain(vx, -maxVelDust, maxVelDust);
      vy=constrain(vy, -maxVelDust, maxVelDust);
      vz=constrain(vz, -maxVelDust, maxVelDust);

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
float forceCalc(Dust a,Planet b){
  if(a.id==b.id)return 0;
  float dist=dist(a.x,a.y,a.z,b.x,b.y,b.z);
  return GravConst*b.mass/sq(dist);
}
float stuckVelDust=0.75;
float maxAccDust=1;
float maxVelDust=30;
float GravConstDust=100;
int totalIDDust=0;