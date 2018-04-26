import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
ArrayList<Thing>things;
Box2DProcessing box2d;
void setup() {
  size(500, 500);
  org.jbox2d.common.Settings.maxPolygonVertices=10;
  textFont(loadFont("Monospaced-15.vlw"));
  box2d=new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -50);
  things=new ArrayList<Thing>();
  things.add(new Box(0,350,150,10,false));
  things.add(new Box(150,100,350,10,false));
  things.add(new Box(0,height-10,width,10,false));
  things.add(new Box(width-10,0,10,height,false));
  things.add(new Box(280,350-40,10,20,false));
  things.add(new Box(0,0,width,10,false));
  things.add(new Box(0,0,10,height,false));
  //boxes.add(new Box(
  //boxes.add(new Box(width/2,10,width,20,false));
  //boxes.add(new Box(width/2+1000,height-10,width,20,false));
  //boxes.add(new Box(10,height/2,20,height,false));
  //boxes.add(new Box(height-10,height/2,20,height,false));
  //boxes.add(new Box(100, 300,10, 20, true, 0, 10, 10));
}
void mouseDragged(){
  float r=random(100);
  if(r<45)things.add(new Ellipse(mouseX,mouseY,5,5,true));
  else if(r<90)things.add(new Box(mouseX,mouseY,5,5,true));
  else things.add(new NGon(mouseX,mouseY,int(random(5,10)),2,true));
}
long startTime,endTime;
void startTiming(){
  startTime=System.currentTimeMillis();
}
long endTiming(){
  endTime=System.currentTimeMillis();
  return endTime-startTime;
}
void draw() {
  background(255);
  startTiming();
  box2d.step();
  long stepTime=endTiming();
  startTiming();
  for (Thing t : things)t.display();
  long drawTime=endTiming();
  fill(255,0,0);
  textAlign(LEFT,TOP);
  //text("frameRate: "+frameRate+"\nframeCount: "+frameCount+"\n# things: "+(things.size()-7)+"\nstepTime: "+stepTime+"\ndrawTime: "+drawTime+"\ntotalTime: "+(drawTime+stepTime),0,0);
  //thing.display();
}