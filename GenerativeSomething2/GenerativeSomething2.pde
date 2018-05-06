//Insipred by: https://www.fal-works.com/creative-coding-posts/generative-something
class Thing{
  PVector pos,vel,acc;
  Thing(float x,float y){
    pos=new PVector(x,y);
    vel=new PVector(0,0);
    acc=new PVector(0,0);
  }
  float zoom=0.1;
  void update(int i){
    float x=noise(i*100,0+frameCount*zoom)-0.5;
    float y=noise(i*100,100+frameCount*zoom)-0.5;
    acc.x+=x*20;
    acc.y+=y*20;
    acc.mult(0.1);
    vel.add(acc);
    if(vel.mag()>10)vel.setMag(10);
    pos.add(vel);
    if(pos.x<0)vel.x*=-1;
    if(pos.y<0)vel.y*=-1;
    if(pos.x>width)vel.x*=-1;
    if(pos.y>height)vel.y*=-1;
  }
}
ArrayList<Thing>things;
void setup(){
  size(1024,1024);
  things=new ArrayList<Thing>();
  background(255);
  for(int i=0;i<10;i++){
    addThing(random(width),random(height));
  }
}
void addThing(float x,float y){
  Thing t=new Thing(x,y);
  things.add(t);
}
void mousePressed(){
  addThing(mouseX,mouseY);
}
void draw(){
  if(frameCount>60*5)return;
  println(frameCount);
  //blendMode(ADD);
  noStroke();
  fill(255,30);
  //rect(0,0,width,height);
  
  stroke(0,noise(frameCount*0.01)*100+155,0,20);
  noFill();
  //fill(0,1);
  beginShape();
  for(Thing t:things){
    curveVertex(t.pos.x,t.pos.y);
  }
  endShape();
  for(Thing t:things){
    fill(0);
    //ellipse(t.pos.x,t.pos.y,2,2);
  }
  for(int i=0;i<things.size();i++){
    things.get(i).update(i);
    //poithingsnts.set(i,new PVector(x,y));
  }
}