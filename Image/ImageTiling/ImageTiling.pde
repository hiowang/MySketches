abstract class Thing{
  float rad;
  PVector center;
  boolean done=false;
  color colfill=color(0);
  color colstroke=color(255);
  boolean canCollideWithAnythingElse(){
    for(Thing t:things)if(collide(t))return true;
    return false;
  }
  abstract boolean isPointInShape(float x,float y);
  abstract float dRadius();
  boolean placedWell=true;
  Thing(){
    rad=2;
    center=new PVector(random(width),random(height));
    int iters=0;
    while(canCollideWithAnythingElse()&&iters<200){
      center=new PVector(random(width),random(height));
      iters++;
    }
    if(iters>190){
      placedWell=false;
    }
    colfill=colstroke=img.get(int(center.x),int(center.y));
    targetRad=rad;
  }
  abstract void display();
  abstract boolean collide(Thing other);
  float targetRad;
  float lerpRate=0.1;
  void update(){
    //if(done)return;
    done=false;
    for(Thing t:things){
      if(t==this)continue;
      //if(PVector.dist(center,t.center)<rad/2+t.rad/2)done=true;
      if(collide(t)){
        done=true;
      }
    }
    //if(done)lerpRate=0.1;
    //else targetRad=dRadius()*2;
    
    if(!done)lerpRate=0.1;
    //else lerpRate=-0.1;
    
    if(!done)targetRad+=dRadius();
    //targetRad+=dRadius();
    if(!done)rad=lerp(rad,targetRad,lerpRate);
    //else rad-=0.01;
  }
}
class ThingCircle extends Thing{
  boolean collide(Thing other){
    //float off=rad/3;
    if(other instanceof ThingCircle){
      ThingCircle c=(ThingCircle)other;
      return PVector.dist(center,c.center)<rad/2+c.rad/2;
    }
    if(other instanceof ThingRect){
      return other.collide(this);
      //return false;
    }
    return false;
  }
  void display(){
    fill(colfill);
    stroke(colstroke);
    ellipse(center.x,center.y,rad,rad);
  }
  float dRadius(){
    return 3;
  }
  boolean isPointInShape(float x,float y){
    return dist(center.x,center.y,x,y)<rad/2;
  }
}
class ThingRect extends Thing{
  float drad;
  ThingRect(){
    super();
    drad=random(3,5)-3;
  }
  boolean collide(Thing other){
    if(other instanceof ThingRect){
      ThingRect r=(ThingRect)other;
      return r.isPointInShape(center.x-rad,center.y-rad)||r.isPointInShape(center.x-rad,center.y+rad)||r.isPointInShape(center.x+rad,center.y-rad)||r.isPointInShape(center.x+rad,center.y+rad);
      //return isPointInShape(r.center.x-r.rad,r.center.y-r.rad)
          //|| isPointInShape(r.center.x+r.rad,r.center.y-r.rad)
          //|| isPointInShape(r.center.x-r.rad,r.center.y+r.rad)
          //|| isPointInShape(r.center.x+r.rad,r.center.y+r.rad);
    }
    if(other instanceof ThingCircle){
      ThingCircle c=(ThingCircle)other;
      return c.isPointInShape(center.x-rad,center.y-rad)
          || c.isPointInShape(center.x+rad,center.y-rad)
          || c.isPointInShape(center.x-rad,center.y+rad)
          || c.isPointInShape(center.x+rad,center.y+rad);
    }
    return false;
  }
  float dRadius(){
    return drad;
  }
  boolean isPointInShape(float x,float y){
    //return x>center.x-rad&&x<center.x+rad&&y>center.y-rad&&y<center.y+rad;
    return constrain(x,center.x-rad,center.x+rad)==x&&constrain(y,center.y-rad,center.y+rad)==y;
  }
  void display(){
    fill(colfill);
    stroke(colstroke);
    //beginShape();
    //vertex(center.x-rad,center.y-rad);
    //vertex(center.x+rad,center.y-rad);
    //vertex(center.x-rad,center.y+rad);
    //vertex(center.x+rad,center.y+rad);
    //endShape();
    beginShape();
    vertex(center.x-rad,center.y-rad);
    vertex(center.x+rad,center.y-rad);
    vertex(center.x+rad,center.y+rad);
    vertex(center.x-rad,center.y+rad);
    endShape(CLOSE);
  }
}
PImage img;
void setup(){
  size(500,666);
  //img.loadPixels();
  img=loadImage("ZoeBackgroundMin1.jpg");
  doInit();
  frameRate(1000);
}
void mousePressed(){
  doInit();
}
void keyPressed(){
}
void addThing(Thing thing){
  if(thing.placedWell)things.add(thing);
}
void draw(){
  background(0);
  if(key=='d'&&keyPressed){
    for(int i=0;i<things.size();i++){
      Thing t=things.get(i);
      if(t.isPointInShape(mouseX,mouseY))things.remove(t);
    }
  }
  for(Thing t:things){
    t.display();
    t.update();
  }
  for(int i=0;i<10;i++){
    //if(random(100)<0.1)
    addThing(new ThingRect());
    //else
      //addThing(new ThingCircle());
  }
}
ArrayList<Thing>things;
void doInit(){
  things=new ArrayList<Thing>();
  //addThing(new ThingRect());
  //for(int i=0;i<50000;i++)things.add(new ThingCircle());
}