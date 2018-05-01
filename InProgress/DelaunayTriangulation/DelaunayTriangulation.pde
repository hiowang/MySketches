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
  ArrayList<PVector>getPoints() {
    ArrayList<PVector>p=new ArrayList<PVector>();
    p.add(a);
    p.add(b);
    p.add(c);
    return p;
  }
  boolean contains(float x, float y) {
    PVector p1=a;
    PVector p2=b;
    PVector p3=c;
    PVector p=new PVector(x, y);
    float alpha = ((p2.y - p3.y)*(p.x - p3.x) + (p3.x - p2.x)*(p.y - p3.y)) /
      ((p2.y - p3.y)*(p1.x - p3.x) + (p3.x - p2.x)*(p1.y - p3.y));
    float beta = ((p3.y - p1.y)*(p.x - p3.x) + (p1.x - p3.x)*(p.y - p3.y)) /
      ((p2.y - p3.y)*(p1.x - p3.x) + (p3.x - p2.x)*(p1.y - p3.y));
    float gamma = 1.0f - alpha - beta;
    return alpha>0&&beta>0&&gamma>0&&(!hasPointInABC(p));
  }
  boolean isBad() {
    return hasPointInABC(bad1)||hasPointInABC(bad2)||hasPointInABC(bad3);
  }
  boolean hasPointInABC(PVector p) {
    return a.equals(p)||b.equals(p)||c.equals(p);
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
  ArrayList<Line>getEdges() {
    ArrayList<Line>list=new ArrayList<Line>();
    list.add(new Line(a, b));
    list.add(new Line(b, c));
    list.add(new Line(c, a));
    return list;
  }
}
class Line {
  PVector a, b;
  Line(PVector x, PVector y) {
    a=x;
    b=y;
  }
}
ArrayList<Triangle>tris=new ArrayList<Triangle>();
void setup() {
  size(500, 500);
  //points.add(new PVector(200, 200));
  bad1=new PVector(width/2, 50);
  bad2=new PVector(50, height-50);
  bad3=new PVector(width-50, height-50);
  //bad2=new PVector(width,0);
  //bad3=new PVector(0,height);
  //for (int i=0; i<40; i++)points.add(new PVector(random(width), random(height)));
}
void mousePressed() {
  points.add(new PVector(mouseX, mouseY));
}
void keyPressed() {
  if (key==' ') {
    calcTris();
  }
}
int howManyTimesIsEdgeInTriangleList(ArrayList<Triangle>the_tris, Line l) {
  int i=0;
  for (Triangle t : the_tris) {
    if (t.getEdges().contains(l))i++;
  }
  return i;
}
Triangle formTriangle(PVector p, Line l) {
  return new Triangle(p, l.a, l.b);
}
void calcTris() {
  tris=new ArrayList<Triangle>();
  tris.clear();
  //if (points.size()<=2)return;
  println("NEW TRIANGULATION");
  println(points.size()+" points");
  //function BowyerWatson (pointList)
  // pointList is a set of coordinates defining the points to be triangulated
  //triangulation := empty triangle mesh data structure
  PVector x1=new PVector(10, 0), x2=new PVector(width, 10), x3=new PVector(20, height);
  tris.add(new Triangle(x1, x2, x3));
  for (PVector p : points) {
    boolean done=false;
    for (int i=0; i<tris.size()&&!done; i++) {
      Triangle t=tris.get(i);
      if (t.contains(p.x, p.y)) {
        tris.remove(t);
        tris.add(new Triangle(t.a, t.b, p));
        tris.add(new Triangle(t.a, p, t.c));
        tris.add(new Triangle(p, t.b, t.c));
        done=true;
      }
    }
    for (Triangle t1 : tris) {
      ArrayList<PVector>points1=t1.getPoints();
      if (circum(t1).isValid())continue; 
      for (Triangle t2 : tris) {
        if (circum(t2).isValid())continue;
        if (t1.id<=t2.id)continue;
        flipTris(t1, t2);
      }
    }
  }
  ArrayList<Triangle>bads=new ArrayList<Triangle>();
  for (Triangle t : tris) {
    ArrayList<PVector>points=t.getPoints();
    while (points.contains(x1))points.remove(x1);
    while (points.contains(x2))points.remove(x2);
    while (points.contains(x3))points.remove(x3);
    if (points.size()<=1)bads.add(t);
    //if(points.contains(x1)||points.contains(x2)||points.contains(x3)){
    //bads.add(t);
    //}
  }
  tris.removeAll(bads);
  //tris.add(new Triangle(x1, x2, x3));
}
void flipTris(Triangle t1, Triangle t2) {
  ArrayList<PVector>points1=t1.getPoints();
  ArrayList<PVector>points2=t2.getPoints();
  PVector uncommon1=t1.a;
  if (points2.contains(t1.a)) {
    if (points2.contains(t1.b)) {
      uncommon1=t1.c;
    } else {
      uncommon1=t1.b;
    }
  }
  PVector uncommon2=t2.a;
  if (points1.contains(t2.a)) {
    if (points1.contains(t2.b)) {
      uncommon2=t2.c;
    } else {
      uncommon2=t2.b;
    }
  }
  ArrayList<PVector>common=t1.getPoints();
  common.remove(uncommon1);
  PVector common1=common.get(0);
  PVector common2=common.get(1);
  t1.a=uncommon1;
  t1.b=uncommon2;
  t1.c=common1;
  
  t2.a=uncommon1;
  t2.b=uncommon1;
  t2.c=common2;
  println("flip "+common.size());
}
boolean isNotBad(PVector p) {
  return !isBad(p);
}
boolean isBad(PVector p) {
  return bad1.equals(p)||bad2.equals(p)||bad3.equals(p);
}
PVector bad1;
PVector bad2;
PVector bad3;
void draw() {
  background(255);
  calcTris();
  for (PVector p : points) {
    fill(0);
    stroke(0);
    ellipse(p.x, p.y, 5, 5);
  }
  //points.set(0, new PVector(mouseX, mouseY));
  for (Triangle t : tris) {
    stroke(0);
    noFill();

    line(t.a.x, t.a.y, t.b.x, t.b.y);
    line(t.b.x, t.b.y, t.c.x, t.c.y);
    line(t.c.x, t.c.y, t.a.x, t.a.y);
    Circle c=circum(t);
    stroke(0, 255, 0, 20);
    if (c.isValid())
      stroke(255, 0, 0, 20);
    ellipse(c.x, c.y, c.r, c.r);
    fill(255, 0, 0);
    stroke(255, 0, 0);
    ellipse(c.x, c.y, 10, 10);
  }
}