class Particle{
  PVector lastVert;
  PVector pos;
  Particle(){
    pos=new PVector(width/2,height/2);
    lastVert=new PVector(-1,-1);
  }
  void update(){
    PVector v=verts.get(int(random(verts.size())));
    while(!isValidVertexSwap(lastVert,v)){
      v=verts.get(int(random(verts.size())));
    }
    float oldx=pos.x;
    float oldy=pos.y;
    pos.x=pos.x/2+v.x/2;
    pos.y=pos.y/2+v.y/2;
    lastVert=v.copy();
    //stroke(0,5);
    //line(oldx,oldy,pos.x,pos.y);
  }
  void display(){
    //stroke(color(255,0,0,20));
    set(int(pos.x),int(pos.y),color(255,0,0));
    //fill(0);
    //rect(pos.x-5,pos.y-5,10,10);
  }
  
}
boolean isValidVertexSwap(PVector a,PVector b){
  int ia=verts.indexOf(a);
  int ib=verts.indexOf(b);
  //return ia!=ib;
  return ia!=(ib+3)%4;
  //return ia!=(ib);
  //return ia!=ib+1&&ia!=ib+3;
}
int mod(int a,int b){
  if(a<0)while(a<b)a+=b;
  while(a>b)a-=b;
  return a;
}
ArrayList<PVector>verts=new ArrayList<PVector>();
ArrayList<Particle>particles=new ArrayList<Particle>();
void setup(){
  size(1024,1024);
  verts.add(new PVector(0,0));
  verts.add(new PVector(width,0));
  verts.add(new PVector(0,height));
  verts.add(new PVector(width,height));
  for(int i=0;i<500000;i++)particles.add(new Particle());
}
void draw(){
  background(255);
  iterate();
  for(Particle p:particles)p.display();
  surface.setTitle("ChaosGame, frameRate="+nf(frameRate,2,3));
}
void mousePressed(){
  iterate();
}
void iterate(){
  for(Particle p:particles)p.update();
}