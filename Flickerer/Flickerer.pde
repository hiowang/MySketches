ArrayList<PVector>points=new ArrayList<PVector>();
void setup() {
  size(1024, 1024);
  background(255);
  for (int i=0; i<30; i++)points.add(new PVector(random(width), random(height)));
  for (int i=0; i<20; i++)things.add(new Thing());
}
ArrayList<Thing>things=new ArrayList<Thing>();
class Thing {
  PVector cur, last;
  Thing() {
    cur=points.get(int(random(points.size())));
    last=points.get(0);
  }
  void update() {
    if (frameCount%1==0) {
      PVector closest=new PVector(-10000, -10000);
      float closeDist=100000;
      for (PVector p : points) {
        if (p.equals(cur)||p.equals(last))continue;
        float d=PVector.dist(p, closest);
        if (d<closeDist||random(100)<10) {
          closeDist=d;
          closest=p.copy();
        }
      }
      last=cur.copy();
      cur=closest.copy();
    }
    stroke(255,20);
    line(cur.x, cur.y, last.x, last.y);
  }
}
void draw() {
  for (Thing t : things)t.update();
  fill(0,50);
  stroke(255);
  rect(0, 0, width, height);
  stroke(0);
  for (PVector p : points) {
    //fill(0, 0, 255);
    //stroke(0, 0, 255);
    //ellipse(p.x, p.y, 5, 5);
  }
  for (int i=0; i<points.size(); i++) {
    float zoom=0.01;
    float offx=noise(i*100, 0+frameCount*zoom)-0.5;
    float offy=noise(i*100, 100+frameCount*zoom)-0.5;
    PVector p=points.get(i).add(new PVector(offx, offy).mult(10));
    if (p.x<0)p.x=width;
    if (p.y<0)p.y=height;
    if (p.x>width)p.x=0;
    if (p.y>height)p.y=0;
    points.set(i, p);
  }
}