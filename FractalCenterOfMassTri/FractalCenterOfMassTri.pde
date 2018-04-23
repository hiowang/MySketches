class Tri {
  PVector a, b, c;
  Tri(PVector a, PVector b, PVector c) {
    this.a=a;
    this.b=b;
    this.c=c;
  }
  ArrayList<Tri>makeNew() {
    ArrayList<Tri>list=new ArrayList<Tri>();
    PVector p=PVector.add(PVector.add(a, b), c).mult(1.0/3.0);
    list.add(new Tri(a, b, p));
    list.add(new Tri(a, p, c));
    list.add(new Tri(p, b, c));
    return list;
  }
  void display(color col) {
    stroke(col);
    noFill();
    beginShape();
    vertex(a.x, a.y);
    vertex(b.x, b.y);
    vertex(c.x, c.y);
    endShape(CLOSE);
  }
}
ArrayList<Tri>work=new ArrayList<Tri>(), finished=new ArrayList<Tri>();
void setup() {
  size(600, 500);
  //work.add(new Tri(new PVector(width/2, 10), new PVector(width-10, height-10), new PVector(10, height-10)));
  work.add(new Tri(new PVector(0,0),new PVector(width,0),new PVector(0,height)));
  work.add(new Tri(new PVector(width,height),new PVector(width,0),new PVector(0,height)));
}
boolean workFirst=false;
void keyPressed() {
  if (key=='w')workFirst=!workFirst;
}
color workCol=color(255,20);
color finCol=color(0,20);
void draw() {
  background(255);
  if (workFirst) {
    for (Tri t : work) {
      t.display(workCol);
    }
  }
  for (Tri t : finished) {
    t.display(finCol);
  }
  if (!workFirst) {
    for (Tri t : work) {
      t.display(workCol);
    }
  }
}
void mousePressed() {
  ArrayList<Tri>list=new ArrayList<Tri>();
  for (Tri t : work)list.addAll(t.makeNew());
  finished.addAll(work);
  work.clear();
  work.addAll(list);
}