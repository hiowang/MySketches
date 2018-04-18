ArrayList<PVector>points=new ArrayList<PVector>();
int totalID=0;
class Triangle {
  PVector a, b, c;
  int id;
  Triangle(PVector a, PVector b, PVector c) {
    this.a=a;
    this.b=b;
    this.c=c;
    id=totalID;
    totalID++;
  }
  PVector uncommon(Triangle o) {
    ArrayList<PVector>p=new ArrayList<PVector>();
    p.add(a);
    p.add(b);
    p.add(c);
    if (!p.contains(o.a))return o.a;
    if (!p.contains(o.b))return o.b;
    if (!p.contains(o.c))return o.c;
    return null;
  }
}
class Circle {
  float x, y, r;
  Circle(float a, float b, float c) {
    x=a;
    y=b;
    r=c;
  }
  boolean contains(PVector p) {
    return contains(p.x, p.y);
  }
  boolean contains(float a, float b) {
    return dist(a, b, x, y)<r/2;
  }
}
ArrayList<Triangle>tris=new ArrayList<Triangle>();
void setup() {
  size(500, 500);
  for (int i=0; i<4; i++)points.add(new PVector(random(width), random(height)));
}
void mousePressed() {
  points.add(new PVector(mouseX, mouseY));
}
void keyPressed() {
  if (key==' ') {
    calcTris();
  }
}
void calcTris() {
  tris=new ArrayList<Triangle>();
  tris.add(new Triangle(points.get(0), points.get(1), points.get(2)));
  tris.add(new Triangle(points.get(3), points.get(1), points.get(2)));
  for (Triangle t1 : tris) {
    for (Triangle t2 : tris) {
      if (t1.id==t2.id)continue;
      Circle c1=circum(t1);
      Circle c2=circum(t2);
      PVector un1=t1.uncommon(t2);
      PVector un2=t2.uncommon(t1);
      //if(uncommon==null)return;
      if (c1.contains(un1)||c2.contains(un2)) {
        background(200, 200, 255);
      }
      fill(0, 255, 0);
      ellipse(un1.x, un1.y, 10, 10);
      ellipse(un2.x, un2.y, 10, 10);
    }
  }
}
Circle circum(Triangle t) {
  float midx=0;
  float midy=0;
  float ax=t.a.x;
  float ay=t.a.y;
  float bx=t.b.x;
  float by=t.b.y;
  float cx=t.c.x;
  float cy=t.c.y;

  float c=sq(ax)+sq(ay)-sq(bx)-sq(by);
  float d=c/(2*ay-2*by);
  float f=(-ax+bx)/(ay-by);
  float g=sq(ax)+sq(ay)-sq(cx)-sq(cy);
  float h=g/(2*ay-2*cy);
  float j=-(ax-cx)/(ay-cy);

  midx=(d-h)/(j-f);
  midy=d+f*midx;

  float dist=dist(midx, midy, t.a.x, t.a.y)*2;

  return new Circle(midx, midy, dist);
}
void draw() {
  background(255);
  calcTris();
  for (PVector p : points) {
    fill(0);
    stroke(0);
    ellipse(p.x, p.y, 5, 5);
  }
  points.set(0, new PVector(mouseX, mouseY));
  for (Triangle t : tris) {
    stroke(0);
    noFill();
    line(t.a.x, t.a.y, t.b.x, t.b.y);
    line(t.b.x, t.b.y, t.c.x, t.c.y);
    line(t.c.x, t.c.y, t.a.x, t.a.y);
    stroke(0, 255, 0);
    //PVector mid=PVector.add(PVector.add(t.a,t.b),t.c).mult(1.0/3.0);
    Circle c=circum(t);
    ellipse(c.x, c.y, c.r, c.r);
    fill(255, 0, 0);
    stroke(255, 0, 0);
    ellipse(c.x, c.y, 10, 10);
  }
}