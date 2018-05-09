float colSpeed=0.0125;

//1000x1000,10000,0.01
void setup() {
  size(1024,1024);
  //size(500,500);
  //size(1000, 1000);
  //fullScreen();
  seed=new Thing(width/2, height/2);
  seed.done=true;
  seed.col=color(255, 200, 200);
  for (int i=0; i<10000; i++) {
    things.add(new Thing(random(width),random(height)));
  }
  //things.add(seed);
}
int numDone=0;
void draw() {
  background(0);
  println(numDone);
  surface.setTitle("DLALine, frameRate="+nf(frameRate,2,3));
  //for (int i=0; i<5; i++) {
  //if(numDone<600)
  //for(int i=0;i<30;i++)things.add(new Thing(random(width), random(height)));
  //}
  //for (int i=0; i<10; i++) {
    for (Thing t : things) {
      t.update(frameCount);
    }
  //}
  for(Thing t:things){
    if(!t.done)continue;  
    t.display();
  }
  //seed.display();
  if(numNotDone()>0){
    saveFrame("data/frame-#####.png");
  }
}
int numNotDone(){
  int i=0;
  for(Thing t:things){
    if(!t.done)i++;
  }
  return i;
}
Thing seed;
ArrayList<Thing>things=new ArrayList<Thing>();
class Thing {
  float x, y;
  float r;
  color stroke=color(250);
  color col;
  boolean done=false;
  Thing(float x, float y) {
    this.x=x;
    this.y=y;
    this.r=7.5;
    this.col=color(255);
  }
  void display() {
    fill(col);
    //stroke(stroke);
    noStroke();
    ellipseMode(CENTER);
    ellipse(x, y, r, r);
  }
  void update(int frames) {
    if (done)return;
    float a=0;
    if (x<a)x=width-a;
    if (y<a)y=height-a;
    if (x>width-a)x=a;
    //if (y>height-a)y=a;
    if (collides()||y>=height) {
      //if(collidesOther()){
      done=true;
      numDone++;
      //col=color(255, 200, 200);
      colorMode(HSB, 100);
      col=color((frameCount*colSpeed)%100, 100, 100);
      colorMode(RGB, 255);
    } else {

      float b=30;
      x+=random(-b, b);
      y+=random(-b, b);
      //y+=2;
    }
    //r+=1;
  }
  boolean collides() {
    for (Thing t : things) {
      if (t==this)continue;
      if (!t.done)continue;
      if (collides(t))return true;
    }
    return false;
  }
  boolean collidesOther() {
    for (Thing t : things) {
      if (t==this)continue;
      //if (!t.done)continue;
      if (collides(t))return true;
    }
    return false;
  }
  boolean collides(Thing other) {
    return dist(x, y, other.x, other.y)<other.r/2+r/2;
  }
}