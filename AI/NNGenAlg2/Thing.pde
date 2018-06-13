float VIEW_FORWARD=200;
float VIEW_LEFT=200;
float VIEW_RIGHT=200;

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
    if (obstacleForward()!=0.0)fill(0, 0, 255);
    ellipse(x, y, size*2, size*2);
    stroke(0,20);
    line(x, y, x+vx*20, y+vy*20);
  }
  void displayAsOK() {
    fill(255, 200, 200);
    stroke(0);
    ellipse(x, y, size*2, size*2);
    drawPath();
  }
  void drawPath() {
    noFill();
    stroke(0, 20);
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
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
  PVector getVel() {
    float[]ins=new float[]{ finishLeft(), finishRight(), obstacleForward(), finishForward(), 1.0};
    net.calc(ins);
    float[]outs=net.getOutputs();
    return new PVector(outs[0], outs[1]);
  }
  float dist;

  float obstacleForward() {
    PVector pos=new PVector(x, y);
    for (int i=0; i<VIEW_FORWARD; i++) {
      pos.x+=vx;
      pos.y+=vy;
      for (Obstacle o : obstacles)if (dist(pos.x, pos.y, o.x, o.y)<o.r+size)return 1.0;
    }
    return 0.0;
  }
  float finishLeft(){
    PVector pos=new PVector(x,y);
    PVector dir=new PVector(vx,vy).rotate(radians(90));
    for(int i=0;i<VIEW_LEFT;i++){
      pos.x+=dir.x;
      pos.y+=dir.y;
      if(dist(pos.x,pos.y,finalCenter.x,finalCenter.y)<finalRad+size)return 1.0;
    }
    return 0.0;
  }
  float finishRight(){
    PVector pos=new PVector(x,y);
    PVector dir=new PVector(vx,vy).rotate(radians(-90));
    for(int i=0;i<VIEW_RIGHT;i++){
      pos.x+=dir.x;
      pos.y+=dir.y;
      if(dist(pos.x,pos.y,finalCenter.x,finalCenter.y)<finalRad+size)return 1.0;
    }
    return 0.0;
  }
  float finishForward() {
    PVector pos=new PVector(x, y);
    for (int i=0; i<VIEW_FORWARD; i++) {
      pos.x+=vx;
      pos.y+=vy;
      if (dist(pos.x, pos.y, finalCenter.x, finalCenter.y)<finalRad+size)return 1.0;
    }
    return 0.0;
  }

  void update() {
    if (dead)return;
    if (good)return;
    dist=dist(x, y, finalCenter.x, finalCenter.y);
    if (dist<finalRad+size) {
      hitGoodTime=population.time;
      good=true;
    }
    PVector acc=getVel();
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
    for (Obstacle o : obstacles)if (dist(x, y, o.x, o.y)<o.r+size)dead=true;
  }
}