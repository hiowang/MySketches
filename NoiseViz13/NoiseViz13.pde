void setup() {
  size(1000, 1000);
  doInit();
}
void doInit(){
  background(0);
  osn=new OpenSimplexNoise((long)(Math.random()*Long.MAX_VALUE));
  things=new ArrayList<Thing>();
  for (int i=0; i<1000; i++) {
    things.add(new Thing());
  }
}
void mousePressed(){
  doInit();
}
PVector mouse;
void draw() {
  mouse=new PVector(mouseX, mouseY);
  //ellipse(mouse.x,mouse.y,10,10);
  for (Thing t : things) {
    for (int i=0; i<5; i++) {
      t.update();
      t.display();
    }
  }
}
ArrayList<Thing>things=new ArrayList<Thing>();
class Thing {
  PVector pos, vel, acc;
  float speed;
  Thing() {
    speed=random(0.1, 1);
    pos=new PVector(random(-100, 100), random(-100, 100));
    vel=new PVector(0, 0);
    acc=new PVector(0, 0);
  }
  void update() {
    //acc=acc.add(new PVector(mouseX-pos.x,mouseY-pos.y).mult(0.1));
    acc.x+=cos(noise(pos.x, pos.y)*PI)*0.0001;
    acc.y+=sin(noise(pos.x, pos.y)*PI)*0.0001;
    vel.x+=acc.x*speed;
    vel.y+=acc.y*speed;
    vel.setMag(speed);
    pos.x+=vel.x;
    pos.y+=vel.y;
    //if(pos.mag()>100){
      //scale=lerp(scale,-1,1);
      //vel.x/=0.5;
      //vel.y/=0.5;
    //}
    //acc=acc.add(mouse.mult(1));
    //vel=vel.add(acc);
    //pos=pos.add(vel);
  }
  void display() {
    color col=color(noise(pos.x, pos.y)*255/2+255/2);
    //col=color(255);
    fill(col);
    noStroke();
    //ellipse(pos.x+width/2,pos.y+height/2,10,10);
    set(int(pos.x)+width/2, int(pos.y)+height/2, col);
  }
}
OpenSimplexNoise osn;
float noise(float x, float y) {
  return (float)osn.eval(x*0.01, y*0.01);
}