void setup() {
  size(1000, 1000);
  doInit();
}
void doInit(){
  background(0);
  osn=new OpenSimplexNoise((long)(Math.random()*Long.MAX_VALUE));
  things=new ArrayList<Thing>();
  for (int i=0; i<10000; i++) {
    things.add(new Thing());
  }
}
void mousePressed(){
  doInit();
}
void keyPressed(){
  if(key=='1')scale+=0.1;
  if(key=='2')scale-=0.1;
}
//PVector mouse;
void draw() {
  //mouse=new PVector(mouseX, mouseY);
  //ellipse(mouse.x,mouse.y,10,10);
  translate(width/2,height/2);
  scale(scale);
  for (Thing t : things) {
    for (int i=0; i<5; i++) {
      t.update();
      t.display();
    }
  }
  println(mi+" "+ma);
}
float scale=1;
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
    acc.x+=cos(noise(pos.x, pos.y)*TWO_PI)*0.0001;
    acc.y+=sin(noise(pos.x, pos.y)*TWO_PI)*0.0001;
    vel.x+=acc.x*speed;
    vel.y+=acc.y*speed;
    vel.setMag(speed);
    //vel.x/=(abs(mouseX-pmouseX)<2?2:;
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
    color col=color(vel.mag()*noise(pos.x, pos.y)*255/2+255/2);
    //colorMode(HSB,255,100,100);
    //color col=color(vel.mag()*noise(pos.x, pos.y)*255/2+255/2,100,100);
    //colorMode(RGB,255);
    //col=color(255);
    fill(col);
    noStroke();
    //ellipse(pos.x,pos.y,10,10);
    int offx=width/2;
    int offy=height/2;
    set(int(pos.x*scale)+offx, int(pos.y*scale)+offy, col);
  }
}
float mi=100000,ma=-10000;
OpenSimplexNoise osn;
float noise(float x, float y) {
  float f=(float)osn.eval(x*0.01, y*0.01);
  f=map(f,-0.8660254038,0.8660254038,-1,1);
  if(f<mi)mi=f;
  if(f>ma)ma=f;
  return f;
}