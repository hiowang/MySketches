class Thing {
  Network net;
  float x, y, vx, vy;
  float size;
  ArrayList<PVector>points;
  Thing() {
    points=new ArrayList<PVector>();
    size=5.0;
    float posOff=0;
    float velOff=0;
    x=width/2+random(-posOff, posOff);
    y=height-100+random(-posOff, posOff);
    vx=random(-velOff, velOff);
    vy=random(-velOff, velOff);
    int numInputs=5;
    int numLayers=5;
    int numHidden=5;
    int numOutput=2;//neural network art
    net=new Network(numInputs, numLayers, numHidden, numOutput);
  }
  float hitGoodTime=-1;
  boolean good=false;
  boolean dead=false;
  void display() {
    fill(255);
    stroke(0);
    if (good)fill(200, 255, 200);
    ellipse(x, y, size*2, size*2);
  }
  void displayAsOK(){
    fill(255, 200, 200);
    stroke(0);
    ellipse(x, y, size*2, size*2);
    drawPath();
  }
  void drawPath(){
    noFill();
    stroke(0,20);
    beginShape();
    for (PVector p : points) {
      vertex(p.x,p.y);
    }
    endShape();
  }
  void displayAsBest() {
    fill(255, 0, 0);
    stroke(0);
    ellipse(x, y, size*2, size*2);
    drawPath();
  }
  void vary() {
    net.varyInPlace();
  }
  Thing makeNew() {
    Thing t=new Thing();
    //t.x=x;
    //t.y=y;
    //t.vx=vx;
    //t.vy=vy;
    t.net=net.makeNew();
    //t.size=size;
    return t;
  }
  PVector getVel(float theX,float theY,float theVX,float theVY){
    float[]ins=new float[]{map(theX, 0, width, -1, 1), map(theY, 0, height, -1, 1), theVX, theVY, 
      //map(finalCenter.x,0,width,-1,1),map(finalCenter.y,0,height,-1,1),
      1.0};
    net.calc(ins);
    float[]outs=net.getOutputs();
    return new PVector(outs[0], outs[1]);
  }
  float dist;
  void update() {
    if (dead)return;
    if (good)return;
    dist=dist(x, y, finalCenter.x, finalCenter.y);
    if (dist<finalRad+size) {
      hitGoodTime=population.time;
      good=true;
    }
    PVector acc=getVel(x,y,vx,vy);
    acc.setMag(3);
    vx=acc.x;
    vy=acc.y;
    if (population.time%1==0)points.add(new PVector(x, y));
    //acc.setMag(0.001);
    //vx+=acc.x;
    //vy+=acc.y;
    x+=vx;
    y+=vy;
    if (x<0||y<0||x>width||y>height)dead=true;
    //if (dist(x, y, obstCenter.x, obstCenter.y)<obstRad+size)dead=true;
    for(Obstacle o:obstacles)if(dist(x,y,o.x,o.y)<o.r+size)dead=true;
  }
}