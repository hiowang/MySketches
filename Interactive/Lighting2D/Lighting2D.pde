class Light {
  float r, g, b;
  int x;
  int y;
  float falloff=1.0/16.0;
  float mult=1.0/5.0;
  Light(int x, int y) {
    this.x=x;
    this.y=y;
    colorMode(HSB, 100);
    color col=color(random(100), 100, 100);
    colorMode(RGB, 255);
    r=red(col);
    g=green(col);
    b=blue(col);
  }
}
float[][]rcomps, gcomps, bcomps;
int gridw=100;
int gridh=100;
int cellw=500/gridw;
int cellh=500/gridh;
void settings() {
  size(gridw*cellw, gridh*cellh);
}
void setup() {
  lights=new ArrayList<Light>();
  //for(int i=0;i<gridw;i++){
  //  Light l=new Light(i,0);
  //  //l.r=l.g=l.b=1;
  //  lights.add(l);
  //}
  calcLights();
}
ArrayList<Light>lights;
void calcLights() {
  rcomps=new float[gridw][gridh];
  gcomps=new float[gridw][gridh];
  bcomps=new float[gridw][gridh];
  for (int x=0; x<gridw; x++) {
    for (int y=0; y<gridh; y++) {
      rcomps[x][y]=0;
      gcomps[x][y]=0;
      bcomps[x][y]=0;
    }
  }
  for (Light l : lights) {
    calcLight(l);
  }
}
ArrayList<PVector>walls=new ArrayList<PVector>();
void calcLight(Light l) {
  ArrayList<PVector>posses=new ArrayList<PVector>();
  posses.add(new PVector(l.x, l.y, 1.0));//z component is strength
  ArrayList<PVector>done=new ArrayList<PVector>();
  while (posses.size()>0) {
    PVector p=posses.get(0);
    posses.remove(0);
    if (!done.contains(p)&&!walls.contains(new PVector(p.x,p.y))) {
      done.add(p);
      if (p.z>0) {
        int ix=int(p.x);
        int iy=int(p.y);
        rcomps[ix][iy]+=l.r*p.z*l.mult;
        gcomps[ix][iy]+=l.g*p.z*l.mult;
        bcomps[ix][iy]+=l.b*p.z*l.mult;
        float s=p.z;
        if(ix>0)posses.add(new PVector(ix-1,iy,s-l.falloff));
        if(iy>0)posses.add(new PVector(ix,iy-1,s-l.falloff));
        if(ix<gridw-1)posses.add(new PVector(ix+1,iy,s-l.falloff));
        if(iy<gridh-1)posses.add(new PVector(ix,iy+1,s-l.falloff));
        
      }
    }
  }
}
void mousePressed() {
  if(mouseButton==RIGHT)return;
  lights.add(new Light(mouseX/cellw, mouseY/cellh));
  calcLights();
}
void mouseDragged(){
  if(mouseButton==LEFT)return;
  PVector p=new PVector(mouseX/cellw,mouseY/cellh);
  if(!walls.contains(p)){
    walls.add(p);
    calcLights();
  }
}
void draw() {
  background(0);
  for (int x=0; x<gridw; x++) {
    for (int y=0; y<gridh; y++) {
      fill(rcomps[x][y], gcomps[x][y], bcomps[x][y]);
      if(walls.contains(new PVector(x,y)))fill(0,255,0);
      stroke(40);
      rect(x*cellw, y*cellh, cellw, cellh);
    }
  }
}