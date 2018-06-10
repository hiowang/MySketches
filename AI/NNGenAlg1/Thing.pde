class Thing{
  Network net;
  float x,y,vx,vy;
  float size;
  Thing(){
    size=5.0;
    float posOff=0;
    float velOff=0;
    x=width/2+random(-posOff,posOff);
    y=height-100+random(-posOff,posOff);
    vx=random(-velOff,velOff);
    vy=random(-velOff,velOff);
    int numInputs=5;
    int numLayers=2;
    int numHidden=4;
    int numOutput=2;
    net=new Network(numInputs,numLayers,numHidden,numOutput);
  }
  float hitGoodTime=-1;
  boolean good=false;
  boolean dead=false;
  void display(){
    fill(255);
    stroke(0);
    if(good)fill(200,255,200);
    ellipse(x,y,size*2,size*2);
  }
  void displayAsBest(){
    fill(255,0,0);
    stroke(0);
    ellipse(x,y,size*2,size*2);
  }
  void vary(){
    net.varyInPlace();
  }
  Thing makeNew(){
    Thing t=new Thing();
    //t.x=x;
    //t.y=y;
    //t.vx=vx;
    //t.vy=vy;
    t.net=net.makeNew();
    //t.size=size;
    return t;
  }
  float dist;
  void update(){
    if(dead)return;
    if(good)return;
    dist=dist(x,y,finalCenter.x,finalCenter.y);
    if(dist<finalRad+size){
      hitGoodTime=population.time;
      good=true;
    }
    float[]ins=new float[]{map(x,0,width,-1,1),map(y,0,height,-1,1),vx,vy,1.0};
    net.calc(ins);
    float[]outs=net.getOutputs();
    PVector acc=new PVector(outs[0],outs[1]);
    acc.setMag(1);
    vx=acc.x;
    vy=acc.y;
    //acc.setMag(0.001);
    //vx+=acc.x;
    //vy+=acc.y;
    x+=vx;
    y+=vy;
    if(x<0||y<0||x>width||y>height)dead=true;
    if(dist(x,y,obstCenter.x,obstCenter.y)<obstRad+size)dead=true;
  }
}